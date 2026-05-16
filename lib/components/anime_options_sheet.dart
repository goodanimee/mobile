import 'package:flutter/material.dart';
import '../theme/theme.dart';
import './anime_options/date_editor.dart';
import './anime_options/score_slider.dart';
import './anime_options/progress_editor.dart';
import './anime_options/status_selector.dart';
import '../services/auth_service.dart';
import '../proto/medialist.pb.dart';
import '../api/media_list_api.dart';

/// A bottom sheet for editing anime list entry options
class AnimeOptionsSheet extends StatefulWidget {
  /// The anime list entry data
  final Map<String, dynamic> entry;

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
    _status = widget.entry['status'] as String? ?? 'CURRENT';
    _progress = widget.entry['progress'] as int? ?? 0;
    _score = (widget.entry['score'] as num?)?.toDouble() ?? 0.0;

    final media = widget.entry['media'] as Map<String, dynamic>? ?? {};
    _episodes = media['episodes'] as int?;

    _startDate = _parseDate(widget.entry['startedAt'] as Map<String, dynamic>?);
    _finishDate = _parseDate(
      widget.entry['completedAt'] as Map<String, dynamic>?,
    );

    _initialStatus = _status;
    _initialProgress = _progress;
    _initialScore = _score;
    _initialStartDate = _startDate;
    _initialFinishDate = _finishDate;
  }

  /// Parses a date map into a DateTime object
  DateTime? _parseDate(Map<String, dynamic>? dateMap) {
    if (dateMap == null) return null;
    final y = dateMap['year'] as int?;
    final m = dateMap['month'] as int?;
    final d = dateMap['day'] as int?;
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            onPressed: _isSaving ? null : _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: borderColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                : const Text(
                    'Save',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }

  /// Saves changes to the backend
  Future<void> _saveChanges() async {
    final mediaId = widget.entry['media']?['id'] as int?;
    if (mediaId == null) return;

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
      final token = await AuthService.getRawToken() ?? '';
      final req = SaveMediaListEntryRequest(mediaId: mediaId);

      if (_status != _initialStatus) req.status = _status;
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

      await MediaListApi.saveMediaListEntry(req, token);

      if (mounted) {
        Navigator.of(context).pop({
          'status': _status,
          'progress': _progress,
          'score': _score,
          'startedAt': _startDate != null
              ? {
                  'year': _startDate!.year,
                  'month': _startDate!.month,
                  'day': _startDate!.day,
                }
              : null,
          'completedAt': _finishDate != null
              ? {
                  'year': _finishDate!.year,
                  'month': _finishDate!.month,
                  'day': _finishDate!.day,
                }
              : null,
        });
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
