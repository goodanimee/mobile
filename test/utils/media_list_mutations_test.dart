import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_list.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/utils/media_list_mutations.dart';

MediaMin _createMedia({
  int id = 1,
  String type = 'ANIME',
  int episodes = 12,
  int chapters = 0,
  int volumes = 0,
}) {
  return MediaMin(
    id: id,
    type: type,
    title: const Title(
      english: 'Test Media',
      native: 'Test Media',
      romaji: 'Test Media',
      userPreferred: 'Test Media',
    ),
    averageScore: 80,
    coverImage: const CoverImage(
      medium: '',
      large: '',
      extraLarge: '',
      color: '#FFFFFF',
    ),
    episodes: episodes,
    chapters: chapters,
    volumes: volumes,
    format: type == 'MANGA' ? 'MANGA' : 'TV',
    isAdult: false,
    isFavourite: false,
    siteUrl: 'https://anilist.co/anime/$id',
    startYear: 2024,
  );
}

MediaListEntryWithMedia _createEntry({
  int id = 100,
  MediaListStatus? status = MediaListStatus.current,
  int progress = 0,
  double score = 0,
  int repeat = 0,
  int progressVolumes = 0,
  FuzzyDate? startedAt,
  FuzzyDate? completedAt,
  bool private = false,
  bool hiddenFromStatusLists = false,
  String notes = '',
  MediaMin? media,
}) {
  return MediaListEntryWithMedia(
    id: id,
    status: status,
    progress: progress,
    score: score,
    repeat: repeat,
    progressVolumes: progressVolumes,
    startedAt: startedAt,
    completedAt: completedAt,
    private: private,
    hiddenFromStatusLists: hiddenFromStatusLists,
    notes: notes,
    media: media ?? _createMedia(),
  );
}

/// Unit tests for [MediaListEntryMutation].
void main() {
  group('MediaListEntryMutation.incrementProgress', () {
    test(
      'increments anime progress by 1 and transitions planning to current',
      () {
        final entry = _createEntry(status: MediaListStatus.planning);

        final updated = entry.incrementProgress();

        expect(updated.progress, 1);
        expect(updated.status, MediaListStatus.current);
        expect(updated.startedAt?.hasDate, isTrue);
        expect(updated.completedAt, isNull);
      },
    );

    test(
      'transitions to completed and sets dates when reaching max episodes',
      () {
        final entry = _createEntry(progress: 11, media: _createMedia());

        final updated = entry.incrementProgress();

        expect(updated.progress, 12);
        expect(updated.status, MediaListStatus.completed);
        expect(updated.startedAt?.hasDate, isTrue);
        expect(updated.completedAt?.hasDate, isTrue);
      },
    );

    test('syncs manga volumes to max when final chapter is completed', () {
      final entry = _createEntry(
        progress: 99,
        progressVolumes: 8,
        media: _createMedia(
          type: 'MANGA',
          episodes: 0,
          chapters: 100,
          volumes: 10,
        ),
      );

      final updated = entry.incrementProgress();

      expect(updated.progress, 100);
      expect(updated.progressVolumes, 10);
      expect(updated.status, MediaListStatus.completed);
    });

    test('rolls over into repeating on +1 past maxProgress', () {
      final entry = _createEntry(
        status: MediaListStatus.completed,
        progress: 12,
        media: _createMedia(),
      );

      final updated = entry.incrementProgress();

      expect(updated.progress, 1);
      expect(updated.repeat, 1);
      expect(updated.progressVolumes, 0);
      expect(updated.status, MediaListStatus.repeating);
    });

    test('preserves repeating status while incrementing below maxProgress', () {
      final entry = _createEntry(
        status: MediaListStatus.repeating,
        progress: 3,
        repeat: 2,
        media: _createMedia(),
      );

      final updated = entry.incrementProgress();

      expect(updated.progress, 4);
      expect(updated.repeat, 2);
      expect(updated.status, MediaListStatus.repeating);
    });
  });

  group('MediaListEntryMutation.updateProgress', () {
    test('clamps non-+1 overflow to maxProgress and marks completed', () {
      final entry = _createEntry(progress: 4, media: _createMedia());

      final updated = entry.updateProgress(25);

      expect(updated.progress, 12);
      expect(updated.status, MediaListStatus.completed);
      expect(updated.repeat, 0);
    });

    test('undoes repeat when setting progress to 0 while repeat > 0', () {
      final entry = _createEntry(
        status: MediaListStatus.repeating,
        progress: 1,
        repeat: 2,
        media: _createMedia(
          type: 'MANGA',
          episodes: 0,
          chapters: 50,
          volumes: 5,
        ),
      );

      final updated = entry.updateProgress(0);

      expect(updated.progress, 50);
      expect(updated.progressVolumes, 5);
      expect(updated.repeat, 1);
      expect(updated.status, MediaListStatus.completed);
    });

    test(
      'resets progressVolumes to 0 when setting progress to 0 without repeat',
      () {
        final entry = _createEntry(
          progress: 10,
          progressVolumes: 2,
          media: _createMedia(
            type: 'MANGA',
            episodes: 0,
            chapters: 50,
            volumes: 5,
          ),
        );

        final updated = entry.updateProgress(0);

        expect(updated.progress, 0);
        expect(updated.progressVolumes, 0);
        expect(updated.status, MediaListStatus.current);
      },
    );

    test(
      'handles unknown maxProgress (0 episodes) without auto-completing',
      () {
        final entry = _createEntry(
          progress: 100,
          media: _createMedia(episodes: 0),
        );

        final updated = entry.incrementProgress();

        expect(updated.progress, 101);
        expect(updated.status, MediaListStatus.current);
      },
    );
  });

  group('MediaListEntryMutation.updateProgressVolumes', () {
    test('updates manga volumes and keeps current status below maxVolumes', () {
      final entry = _createEntry(
        progress: 10,
        progressVolumes: 1,
        media: _createMedia(
          type: 'MANGA',
          episodes: 0,
          chapters: 100,
          volumes: 10,
        ),
      );

      final updated = entry.updateProgressVolumes(3);

      expect(updated.progressVolumes, 3);
      expect(updated.progress, 10);
      expect(updated.status, MediaListStatus.current);
    });

    test(
      'marks manga completed and syncs chapters when reaching maxVolumes',
      () {
        final entry = _createEntry(
          progress: 85,
          progressVolumes: 9,
          media: _createMedia(
            type: 'MANGA',
            episodes: 0,
            chapters: 100,
            volumes: 10,
          ),
        );

        final updated = entry.updateProgressVolumes(10);

        expect(updated.progressVolumes, 10);
        expect(updated.progress, 100);
        expect(updated.status, MediaListStatus.completed);
        expect(updated.completedAt?.hasDate, isTrue);
      },
    );

    test('rolls over into repeating when volumes exceed maxVolumes', () {
      final entry = _createEntry(
        status: MediaListStatus.completed,
        progress: 100,
        progressVolumes: 10,
        repeat: 1,
        media: _createMedia(
          type: 'MANGA',
          episodes: 0,
          chapters: 100,
          volumes: 10,
        ),
      );

      final updated = entry.updateProgressVolumes(11);

      expect(updated.progressVolumes, 1);
      expect(updated.progress, 1);
      expect(updated.repeat, 2);
      expect(updated.status, MediaListStatus.repeating);
    });
  });

  group('MediaListEntryMutation.updateStatus, updateRepeat & date rules', () {
    test(
      'updateStatus to completed fills max progress, volumes, and dates',
      () {
        final entry = _createEntry(
          status: MediaListStatus.planning,
          progress: 2,
          progressVolumes: 1,
          media: _createMedia(
            type: 'MANGA',
            episodes: 0,
            chapters: 40,
            volumes: 4,
          ),
        );

        final updated = entry.updateStatus(MediaListStatus.completed);

        expect(updated.status, MediaListStatus.completed);
        expect(updated.progress, 40);
        expect(updated.progressVolumes, 4);
        expect(updated.startedAt?.hasDate, isTrue);
        expect(updated.completedAt?.hasDate, isTrue);
      },
    );

    test(
      'updateStatus to dropped sets both startedAt and completedAt if missing',
      () {
        final entry = _createEntry(
          status: MediaListStatus.planning,
          progress: 3,
        );

        final updated = entry.updateStatus(MediaListStatus.dropped);

        expect(updated.status, MediaListStatus.dropped);
        expect(updated.startedAt?.hasDate, isTrue);
        expect(updated.completedAt?.hasDate, isTrue);
      },
    );

    test(
      'preserves existing startedAt and completedAt dates when already set',
      () {
        const customStart = FuzzyDate(year: 2022, month: 5, day: 10);
        const customEnd = FuzzyDate(year: 2022, month: 6, day: 15);
        final entry = _createEntry(
          progress: 11,
          startedAt: customStart,
          completedAt: customEnd,
          media: _createMedia(),
        );

        final updated = entry.incrementProgress();

        expect(updated.status, MediaListStatus.completed);
        expect(updated.startedAt, customStart);
        expect(updated.completedAt, customEnd);
      },
    );

    test('updateRepeat updates the repeat counter directly', () {
      final entry = _createEntry();

      final updated = entry.updateRepeat(4);

      expect(updated.repeat, 4);
    });
  });

  group('MediaListEntryMutation.normalizeScore', () {
    test('clamps scores below 0.0 to 0.0', () {
      expect(MediaListEntryMutation.normalizeScore(-1.5), 0.0);
      expect(MediaListEntryMutation.normalizeScore(-0.01), 0.0);
    });

    test('clamps scores above 10.0 to 10.0', () {
      expect(MediaListEntryMutation.normalizeScore(10.01), 10.0);
      expect(MediaListEntryMutation.normalizeScore(15.2), 10.0);
    });

    test(
      'rounds to single decimal place eliminating IEEE 754 precision drift',
      () {
        expect(MediaListEntryMutation.normalizeScore(0.1 + 0.2), 0.3);
        expect(MediaListEntryMutation.normalizeScore(0.7 + 0.1), 0.8);
        expect(MediaListEntryMutation.normalizeScore(8.66), 8.7);
        expect(MediaListEntryMutation.normalizeScore(8.64), 8.6);
      },
    );

    test('leaves valid 1-decimal scores unchanged', () {
      expect(MediaListEntryMutation.normalizeScore(0.0), 0.0);
      expect(MediaListEntryMutation.normalizeScore(7.5), 7.5);
      expect(MediaListEntryMutation.normalizeScore(10.0), 10.0);
    });
  });

  group('MediaListEntryMutation score adjustments', () {
    test('updateScore sets and normalizes the score', () {
      final entry = _createEntry(score: 5.0);

      final updated = entry.updateScore(8.74);

      expect(updated.score, 8.7);
    });

    test('incrementScore increments by 0.1 and clamps at 10.0', () {
      final entry = _createEntry(score: 9.9);

      final next = entry.incrementScore();
      expect(next.score, 10.0);

      final clamped = next.incrementScore();
      expect(clamped.score, 10.0);
    });

    test('decrementScore decrements by 0.1 and clamps at 0.0', () {
      final entry = _createEntry(score: 0.1);

      final next = entry.decrementScore();
      expect(next.score, 0.0);

      final clamped = next.decrementScore();
      expect(clamped.score, 0.0);
    });

    test(
      '100-step walk from 0.0 to 10.0 and back in 0.1 increments has no float drift',
      () {
        var entry = _createEntry();

        for (var i = 1; i <= 100; i++) {
          entry = entry.incrementScore();
          final expected = (i / 10.0 * 10).round() / 10.0;
          expect(entry.score, expected);
        }
        expect(entry.score, 10.0);

        for (var i = 99; i >= 0; i--) {
          entry = entry.decrementScore();
          final expected = (i / 10.0 * 10).round() / 10.0;
          expect(entry.score, expected);
        }
        expect(entry.score, 0.0);
      },
    );

    test('supports custom step increments and decrements', () {
      final entry = _createEntry(score: 5.0);

      final incremented = entry.incrementScore(0.5);
      expect(incremented.score, 5.5);

      final decremented = entry.decrementScore(1.2);
      expect(decremented.score, 3.8);
    });
  });

  group('MediaListEntryMutation visibility and notes', () {
    test('updatePrivate updates the private flag', () {
      final entry = _createEntry();

      final updated = entry.updatePrivate(true);
      expect(updated.private, isTrue);

      final reverted = updated.updatePrivate(false);
      expect(reverted.private, isFalse);
    });

    test(
      'updateHiddenFromStatusLists updates the hiddenFromStatusLists flag',
      () {
        final entry = _createEntry();

        final updated = entry.updateHiddenFromStatusLists(true);
        expect(updated.hiddenFromStatusLists, isTrue);

        final reverted = updated.updateHiddenFromStatusLists(false);
        expect(reverted.hiddenFromStatusLists, isFalse);
      },
    );

    test('updateNotes updates the notes string', () {
      final entry = _createEntry();

      final updated = entry.updateNotes('Masterpiece of an anime!');
      expect(updated.notes, 'Masterpiece of an anime!');

      final cleared = updated.updateNotes('');
      expect(cleared.notes, '');
    });
  });
}
