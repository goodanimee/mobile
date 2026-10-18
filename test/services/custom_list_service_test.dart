import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/proto/api.pb.dart';
import 'package:goodanime/services/custom_list_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CustomListService service;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    service = CustomListService.instance;
    service.reset();
  });

  tearDown(() {
    service.reset();
  });

  group('CustomListService persistence and hydration', () {
    test(
      'restores session state and custom lists from SharedPreferences',
      () async {
        SharedPreferences.setMockInitialValues({
          CustomListService.keyPanelOpen: true,
          CustomListService.keyAnimeCustomLists: ['Favorites', 'Classics'],
          CustomListService.keyMangaCustomLists: ['Reading Queue'],
        });

        await service.init();

        expect(service.isPanelOpen, isTrue);
        expect(service.getCustomLists('ANIME'), ['Favorites', 'Classics']);
        expect(service.getCustomLists('MANGA'), ['Reading Queue']);
      },
    );

    test('persists panel state changes to SharedPreferences', () async {
      await service.init();

      await service.setPanelOpen(true);
      expect(service.isPanelOpen, isTrue);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(CustomListService.keyPanelOpen), isTrue);

      await service.setPanelOpen(false);
      expect(service.isPanelOpen, isFalse);
      expect(prefs.getBool(CustomListService.keyPanelOpen), isFalse);
    });

    test('setCustomLists updates, deduplicates, and persists lists', () async {
      await service.init();

      await service.setCustomLists('ANIME', [
        '  Favorites  ',
        'Classics',
        'Favorites',
        '  ',
      ]);

      expect(service.getCustomLists('ANIME'), ['Favorites', 'Classics']);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList(CustomListService.keyAnimeCustomLists), [
        'Favorites',
        'Classics',
      ]);
      expect(service.getCustomLists('MANGA'), isEmpty);
    });
  });

  group('CustomListService validation and management', () {
    test('addCustomList rejects empty strings and duplicates', () async {
      await service.init();

      expect(await service.addCustomList('ANIME', '   '), isFalse);
      expect(await service.addCustomList('ANIME', 'Favorites'), isTrue);
      expect(await service.addCustomList('ANIME', 'favorites'), isFalse);
      expect(await service.addCustomList('ANIME', '  FAVORITES  '), isFalse);
      expect(service.getCustomLists('ANIME'), ['Favorites']);
      expect(service.getCustomLists('MANGA'), isEmpty);
    });

    test('deleteCustomList removes list case-insensitively', () async {
      await service.init();
      await service.setCustomLists('ANIME', ['Favorites', 'To Watch']);

      final deleted = await service.deleteCustomList('ANIME', 'favorites');
      expect(deleted, isTrue);
      expect(service.getCustomLists('ANIME'), ['To Watch']);

      final notFound = await service.deleteCustomList('ANIME', 'nonexistent');
      expect(notFound, isFalse);
    });

    test(
      'deleteCustomList successfully deletes the last remaining custom list',
      () async {
        await service.init();
        await service.setCustomLists('ANIME', ['OnlyList']);

        final deleted = await service.deleteCustomList('ANIME', 'OnlyList');
        expect(deleted, isTrue);
        expect(service.getCustomLists('ANIME'), isEmpty);
        final prefs = await SharedPreferences.getInstance();
        expect(
          prefs.getStringList(CustomListService.keyAnimeCustomLists),
          isEmpty,
        );
      },
    );

    test(
      'UpdateCustomListsResponse parses 0-byte buffer as empty lists without error',
      () {
        final response = UpdateCustomListsResponse.fromBuffer(Uint8List(0));
        expect(response.error, isEmpty);
        expect(response.animeCustomLists, isEmpty);
        expect(response.mangaCustomLists, isEmpty);
      },
    );

    test('reset clears all in-memory lists and states', () async {
      await service.init();
      await service.setPanelOpen(true);
      await service.setCustomLists('ANIME', ['Favorites']);

      service.reset();

      expect(service.isPanelOpen, isFalse);
      expect(service.isInitialized, isFalse);
      expect(service.getCustomLists('ANIME'), isEmpty);
      expect(service.getCustomLists('MANGA'), isEmpty);
    });
  });
}
