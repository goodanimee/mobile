import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_list.dart';
import 'package:goodanime/models/media_list_entry.dart';
import 'package:goodanime/proto/media_list.pb.dart' as pb_list;
import 'package:goodanime/proto/media_list_entry.pb.dart' as pb_entry;

/// Unit tests for media list model conversions and properties.
void main() {
  group('MediaListEntry', () {
    test('supports customLists in fromProto and toProto', () {
      final pbObj = pb_entry.MediaListEntry(
        id: 123,
        progress: 5,
        score: 8.5,
        repeat: 1,
        progressVolumes: 0,
        private: false,
        hiddenFromStatusLists: false,
        notes: 'Great',
        customLists: ['Favorites', 'Top 10'],
      );

      final entry = MediaListEntry.fromProto(pbObj);
      expect(entry.id, 123);
      expect(entry.customLists, ['Favorites', 'Top 10']);

      final serialized = entry.toProto() as pb_entry.MediaListEntry;
      expect(serialized.customLists, ['Favorites', 'Top 10']);
    });

    test('copyWith updates customLists', () {
      const entry = MediaListEntry(
        id: 1,
        progress: 0,
        score: 0,
        repeat: 0,
        progressVolumes: 0,
        customLists: ['List A'],
      );

      final updated = entry.copyWith(customLists: ['List B', 'List C']);
      expect(updated.customLists, ['List B', 'List C']);
    });
  });

  group('MediaList', () {
    test('supports isCustomList in fromProto and toProto', () {
      final pbGroup = pb_list.MediaListGroup(
        name: 'My Special List',
        isCustomList: true,
      );

      final list = MediaList.fromProto(pbGroup);
      expect(list.name, 'My Special List');
      expect(list.isCustomList, isTrue);

      final serialized = list.toProto();
      expect(serialized.isCustomList, isTrue);
    });
  });
}
