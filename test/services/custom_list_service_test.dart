import 'package:flutter_test/flutter_test.dart';
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

  group('CustomListService persistence (THE-160)', () {
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
  });

  group('CustomListService management', () {
    test(
      'adds custom list with sanitization, duplicate rejection, and persistence',
      () async {
        await service.init();

        final added = await service.addCustomList('ANIME', '   Favorites   ');
        expect(added, isTrue);
        expect(service.getCustomLists('ANIME'), ['Favorites']);

        expect(await service.addCustomList('ANIME', '   '), isFalse);
        expect(await service.addCustomList('ANIME', 'favorites'), isFalse);
        expect(service.getCustomLists('MANGA'), isEmpty);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getStringList(CustomListService.keyAnimeCustomLists), [
          'Favorites',
        ]);
      },
    );

    test('deletes custom list and updates persisted storage', () async {
      await service.init();
      await service.addCustomList('ANIME', 'Favorites');
      await service.addCustomList('ANIME', 'To Watch');

      final deleted = await service.deleteCustomList('ANIME', 'favorites');
      expect(deleted, isTrue);
      expect(service.getCustomLists('ANIME'), ['To Watch']);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList(CustomListService.keyAnimeCustomLists), [
        'To Watch',
      ]);
    });
  });
}
