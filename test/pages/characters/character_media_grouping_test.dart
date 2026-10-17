import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_character.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/media_staff.dart';
import 'package:goodanime/pages/characters/tabs/media_tab.dart';

MediaMin _createMedia({required int id, int? startYear}) {
  return MediaMin(
    id: id,
    type: 'ANIME',
    title: Title(
      english: 'Media $id',
      native: 'Media $id',
      romaji: 'Media $id',
      userPreferred: 'Media $id',
    ),
    averageScore: 80,
    coverImage: const CoverImage(
      medium: '',
      large: '',
      extraLarge: '',
      color: '#FFFFFF',
    ),
    episodes: 12,
    chapters: 0,
    volumes: 0,
    format: 'TV',
    isAdult: false,
    isFavourite: false,
    siteUrl: 'https://anilist.co/anime/$id',
    startYear: startYear,
  );
}

CharacterMediaEdge _createEdge({
  required int mediaId,
  int? startYear,
  String? role,
  List<StaffMin> voiceActors = const [],
}) {
  return CharacterMediaEdge(
    characterRole: role,
    node: _createMedia(id: mediaId, startYear: startYear),
    voiceActors: voiceActors,
  );
}

/// Unit tests for character media chronological grouping and role priority ordering.
void main() {
  group('groupCharacterMediaByYear & flattenCharacterMediaByYear', () {
    test(
      'groups character media appearances by release year and TBA bucket',
      () {
        final edges = [
          _createEdge(mediaId: 1, startYear: 2024, role: 'MAIN'),
          _createEdge(mediaId: 2, startYear: 2022, role: 'SUPPORTING'),
          _createEdge(mediaId: 3, role: 'MAIN'),
          const CharacterMediaEdge(voiceActors: []),
        ];

        final grouped = groupCharacterMediaByYear(edges);

        expect(grouped.keys.toList(), ['2024', '2022', 'TBA']);
        expect(grouped['2024']!.map((e) => e.node!.id), [1]);
        expect(grouped['2022']!.map((e) => e.node!.id), [2]);
        expect(grouped['TBA']!.map((e) => e.node!.id), [3]);
      },
    );

    test(
      'orders entries within each year by role priority (MAIN -> SUPPORTING -> BACKGROUND)',
      () {
        final edges = [
          _createEdge(mediaId: 10, startYear: 2023, role: 'BACKGROUND'),
          _createEdge(mediaId: 20, startYear: 2023, role: 'SUPPORTING'),
          _createEdge(mediaId: 30, startYear: 2023, role: 'MAIN'),
          _createEdge(mediaId: 40, startYear: 2023, role: 'SUPPORTING'),
          _createEdge(mediaId: 50, startYear: 2023, role: 'MAIN'),
        ];

        final grouped = groupCharacterMediaByYear(edges);

        expect(grouped['2023']!.map((e) => e.node!.id).toList(), [
          30,
          50,
          20,
          40,
          10,
        ]);

        final flatList = flattenCharacterMediaByYear(edges);
        expect(flatList.first, '2023');
        expect(
          flatList
              .skip(1)
              .cast<CharacterMediaEdge>()
              .map((e) => e.node!.id)
              .toList(),
          [30, 50, 20, 40, 10],
        );
      },
    );
  });

  group('formatCharacterRole & resolveCharacterVoiceActor', () {
    test('formats character role labels consistently', () {
      expect(formatCharacterRole('MAIN'), 'Main');
      expect(formatCharacterRole('supporting'), 'Supporting');
      expect(formatCharacterRole('BACKGROUND'), 'Background');
      expect(formatCharacterRole('CAMEO'), 'Cameo');
      expect(formatCharacterRole(null), '');
      expect(formatCharacterRole(''), '');
    });

    test(
      'resolves voice actor by language with case-insensitive match and fallback',
      () {
        const jpVa = StaffMin(
          id: 1,
          name: StaffName(full: 'Asami Imai'),
          languageV2: 'Japanese',
        );
        const enVa = StaffMin(
          id: 2,
          name: StaffName(full: 'Trina Nishimura'),
          languageV2: 'English',
        );
        const unknownLangVa = StaffMin(
          id: 3,
          name: StaffName(full: 'Fallback Actor'),
        );

        expect(resolveCharacterVoiceActor([jpVa, enVa], 'english')?.id, 2);
        expect(resolveCharacterVoiceActor([jpVa, enVa], 'Japanese')?.id, 1);
        expect(resolveCharacterVoiceActor([jpVa, enVa], 'German'), isNull);
        expect(resolveCharacterVoiceActor([unknownLangVa], 'Japanese')?.id, 3);
        expect(resolveCharacterVoiceActor([], 'Japanese'), isNull);
      },
    );
  });
}
