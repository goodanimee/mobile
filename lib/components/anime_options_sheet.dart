import 'package:flutter/material.dart';
import '../theme/theme.dart';
import './anime_options/date_editor.dart';
import './anime_options/score_slider.dart';
import './anime_options/progress_editor.dart';
import './anime_options/status_selector.dart';
import '../services/auth_service.dart';
import '../api/media_list_api.dart';
import '../models/common.dart';
import '../models/media_list.dart';
import '../utils/app_options.dart';

/// A bottom sheet for editing anime list entry options
class AnimeOptionsSheet extends StatefulWidget {
  /// The anime list entry data
  final MediaListEntryWithMedia entry;

  /// Optional scroll controller for the sheet
  final ScrollController? scrollController;

  /// Creates an anime options sheet
  const AnimeOptionsSheet({
    super.key,
    required this.entry,
    this.scrollController,
  });

  @override
  State<AnimeOptionsSheet> createState() => _AnimeOptionsSheetState();
}

/// State for AnimeOptionsSheet
class _AnimeOptionsSheetState extends State<AnimeOptionsSheet> {
  late String _status;
  late int _progress;
  late double _score;
  DateTime? _startDate;
  DateTime? _finishDate;
  int? _episodes;

  late String _initialStatus;
  late int _initialProgress;
  late double _initialScore;
  DateTime? _initialStartDate;
  DateTime? _initialFinishDate;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _status = widget.entry.status?.name ?? '';
    _progress = widget.entry.progress;
    _score = widget.entry.score;

    _episodes = widget.entry.media.episodes > 0
        ? widget.entry.media.episodes
        : null;

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

  void _setStatus(String newStatus) {
    setState(() => _status = newStatus);
  }

  void _updateProgress(int newProgress) {
    setState(() {
      final oldProgress = _progress;
      final oldStatus = _status;

      _progress = newProgress;

      if (_episodes != null && _progress >= _episodes!) {
        _status = 'COMPLETED';
      } else {
        _status = 'CURRENT';
      }

      final now = DateTime.now();
      if (oldProgress == 0 && newProgress > 0) {
        _startDate = now;
      }
      if (oldStatus != 'COMPLETED' && _status == 'COMPLETED') {
        _finishDate = now;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: cardBorderColor, width: 1.0),
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
                  ProgressEditor(
                    progress: _progress,
                    onProgressChanged: _updateProgress,
                    maximum: _episodes,
                  ),
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
        _finishDate != _initialFinishDate;

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
      final token = await AuthService.getRawToken() ?? '';
      final req = DeleteMediaListEntryRequest(entryId: entryId);
      await MediaListApi.deleteMediaListEntry(req, token);

      if (mounted) {
        Navigator.of(context).pop(const AnimeOptionsResult(deleted: true));
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
        _finishDate != _initialFinishDate;

    if (!hasChanges) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = true);

    try {
      final finalStatus = _status.isEmpty ? 'CURRENT' : _status;
      final token = await AuthService.getRawToken() ?? '';
      final req = SaveMediaListEntryRequest(mediaId: mediaId);

      if (finalStatus != _initialStatus) req.status = finalStatus;
      if (_progress != _initialProgress) req.progress = _progress;
      if (_score != _initialScore) req.score = _score;

      if (_startDate != _initialStartDate) {
        req.startedAt = FuzzyDateInput(
          year: _startDate?.year,
          month: _startDate?.month,
          day: _startDate?.day,
        );
      }
      if (_finishDate != _initialFinishDate) {
        req.completedAt = FuzzyDateInput(
          year: _finishDate?.year,
          month: _finishDate?.month,
          day: _finishDate?.day,
        );
      }

      final response = await MediaListApi.saveMediaListEntry(req, token);

      if (mounted) {
        Navigator.of(context).pop(
          AnimeOptionsResult(
            entry: widget.entry.copyWith(
              id: response.id,
              status: MediaListStatus.fromJson(finalStatus),
              progress: _progress,
              score: _score,
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
