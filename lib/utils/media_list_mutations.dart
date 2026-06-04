import '../models/common.dart';
import '../models/media_list.dart';

/// Extension for media list entry mutation business logic
extension MediaListEntryMutation on MediaListEntryWithMedia {
  /// Computes the next entry state when progress is incremented by 1
  MediaListEntryWithMedia incrementProgress() {
    return updateProgress(progress + 1);
  }

  /// Computes the next entry state when progress is set to a specific value
  MediaListEntryWithMedia updateProgress(int newProgress) {
    final now = DateTime.now();
    final fuzzyNow = FuzzyDate(year: now.year, month: now.month, day: now.day);

    final isManga = media.type == 'MANGA';
    final int? maxProgress = isManga
        ? (media.chapters > 0 ? media.chapters : null)
        : (media.episodes > 0 ? media.episodes : null);
    final int? maxProgressVolumes = isManga
        ? (media.volumes > 0 ? media.volumes : null)
        : null;

    int nextProgress = newProgress;
    int nextRepeat = repeat;
    int nextProgressVolumes = progressVolumes;
    MediaListStatus nextStatus = status ?? MediaListStatus.current;
    FuzzyDate? nextStartDate = startedAt;
    FuzzyDate? nextFinishDate = completedAt;

    final isOverflow = maxProgress != null && newProgress > maxProgress;
    if (isOverflow) {
      if (newProgress == progress + 1) {
        nextProgress = 1;
        nextRepeat = repeat + 1;
        nextProgressVolumes = 0;
        nextStatus = MediaListStatus.repeating;
        return copyWith(
          progress: nextProgress,
          repeat: nextRepeat,
          progressVolumes: nextProgressVolumes,
          status: nextStatus,
        );
      } else {
        nextProgress = maxProgress;
      }
    }

    final isUndoingRepeat =
        newProgress == 0 && repeat > 0 && maxProgress != null;
    if (isUndoingRepeat) {
      nextProgress = maxProgress;
      if (maxProgressVolumes != null) {
        nextProgressVolumes = maxProgressVolumes;
      }
      nextRepeat = repeat - 1;
      nextStatus = MediaListStatus.completed;
      return copyWith(
        progress: nextProgress,
        progressVolumes: nextProgressVolumes,
        repeat: nextRepeat,
        status: nextStatus,
      );
    }

    nextProgress = newProgress;
    if (nextProgress == 0) {
      nextProgressVolumes = 0;
    }

    final isCompleted = maxProgress != null && nextProgress >= maxProgress;
    if (isCompleted) {
      nextStatus = MediaListStatus.completed;
      if (maxProgressVolumes != null) {
        nextProgressVolumes = maxProgressVolumes;
      }
    } else {
      nextStatus = repeat > 0
          ? MediaListStatus.repeating
          : MediaListStatus.current;
    }

    if (nextProgress > 0 && nextStartDate == null && nextRepeat == 0) {
      nextStartDate = fuzzyNow;
    }
    if (nextProgress == 0 && nextProgressVolumes == 0 && nextRepeat == 0) {
      nextStartDate = null;
    }

    final wasCompleted = status == MediaListStatus.completed;
    if (!wasCompleted &&
        nextStatus == MediaListStatus.completed &&
        nextRepeat == 0) {
      nextFinishDate = fuzzyNow;
    }
    if (wasCompleted &&
        nextStatus != MediaListStatus.completed &&
        nextRepeat == 0) {
      nextFinishDate = null;
    }

    return copyWith(
      progress: nextProgress,
      progressVolumes: nextProgressVolumes,
      status: nextStatus,
      startedAt: nextStartDate,
      completedAt: nextFinishDate,
    );
  }

  /// Computes the next entry state when volume progress is set to a specific value
  MediaListEntryWithMedia updateProgressVolumes(int newVolumes) {
    final now = DateTime.now();
    final fuzzyNow = FuzzyDate(year: now.year, month: now.month, day: now.day);

    final isManga = media.type == 'MANGA';
    final int? maxProgress = isManga
        ? (media.chapters > 0 ? media.chapters : null)
        : (media.episodes > 0 ? media.episodes : null);
    final int? maxProgressVolumes = isManga
        ? (media.volumes > 0 ? media.volumes : null)
        : null;

    int nextProgress = progress;
    int nextRepeat = repeat;
    int nextProgressVolumes = newVolumes;
    MediaListStatus nextStatus = status ?? MediaListStatus.current;
    FuzzyDate? nextStartDate = startedAt;
    FuzzyDate? nextFinishDate = completedAt;

    final isOverflow =
        maxProgressVolumes != null && newVolumes > maxProgressVolumes;
    if (isOverflow) {
      nextProgressVolumes = 1;
      nextProgress = 1;
      nextRepeat = repeat + 1;
      nextStatus = MediaListStatus.repeating;
      return copyWith(
        progress: nextProgress,
        progressVolumes: nextProgressVolumes,
        repeat: nextRepeat,
        status: nextStatus,
      );
    }

    nextProgressVolumes = newVolumes;

    final isCompleted =
        maxProgressVolumes != null && newVolumes >= maxProgressVolumes;
    if (isCompleted) {
      nextStatus = MediaListStatus.completed;
      if (maxProgress != null) {
        nextProgress = maxProgress;
      }
      if (repeat == 0) {
        nextStartDate ??= fuzzyNow;
      }
    } else {
      nextStatus = repeat > 0
          ? MediaListStatus.repeating
          : MediaListStatus.current;
    }

    if (nextProgressVolumes > 0 && nextStartDate == null && repeat == 0) {
      nextStartDate = fuzzyNow;
    }

    final wasCompleted = status == MediaListStatus.completed;
    if (isCompleted && !wasCompleted && repeat == 0) {
      nextFinishDate = fuzzyNow;
    }
    if (wasCompleted &&
        nextStatus != MediaListStatus.completed &&
        repeat == 0) {
      nextFinishDate = null;
    }

    if (nextProgress == 0 && nextProgressVolumes == 0 && repeat == 0) {
      nextStartDate = null;
    }

    return copyWith(
      progress: nextProgress,
      progressVolumes: nextProgressVolumes,
      status: nextStatus,
      startedAt: nextStartDate,
      completedAt: nextFinishDate,
    );
  }

  /// Computes the next entry state when status is changed directly
  MediaListEntryWithMedia updateStatus(MediaListStatus newStatus) {
    final now = DateTime.now();
    final fuzzyNow = FuzzyDate(year: now.year, month: now.month, day: now.day);

    final isManga = media.type == 'MANGA';
    final int? maxProgress = isManga
        ? (media.chapters > 0 ? media.chapters : null)
        : (media.episodes > 0 ? media.episodes : null);
    final int? maxProgressVolumes = isManga
        ? (media.volumes > 0 ? media.volumes : null)
        : null;

    int nextProgress = progress;
    int nextProgressVolumes = progressVolumes;
    FuzzyDate? nextFinishDate = completedAt;

    if (newStatus == MediaListStatus.completed) {
      if (maxProgress != null) {
        nextProgress = maxProgress;
      }
      if (maxProgressVolumes != null) {
        nextProgressVolumes = maxProgressVolumes;
      }
      if (status != MediaListStatus.completed && repeat == 0) {
        nextFinishDate = fuzzyNow;
      }
    } else if (status == MediaListStatus.completed && repeat == 0) {
      nextFinishDate = null;
    }

    return copyWith(
      status: newStatus,
      progress: nextProgress,
      progressVolumes: nextProgressVolumes,
      completedAt: nextFinishDate,
    );
  }

  /// Computes the next entry state when repeat count is changed directly
  MediaListEntryWithMedia updateRepeat(int newRepeat) {
    FuzzyDate? nextStartDate = startedAt;
    if (progress == 0 && progressVolumes == 0 && newRepeat == 0) {
      nextStartDate = null;
    }
    return copyWith(repeat: newRepeat, startedAt: nextStartDate);
  }
}
