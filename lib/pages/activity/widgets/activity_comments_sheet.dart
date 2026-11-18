import 'dart:ui';

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../components/app_network_image.dart';
import '../../../components/html_description.dart';
import '../../../components/loading_indicator.dart';
import '../../../components/lucide_icons_helper.dart';
import '../../../models/activity_reply.dart';
import '../../../models/user_activity.dart';
import '../../../proto/api.pb.dart';
import '../../../services/activity_service.dart';
import '../../../services/auth_service.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';

/// Modal bottom sheet displaying paginated comments and reply composer for an activity.
class ActivityCommentsSheet extends StatefulWidget {
  /// Target activity ID.
  final int activityId;

  /// Initial total reply count for immediate display.
  final int? initialReplyCount;

  /// Optional callback invoked when the total reply count changes.
  final void Function(int newReplyCount)? onReplyCountChanged;

  /// Optional test override for fetching replies.
  final Future<ActivityRepliesPage> Function(int activityId, int page)?
  fetchReplies;

  /// Optional test override for posting a reply.
  final Future<ActivityReply> Function(int activityId, String text)? saveReply;

  /// Optional test override for toggling reply like.
  final Future<ToggleActivityReplyLikeResponse> Function(int replyId)?
  toggleLike;

  /// Optional scrollable sheet controller.
  final DraggableScrollableController? sheetController;

  /// Creates an activity comments bottom sheet.
  const ActivityCommentsSheet({
    super.key,
    required this.activityId,
    this.initialReplyCount,
    this.onReplyCountChanged,
    this.fetchReplies,
    this.saveReply,
    this.toggleLike,
    this.sheetController,
  });

  /// Displays the activity comments modal bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required int activityId,
    int? initialReplyCount,
    void Function(int newReplyCount)? onReplyCountChanged,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ActivityCommentsSheet(
        activityId: activityId,
        initialReplyCount: initialReplyCount,
        onReplyCountChanged: onReplyCountChanged,
      ),
    );
  }

  @override
  State<ActivityCommentsSheet> createState() => _ActivityCommentsSheetState();
}

class _ActivityCommentsSheetState extends State<ActivityCommentsSheet> {
  late final DraggableScrollableController _sheetController;
  final List<ActivityReply> _replies = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  ScrollController? _sheetScrollController;

  bool _isLoading = true;
  bool _isFetchingMore = false;
  bool _hasNextPage = false;
  int _currentPage = 1;
  int? _totalCount;
  String? _error;
  bool _isSubmitting = false;

  String? _replyingToAuthor;

  @override
  void initState() {
    super.initState();
    _sheetController =
        widget.sheetController ?? DraggableScrollableController();
    _totalCount = widget.initialReplyCount;
    _textController.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
    _loadReplies();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus && _sheetController.isAttached) {
      if (_sheetController.size < 0.85) {
        _sheetController.animateTo(
          0.95,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _textController.dispose();
    _focusNode.dispose();
    if (widget.sheetController == null) {
      _sheetController.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  Future<void> _loadReplies() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final page = widget.fetchReplies != null
          ? await widget.fetchReplies!(widget.activityId, 1)
          : await ActivityService.getActivityReplies(widget.activityId);

      if (!mounted) return;
      setState(() {
        _replies.clear();
        _replies.addAll(page.replies);
        _hasNextPage = page.pageInfo.hasNextPage;
        _currentPage = 1;
        _totalCount = page.total;
        _isLoading = false;
      });
      widget.onReplyCountChanged?.call(page.total);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreReplies() async {
    if (_isFetchingMore) return;
    setState(() {
      _isFetchingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final page = widget.fetchReplies != null
          ? await widget.fetchReplies!(widget.activityId, nextPage)
          : await ActivityService.getActivityReplies(
              widget.activityId,
              page: nextPage,
            );

      if (!mounted) return;
      setState(() {
        _replies.addAll(page.replies);
        _hasNextPage = page.pageInfo.hasNextPage;
        _currentPage = nextPage;
        _totalCount = page.total;
        _isFetchingMore = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isFetchingMore = false;
      });
    }
  }

  void _startReplying(ActivityReply reply) {
    final authorName = reply.user?.name ?? '';
    setState(() {
      _replyingToAuthor = authorName.isNotEmpty ? authorName : null;
    });
    if (authorName.isNotEmpty) {
      final prefix = '@$authorName ';
      if (!_textController.text.startsWith(prefix)) {
        _textController.text = '$prefix${_textController.text}';
        _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length),
        );
      }
    }
    _focusNode.requestFocus();
  }

  void _cancelReplying() {
    setState(() {
      _replyingToAuthor = null;
    });
  }

  Future<void> _toggleReplyLike(ActivityReply reply) async {
    final index = _replies.indexWhere((r) => r.id == reply.id);
    if (index == -1) return;

    final original = _replies[index];
    final optimistic = original.toggleLikeOptimistic();

    setState(() {
      _replies[index] = optimistic;
    });

    try {
      final res = widget.toggleLike != null
          ? await widget.toggleLike!(reply.id)
          : await ActivityService.toggleActivityReplyLike(reply.id);

      if (!mounted) return;
      setState(() {
        final curIndex = _replies.indexWhere((r) => r.id == reply.id);
        if (curIndex != -1) {
          final count = res.likedUserIds.isNotEmpty
              ? res.likedUserIds.length
              : (optimistic.isLiked ? optimistic.likeCount : 0);
          _replies[curIndex] = _replies[curIndex].copyWith(
            isLiked: optimistic.isLiked,
            likeCount: count,
          );
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        final curIndex = _replies.indexWhere((r) => r.id == reply.id);
        if (curIndex != -1) {
          _replies[curIndex] = original;
        }
      });
    }
  }

  Future<void> _submitReply() async {
    final text = _textController.text.trim();
    if (text.isEmpty || _isSubmitting) return;

    if (widget.saveReply == null) {
      final token = await AuthService.getRawToken();
      if (token == null || token.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please log in to leave a comment.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final newReply = widget.saveReply != null
          ? await widget.saveReply!(widget.activityId, text)
          : await ActivityService.saveActivityReply(
              activityId: widget.activityId,
              text: text,
            );

      if (!mounted) return;

      setState(() {
        _replies.add(newReply);
        _totalCount = (_totalCount ?? 0) + 1;
        _textController.clear();
        _replyingToAuthor = null;
        _isSubmitting = false;
      });

      widget.onReplyCountChanged?.call(_totalCount ?? _replies.length);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_sheetScrollController?.hasClients ?? false) {
          _sheetScrollController!.animateTo(
            _sheetScrollController!.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to post comment: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _openAuthor(UserActivityAuthor? author) {
    if (author == null) return;
    AppNavigation.toProfile(context, userId: author.id, username: author.name);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardBottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardBottom),
      child: DraggableScrollableSheet(
        controller: _sheetController,
        initialChildSize: 0.6,
        minChildSize: 0.35,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, sheetScrollController) {
          _sheetScrollController = sheetScrollController;
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xEB16181E),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onVerticalDragUpdate: (details) {
                        final screenHeight = MediaQuery.of(context).size.height;
                        if (screenHeight <= 0) return;
                        final delta = details.primaryDelta ?? 0;
                        final currentSize = _sheetController.size;
                        final newSize = (currentSize - (delta / screenHeight))
                            .clamp(0.35, 0.95);
                        _sheetController.jumpTo(newSize);
                      },
                      onVerticalDragEnd: (details) {
                        final velocity = details.primaryVelocity ?? 0;
                        if (velocity > 600 || _sheetController.size < 0.38) {
                          Navigator.of(context).pop();
                        } else if (velocity < -600) {
                          _sheetController.animateTo(
                            0.95,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              width: 38,
                              height: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.28),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 2, 8, 10),
                            child: Row(
                              children: [
                                Text(
                                  _totalCount != null
                                      ? 'Comments ($_totalCount)'
                                      : 'Comments',
                                  style: const TextStyle(
                                    color: textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    LucideIcons.x,
                                    size: 20,
                                    color: textMuted,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: cardBorderColor.withValues(alpha: 0.8),
                            height: 1,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: _buildContent(sheetScrollController)),
                    if (_replyingToAuthor != null) _buildReplyingBanner(),
                    _buildComposer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(ScrollController sheetScrollController) {
    if (_isLoading) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: sheetScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: const Center(child: AppLoadingIndicator(topPadding: 0)),
            ),
          );
        },
      );
    }

    if (_error != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: sheetScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Failed to load comments',
                        style: TextStyle(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _error!,
                        style: const TextStyle(color: textMuted, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadReplies,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    if (_replies.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: sheetScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.messageSquareDashed,
                        size: 40,
                        color: textMuted.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No comments yet',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Be the first to share your thoughts!',
                        style: TextStyle(color: textMuted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!_hasNextPage || _isFetchingMore || _isLoading) return false;
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
          _loadMoreReplies();
        }
        return false;
      },
      child: ListView.separated(
        controller: sheetScrollController,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        itemCount: _replies.length + (_isFetchingMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index >= _replies.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: AppLoadingIndicator(topPadding: 0)),
            );
          }
          return _buildReplyItem(_replies[index]);
        },
      ),
    );
  }

  Widget _buildReplyItem(ActivityReply reply) {
    final author = reply.user;
    final username = author?.name ?? 'Anonymous';
    final avatarUrl = author?.avatarUrl ?? '';
    final timeStr = reply.createdAt > 0
        ? timeago.format(
            DateTime.fromMillisecondsSinceEpoch(reply.createdAt * 1000),
          )
        : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: author != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: () => _openAuthor(author),
            behavior: HitTestBehavior.opaque,
            child: AppNetworkImage(
              imageUrl: avatarUrl,
              width: 34,
              height: 34,
              borderRadius: BorderRadius.circular(17),
              fallbackIcon: LucideIcons.user,
              checkDefault: true,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: MouseRegion(
                      cursor: author != null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                      child: GestureDetector(
                        onTap: () => _openAuthor(author),
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (timeStr.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Text(
                      timeStr,
                      style: const TextStyle(color: textHint, fontSize: 11.5),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              HtmlDescription(
                html: reply.text,
                style: const TextStyle(
                  color: textSecondary,
                  fontSize: 13.5,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => _startReplying(reply),
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Reply',
                    style: TextStyle(
                      color: textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _toggleReplyLike(reply),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 36,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LucideHeartIcon(
                  isFilled: reply.isLiked,
                  color: reply.isLiked ? paletteRed : textMuted,
                  size: 16,
                ),
                if (reply.likeCount > 0) ...[
                  const SizedBox(height: 2),
                  Text(
                    StringUtils.formatCompactNumber(reply.likeCount),
                    style: TextStyle(
                      color: reply.isLiked ? paletteRed : textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReplyingBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: paletteBlue.withValues(alpha: 0.12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Replying to @$_replyingToAuthor',
              style: const TextStyle(
                color: paletteBlue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: _cancelReplying,
            behavior: HitTestBehavior.opaque,
            child: const Icon(LucideIcons.x, size: 14, color: textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    final hasText = _textController.text.trim().isNotEmpty;
    final canSubmit = hasText && !_isSubmitting;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xEB16181E),
        border: Border(
          top: BorderSide(color: cardBorderColor.withValues(alpha: 0.8)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: cardBorderColor.withValues(alpha: 0.8),
                  ),
                ),
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  style: const TextStyle(color: textPrimary, fontSize: 13.5),
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _submitReply(),
                  decoration: const InputDecoration(
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(color: textMuted, fontSize: 13.5),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: canSubmit ? _submitReply : null,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: canSubmit ? paletteBlue : Colors.white12,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          LucideIcons.send,
                          size: 16,
                          color: canSubmit ? Colors.white : textMuted,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
