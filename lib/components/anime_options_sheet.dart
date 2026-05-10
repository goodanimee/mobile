import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../proto/medialist.pb.dart';

class AnimeOptionsSheet extends StatefulWidget {
  final Map<String, dynamic> entry;
  final ScrollController? scrollController;

  const AnimeOptionsSheet({
    super.key,
    required this.entry,
    this.scrollController,
  });

  @override
  State<AnimeOptionsSheet> createState() => _AnimeOptionsSheetState();
}

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

  String _formatDate(DateTime? date) {
    if (date == null) return '--/--/----';
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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

  Widget _buildSection(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: sectionTitleColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
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
                  _buildStatusSection(),
                  _buildProgressSection(),
                  _buildDatesSection(),
                  _buildScoreSection(),
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

      await BackendHelper.saveMediaListEntry(req, token);

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

  Widget _buildStatusSection() {
    const statuses = [
      ('CURRENT', Icons.play_circle_rounded),
      ('PLANNING', Icons.bookmark_rounded),
      ('COMPLETED', Icons.check_circle_rounded),
      ('PAUSED', Icons.pause_circle_rounded),
      ('DROPPED', Icons.cancel_rounded),
    ];

    return _buildSection(
      'Status',
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: statuses.map((s) {
          final isSelected =
              _status == s.$1 || (_status == 'WATCHING' && s.$1 == 'CURRENT');
          return GestureDetector(
            onTap: () => _setStatus(s.$1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? borderColor.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? borderColor
                      : Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                s.$2,
                color: isSelected ? borderColor : Colors.white54,
                size: 28,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressSection() {
    return _buildSection(
      'Progress',
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _progress > 0
                ? () => _updateProgress(_progress - 1)
                : null,
            icon: const Icon(Icons.remove_circle_outline_rounded),
            color: Colors.white70,
            iconSize: 32,
          ),
          const SizedBox(width: 24),
          Text(
            '$_progress / ${_episodes ?? '?'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 24),
          IconButton(
            onPressed: (_episodes == null || _progress < _episodes!)
                ? () => _updateProgress(_progress + 1)
                : null,
            icon: const Icon(Icons.add_circle_outline_rounded),
            color: Colors.white70,
            iconSize: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildDatesSection() {
    return _buildSection(
      'Dates',
      Row(
        children: [
          Expanded(
            child: _buildDateBox('Start Date', _startDate, (date) {
              setState(() => _startDate = date);
            }),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDateBox('Finish Date', _finishDate, (date) {
              setState(() => _finishDate = date);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox(
    String label,
    DateTime? date,
    ValueChanged<DateTime?> onChanged,
  ) {
    return InkWell(
      onTap: () async {
        final selected = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(1970),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: borderColor,
                  surface: bgColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (selected != null) onChanged(selected);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(date),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreSection() {
    return _buildSection(
      'Score',
      Column(
        children: [
          Text(
            _score.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final starWidth = constraints.maxWidth / 10;
              return GestureDetector(
                onPanUpdate: (details) => _updateScore(
                  details.localPosition.dx,
                  constraints.maxWidth,
                ),
                onTapDown: (details) => _updateScore(
                  details.localPosition.dx,
                  constraints.maxWidth,
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        10,
                        (index) => Icon(
                          Icons.star_rounded,
                          color: Colors.white.withValues(alpha: 0.1),
                          size: starWidth,
                        ),
                      ),
                    ),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: _score / 10.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            10,
                            (index) => Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: starWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _updateScore(double dx, double maxWidth) {
    double rawScore = (dx / maxWidth) * 10;
    if (rawScore < 0) rawScore = 0;
    if (rawScore > 10) rawScore = 10;
    // Round to nearest 0.1
    setState(() {
      _score = double.parse(rawScore.toStringAsFixed(1));
    });
  }
}
