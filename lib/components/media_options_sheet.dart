import 'package:flutter/material.dart';

import '../models/common.dart';
import '../models/media.dart';
import '../models/media_list.dart';
import '../services/media_list_service.dart';
import '../theme/theme.dart';
import '../utils/app_options.dart';
import './media_options/counter_editor.dart';
import './media_options/date_editor.dart';
import './media_options/score_slider.dart';
import './media_options/status_selector.dart';

/// A bottom sheet for editing media list entry options
class MediaOptionsSheet extends StatefulWidget {
  /// The media list entry data
  final MediaListEntryWithMedia entry;

  /// Optional scroll controller for the sheet
  final ScrollController? scrollController;

  /// Creates a media options sheet
  const MediaOptionsSheet({
    super.key,
    required this.entry,
    this.scrollController,
  });

  @override
  State<MediaOptionsSheet> createState() => _MediaOptionsSheetState();
}

/// State for MediaOptionsSheet
class _MediaOptionsSheetState extends State<MediaOptionsSheet> {
  late MediaListStatus? _status;
  late int _progress;
  late double _score;
  DateTime? _startDate;
  DateTime? _finishDate;
  int? _maxProgress;
  int? _maxProgressVolumes;

  late int _progressVolumes;
  late int _repeat;

  late MediaListStatus? _initialStatus;
  late int _initialProgress;
  late double _initialScore;
  DateTime? _initialStartDate;
  DateTime? _initialFinishDate;
  late int _initialProgressVolumes;
  late int _initialRepeat;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _status = widget.entry.status;
    _progress = widget.entry.progress;
    _score = widget.entry.score;

    final isManga = widget.entry.media.type == 'MANGA';
    if (isManga) {
      _maxProgress = widget.entry.media.chapters > 0
          ? widget.entry.media.chapters
          : null;
      _maxProgressVolumes = widget.entry.media.volumes > 0
          ? widget.entry.media.volumes
          : null;
    } else {
      _maxProgress = widget.entry.media.episodes > 0
          ? widget.entry.media.episodes
          : null;
      _maxProgressVolumes = null;
    }

    _progressVolumes = isManga ? widget.entry.progressVolumes : 0;
    _initialProgressVolumes = _progressVolumes;

    _repeat = widget.entry.repeat;
    _initialRepeat = _repeat;

    _startDate = _parseFuzzyDate(widget.entry.startedAt);
    _finishDate = _parseFuzzyDate(widget.entry.completedAt);

    _initialStatus = _status;
    _initialProgress = _progress;
    _initialScore = _score;
    _initialStartDate = _startDate;
    _initialFinishDate = _finishDate;
  }

  /// Parses a FuzzyDate into a DateTime object
  DateTime? _parseFuzzyDate(FuzzyDate? fuzzyDate) {
    if (fuzzyDate == null) return null;
    final y = fuzzyDate.year;
    final m = fuzzyDate.month;
    final d = fuzzyDate.day;
    if (y != null && m != null && d != null) {
      return DateTime(y, m, d);
    }
    return null;
  }

  void _setStatus(MediaListStatus newStatus) {
    setState(() {
      final previousStatus = _status;
      _status = newStatus;

      if (newStatus == MediaListStatus.completed) {
        if (_maxProgress != null) {
          _progress = _maxProgress!;
        }
        if (_maxProgressVolumes != null) {
          _progressVolumes = _maxProgressVolumes!;
        }
        if (previousStatus != MediaListStatus.completed && _repeat == 0) {
          _finishDate = DateTime.now();
        }
      } else if (previousStatus == MediaListStatus.completed && _repeat == 0) {
        _finishDate = null;
      }
    });
  }

  void _updateProgress(int newProgress) {
    setState(() {
      final previousStatus = _status;
      final now = DateTime.now();

      final isOverflow = _maxProgress != null && newProgress > _maxProgress!;
      if (isOverflow) {
        _progress = 1;
        _repeat += 1;
        _progressVolumes = 0;
        _status = MediaListStatus.repeating;
        return;
      }

      final isUndoingRepeat =
          newProgress == 0 && _repeat > 0 && _maxProgress != null;
      if (isUndoingRepeat) {
        _progress = _maxProgress!;
        if (_maxProgressVolumes != null) {
          _progressVolumes = _maxProgressVolumes!;
        }
        _repeat -= 1;
        _status = MediaListStatus.completed;
        return;
      }

      _progress = newProgress;
      if (_progress == 0) {
        _progressVolumes = 0;
      }
      final isCompleted = _maxProgress != null && _progress >= _maxProgress!;
      if (isCompleted) {
        _status = MediaListStatus.completed;
        if (_maxProgressVolumes != null) {
          _progressVolumes = _maxProgressVolumes!;
        }
      } else {
        _status = _repeat > 0
            ? MediaListStatus.repeating
            : MediaListStatus.current;
      }

      if (_progress > 0 && _startDate == null && _repeat == 0) {
        _startDate = now;
      }
      if (_progress == 0 && _progressVolumes == 0 && _repeat == 0) {
        _startDate = null;
      }

      final wasCompleted = previousStatus == MediaListStatus.completed;
      if (!wasCompleted &&
          _status == MediaListStatus.completed &&
          _repeat == 0) {
        _finishDate = now;
      }
      if (wasCompleted &&
          _status != MediaListStatus.completed &&
          _repeat == 0) {
        _finishDate = null;
      }
    });
  }

  void _updateProgressVolumes(int newVolumes) {
    setState(() {
      final previousStatus = _status;
      final now = DateTime.now();

      final isOverflow =
          _maxProgressVolumes != null && newVolumes > _maxProgressVolumes!;
      if (isOverflow) {
        _progressVolumes = 1;
        _progress = 1;
        _repeat += 1;
        _status = MediaListStatus.repeating;
        return;
      }

      _progressVolumes = newVolumes;

      final isCompleted =
          _maxProgressVolumes != null &&
          _progressVolumes >= _maxProgressVolumes!;
      if (isCompleted) {
        _status = MediaListStatus.completed;
        if (_maxProgress != null) {
          _progress = _maxProgress!;
        }
        if (_repeat == 0) {
          _startDate ??= now;
        }
        if (previousStatus != MediaListStatus.completed && _repeat == 0) {
          _finishDate = now;
        }
      } else {
        _status = _repeat > 0
            ? MediaListStatus.repeating
            : MediaListStatus.current;
      }

      if (_progressVolumes > 0 && _startDate == null && _repeat == 0) {
        _startDate = now;
      }

      final wasCompleted = previousStatus == MediaListStatus.completed;
      if (wasCompleted &&
          _status != MediaListStatus.completed &&
          _repeat == 0) {
        _finishDate = null;
      }

      if (_progress == 0 && _progressVolumes == 0 && _repeat == 0) {
        _startDate = null;
      }
    });
  }

  void _updateRepeat(int newRepeat) {
    setState(() {
      _repeat = newRepeat;
      if (_progress == 0 && _progressVolumes == 0 && _repeat == 0) {
        _startDate = null;
      }
    });
  }

  Widget _buildCountersSection() {
    final media = widget.entry.media;
    final isManga = media is Media && media.type == 'MANGA';

    if (isManga) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CounterEditor(
                    label: 'Chapters',
                    value: _progress,
                    maximum: _maxProgress,
                    onChanged: _updateProgress,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CounterEditor(
                    label: 'Volumes',
                    value: _progressVolumes,
                    maximum: _maxProgressVolumes,
                    onChanged: _updateProgressVolumes,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CounterEditor(
              label: 'Reread Count',
              value: _repeat,
              showMaxLimit: false,
              onChanged: _updateRepeat,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: CounterEditor(
                label: 'Episodes',
                value: _progress,
                maximum: _maxProgress,
                onChanged: _updateProgress,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CounterEditor(
                label: 'Rewatch Count',
                value: _repeat,
                showMaxLimit: false,
                onChanged: _updateRepeat,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: cardBorderColor),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: SingleChildScrollView(
                controller: widget.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: 32,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StatusSelector(
                      currentStatus: _status,
                      onStatusChanged: _setStatus,
                    ),
                    _buildCountersSection(),
                    DateEditor(
                      startDate: _startDate,
                      finishDate: _finishDate,
                      onStartDateChanged: (date) =>
                          setState(() => _startDate = date),
                      onFinishDateChanged: (date) =>
                          setState(() => _finishDate = date),
                    ),
                    ScoreSlider(
                      score: _score,
                      onScoreChanged: (score) => setState(() => _score = score),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  /// Builds the save and cancel buttons
  Widget _buildActionButtons() {
    final bool hasEntryId = widget.entry.id > 0;
    final bool hasChanges =
        _status != _initialStatus ||
        _progress != _initialProgress ||
        _score != _initialScore ||
        _startDate != _initialStartDate ||
        _finishDate != _initialFinishDate ||
        _progressVolumes != _initialProgressVolumes ||
        _repeat != _initialRepeat;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasEntryId)
            TextButton(
              onPressed: _isSaving ? null : _deleteEntry,
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          else
            const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: (_isSaving || !hasChanges) ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: borderColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        hasEntryId ? 'Save' : 'Add',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _deleteEntry() async {
    final entryId = widget.entry.id;
    if (entryId <= 0) return;

    setState(() => _isSaving = true);
    try {
      await MediaListService.deleteEntry(entryId);

      if (mounted) {
        Navigator.of(context).pop(const MediaOptionsResult(deleted: true));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete entry: $e')));
      }
    }
  }

  /// Saves changes to the backend
  Future<void> _saveChanges() async {
    final mediaId = widget.entry.media.id;
    if (mediaId <= 0) return;

    final bool hasChanges =
        _status != _initialStatus ||
        _progress != _initialProgress ||
        _score != _initialScore ||
        _startDate != _initialStartDate ||
        _finishDate != _initialFinishDate ||
        _progressVolumes != _initialProgressVolumes ||
        _repeat != _initialRepeat;

    if (!hasChanges) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = true);

    try {
      final finalStatus = _status ?? MediaListStatus.current;
      final response = await MediaListService.saveEntry(
        mediaId: mediaId,
        status: finalStatus != _initialStatus ? finalStatus : null,
        progress: _progress != _initialProgress ? _progress : null,
        score: _score != _initialScore ? _score : null,
        startDate: _startDate != _initialStartDate ? _startDate : null,
        finishDate: _finishDate != _initialFinishDate ? _finishDate : null,
        progressVolumes: _progressVolumes != _initialProgressVolumes
            ? _progressVolumes
            : null,
        repeat: _repeat != _initialRepeat ? _repeat : null,
      );

      if (mounted) {
        Navigator.of(context).pop(
          MediaOptionsResult(
            entry: widget.entry.copyWith(
              id: response.id,
              status: finalStatus,
              progress: _progress,
              score: _score,
              repeat: _repeat,
              progressVolumes: _progressVolumes,
              startedAt: _startDate != null
                  ? FuzzyDate(
                      year: _startDate!.year,
                      month: _startDate!.month,
                      day: _startDate!.day,
                    )
                  : null,
              completedAt: _finishDate != null
                  ? FuzzyDate(
                      year: _finishDate!.year,
                      month: _finishDate!.month,
                      day: _finishDate!.day,
                    )
                  : null,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save changes: $e')));
      }
    }
  }
}
