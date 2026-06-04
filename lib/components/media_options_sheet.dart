import 'package:flutter/material.dart';

import '../models/common.dart';
import '../models/media_list.dart';
import '../services/media_list_service.dart';
import '../theme/theme.dart';
import '../utils/app_options.dart';
import '../utils/media_list_mutations.dart';
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
  late MediaListEntryWithMedia _currentEntry;
  late MediaListEntryWithMedia _initialEntry;
  int? _maxProgress;
  int? _maxProgressVolumes;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _currentEntry = widget.entry;
    _initialEntry = widget.entry;

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
      _currentEntry = _currentEntry.updateStatus(newStatus);
    });
  }

  void _updateProgress(int newProgress) {
    setState(() {
      _currentEntry = _currentEntry.updateProgress(newProgress);
    });
  }

  void _updateProgressVolumes(int newVolumes) {
    setState(() {
      _currentEntry = _currentEntry.updateProgressVolumes(newVolumes);
    });
  }

  void _updateRepeat(int newRepeat) {
    setState(() {
      _currentEntry = _currentEntry.updateRepeat(newRepeat);
    });
  }

  Widget _buildCountersSection() {
    final media = widget.entry.media;
    final isManga = media.type == 'MANGA';

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
                    value: _currentEntry.progress,
                    maximum: _maxProgress,
                    onChanged: _updateProgress,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CounterEditor(
                    label: 'Volumes',
                    value: _currentEntry.progressVolumes,
                    maximum: _maxProgressVolumes,
                    onChanged: _updateProgressVolumes,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CounterEditor(
              label: 'Reread Count',
              value: _currentEntry.repeat,
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
                value: _currentEntry.progress,
                maximum: _maxProgress,
                onChanged: _updateProgress,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CounterEditor(
                label: 'Rewatch Count',
                value: _currentEntry.repeat,
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
                      currentStatus: _currentEntry.status,
                      onStatusChanged: _setStatus,
                      isManga: widget.entry.media.type == 'MANGA',
                    ),
                    _buildCountersSection(),
                    DateEditor(
                      startDate: _parseFuzzyDate(_currentEntry.startedAt),
                      finishDate: _parseFuzzyDate(_currentEntry.completedAt),
                      onStartDateChanged: (date) => setState(
                        () => _currentEntry = _currentEntry.copyWith(
                          startedAt: date != null
                              ? FuzzyDate(
                                  year: date.year,
                                  month: date.month,
                                  day: date.day,
                                )
                              : null,
                        ),
                      ),
                      onFinishDateChanged: (date) => setState(
                        () => _currentEntry = _currentEntry.copyWith(
                          completedAt: date != null
                              ? FuzzyDate(
                                  year: date.year,
                                  month: date.month,
                                  day: date.day,
                                )
                              : null,
                        ),
                      ),
                    ),
                    ScoreSlider(
                      score: _currentEntry.score,
                      onScoreChanged: (score) => setState(
                        () => _currentEntry = _currentEntry.copyWith(
                          score: score,
                        ),
                      ),
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
        _currentEntry.status != _initialEntry.status ||
        _currentEntry.progress != _initialEntry.progress ||
        _currentEntry.score != _initialEntry.score ||
        _currentEntry.startedAt != _initialEntry.startedAt ||
        _currentEntry.completedAt != _initialEntry.completedAt ||
        _currentEntry.progressVolumes != _initialEntry.progressVolumes ||
        _currentEntry.repeat != _initialEntry.repeat;

    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360.0;

    final double btnPaddingHorizontal = getResponsiveSize(
      context,
      isSmallScreen ? 12.0 : 20.0,
    );
    final double savePaddingHorizontal = getResponsiveSize(
      context,
      isSmallScreen ? 16.0 : 24.0,
    );
    final double deletePaddingHorizontal = getResponsiveSize(
      context,
      isSmallScreen ? 8.0 : 16.0,
    );
    final double buttonSpacing = getResponsiveSize(
      context,
      isSmallScreen ? 6.0 : 12.0,
    );
    final double sidePadding = getResponsiveSize(
      context,
      isSmallScreen ? 12.0 : 20.0,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
        top: 12,
        bottom: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasEntryId)
            TextButton(
              onPressed: _isSaving ? null : _deleteEntry,
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(
                  horizontal: deletePaddingHorizontal,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: btnPaddingHorizontal,
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
              SizedBox(width: buttonSpacing),
              ElevatedButton(
                onPressed: (_isSaving || !hasChanges) ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: borderColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: savePaddingHorizontal,
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
        _currentEntry.status != _initialEntry.status ||
        _currentEntry.progress != _initialEntry.progress ||
        _currentEntry.score != _initialEntry.score ||
        _currentEntry.startedAt != _initialEntry.startedAt ||
        _currentEntry.completedAt != _initialEntry.completedAt ||
        _currentEntry.progressVolumes != _initialEntry.progressVolumes ||
        _currentEntry.repeat != _initialEntry.repeat;

    if (!hasChanges) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = true);

    try {
      final finalStatus = _currentEntry.status ?? MediaListStatus.current;
      final response = await MediaListService.saveEntry(
        mediaId: mediaId,
        status: finalStatus != _initialEntry.status ? finalStatus : null,
        progress: _currentEntry.progress != _initialEntry.progress
            ? _currentEntry.progress
            : null,
        score: _currentEntry.score != _initialEntry.score
            ? _currentEntry.score
            : null,
        startDate: _currentEntry.startedAt != _initialEntry.startedAt
            ? _parseFuzzyDate(_currentEntry.startedAt)
            : null,
        finishDate: _currentEntry.completedAt != _initialEntry.completedAt
            ? _parseFuzzyDate(_currentEntry.completedAt)
            : null,
        progressVolumes:
            _currentEntry.progressVolumes != _initialEntry.progressVolumes
            ? _currentEntry.progressVolumes
            : null,
        repeat: _currentEntry.repeat != _initialEntry.repeat
            ? _currentEntry.repeat
            : null,
      );

      if (mounted) {
        Navigator.of(context).pop(
          MediaOptionsResult(entry: _currentEntry.copyWith(id: response.id)),
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
