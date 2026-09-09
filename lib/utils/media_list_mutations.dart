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
        )._applyDateRules();
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
      )._applyDateRules();
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

    return copyWith(
      progress: nextProgress,
      progressVolumes: nextProgressVolumes,
      status: nextStatus,
    )._applyDateRules();
  }

  /// Computes the next entry state when volume progress is set to a specific value
  MediaListEntryWithMedia updateProgressVolumes(int newVolumes) {
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
      )._applyDateRules();
    }

    nextProgressVolumes = newVolumes;

    final isCompleted =
        maxProgressVolumes != null && newVolumes >= maxProgressVolumes;
    if (isCompleted) {
      nextStatus = MediaListStatus.completed;
      if (maxProgress != null) {
        nextProgress = maxProgress;
      }
    } else {
      nextStatus = repeat > 0
          ? MediaListStatus.repeating
          : MediaListStatus.current;
    }

    return copyWith(
      progress: nextProgress,
      progressVolumes: nextProgressVolumes,
      status: nextStatus,
    )._applyDateRules();
  }

  /// Computes the next entry state when status is changed directly
  MediaListEntryWithMedia updateStatus(MediaListStatus newStatus) {
    final isManga = media.type == 'MANGA';
    final int? maxProgress = isManga
        ? (media.chapters > 0 ? media.chapters : null)
        : (media.episodes > 0 ? media.episodes : null);
    final int? maxProgressVolumes = isManga
        ? (media.volumes > 0 ? media.volumes : null)
        : null;

    int nextProgress = progress;
    int nextProgressVolumes = progressVolumes;

    if (newStatus == MediaListStatus.completed) {
      if (maxProgress != null) {
        nextProgress = maxProgress;
      }
      if (maxProgressVolumes != null) {
        nextProgressVolumes = maxProgressVolumes;
      }
    }

    return copyWith(
      status: newStatus,
      progress: nextProgress,
      progressVolumes: nextProgressVolumes,
    )._applyDateRules();
  }

  /// Computes the next entry state when repeat count is changed directly
  MediaListEntryWithMedia updateRepeat(int newRepeat) {
    return copyWith(repeat: newRepeat);
  }

  /// Applies date auto-fill rules based on the resulting status
  MediaListEntryWithMedia _applyDateRules() {
    final now = DateTime.now();
    final fuzzyNow = FuzzyDate(year: now.year, month: now.month, day: now.day);

    FuzzyDate? nextStartDate = startedAt;
    FuzzyDate? nextFinishDate = completedAt;

    if (status == MediaListStatus.current ||
        status == MediaListStatus.repeating) {
      if (nextStartDate == null || !nextStartDate.hasDate) {
        nextStartDate = fuzzyNow;
      }
    } else if (status == MediaListStatus.completed ||
        status == MediaListStatus.dropped) {
      if (nextStartDate == null || !nextStartDate.hasDate) {
        nextStartDate = fuzzyNow;
      }
      if (nextFinishDate == null || !nextFinishDate.hasDate) {
        nextFinishDate = fuzzyNow;
      }
    }

    return copyWith(
      startedAt: nextStartDate,
      completedAt: nextFinishDate,
    );
  }
}
