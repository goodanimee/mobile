import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../components/app_network_image.dart';
import '../../../components/clamped_feed_content.dart';
import '../../../components/html_description.dart';
import '../../../components/lucide_icons_helper.dart';
import '../../../models/user_activity.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';
import '../../activity/widgets/activity_comments_sheet.dart';

/// Callback signature for navigating to a user profile from an activity card.
typedef ActivityUserTapCallback = void Function(int userId, String username);

/// Card widget rendering a single [UserActivity] (`ListActivity`, `TextActivity`, or `MessageActivity`).
class UserActivityCard extends StatefulWidget {
  /// Activity data to display.
  final UserActivity activity;

  /// Whether a like mutation is currently in flight for this card.
  final bool isTogglingLike;

  /// Callback invoked when the heart button is tapped.
  final VoidCallback onToggleLike;

  /// Optional override for opening a media details page.
  final ValueChanged<int>? onOpenMedia;

  /// Optional override for opening a user profile page.
  final ActivityUserTapCallback? onOpenUser;

  /// Optional callback invoked when the comment button is tapped.
  final VoidCallback? onOpenComments;

  /// Optional callback invoked when opening the full post page.
  final VoidCallback? onOpenPost;

  /// Whether this card is rendered in a feed (enabling content clamping).
  final bool isFeedMode;

  /// Maximum allowed vertical height before content clamping.
  final double maxContentHeight;

  /// Whether to display footer actions (Show more, comments, likes).
  final bool showFooterActions;

  /// Creates a user activity card.
  const UserActivityCard({
    super.key,
    required this.activity,
    required this.onToggleLike,
    this.isTogglingLike = false,
    this.onOpenMedia,
    this.onOpenUser,
    this.onOpenComments,
    this.onOpenPost,
    this.isFeedMode = true,
    this.maxContentHeight = 240.0,
    this.showFooterActions = true,
  });

  @override
  State<UserActivityCard> createState() => _UserActivityCardState();
}

class _UserActivityCardState extends State<UserActivityCard> {
  bool _isOverflowing = false;

  String _formatRelativeTime(int timestampSeconds) {
    if (timestampSeconds <= 0) return '';
    return timeago.format(
      DateTime.fromMillisecondsSinceEpoch(timestampSeconds * 1000),
    );
  }

  void _openMedia(BuildContext context, int mediaId) {
    if (mediaId <= 0) return;
    if (widget.onOpenMedia != null) {
      widget.onOpenMedia!(mediaId);
      return;
    }
    AppNavigation.toMedia(context, mediaId);
  }

  void _openUser(BuildContext context, UserActivityAuthor author) {
    if (author.id <= 0 && author.name.isEmpty) return;
    if (widget.onOpenUser != null) {
      widget.onOpenUser!(author.id, author.name);
      return;
    }
    AppNavigation.toProfile(
      context,
      userId: author.id > 0 ? author.id : null,
      username: author.name.isNotEmpty ? author.name : null,
    );
  }

  void _openPost(BuildContext context) {
    if (widget.onOpenPost != null) {
      widget.onOpenPost!();
      return;
    }
    AppNavigation.toActivity(context, initialActivity: widget.activity);
  }

  void _openComments(BuildContext context) {
    if (widget.onOpenComments != null) {
      widget.onOpenComments!();
      return;
    }
    ActivityCommentsSheet.show(
      context,
      activityId: widget.activity.id,
      initialReplyCount: widget.activity.replyCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor),
      ),
      child: switch (widget.activity.kind) {
        UserActivityKind.list => _buildListCard(context),
        UserActivityKind.text => _buildTextCard(context),
        UserActivityKind.message => _buildMessageCard(context),
      },
    );

    if (widget.isFeedMode) {
      return GestureDetector(
        onTap: () => _openPost(context),
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }

  Widget _buildListCard(BuildContext context) {
    final media = widget.activity.media;
    final coverUrl = media == null
        ? ''
        : (media.coverImage.large.isNotEmpty
              ? media.coverImage.large
              : media.coverImage.medium);
    final accentColor = ColorUtils.fromHex(media?.coverImage.color);
    final formatLabel = media?.format.replaceAll('_', ' ') ?? '';
    final timeStr = _formatRelativeTime(widget.activity.createdAt);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: media != null ? () => _openMedia(context, media.id) : null,
            child: Container(
              width: 56,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accentColor.withValues(alpha: 0.45)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: AppNetworkImage(
                  imageUrl: coverUrl,
                  width: 56,
                  height: 80,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (formatLabel.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: paletteBlue.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                formatLabel,
                                style: const TextStyle(
                                  color: textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (timeStr.isNotEmpty)
                            Expanded(
                              child: Text(
                                timeStr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: textMuted,
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: widget.isFeedMode
                            ? () => _openPost(context)
                            : (media != null
                                  ? () => _openMedia(context, media.id)
                                  : null),
                        behavior: HitTestBehavior.opaque,
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 13.5,
                              height: 1.35,
                              color: textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: widget.activity.formattedListPrefix,
                              ),
                              if (widget
                                  .activity
                                  .mediaDisplayTitle
                                  .isNotEmpty) ...[
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: widget.activity.mediaDisplayTitle,
                                  style: const TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (widget.showFooterActions) ...[
                    const SizedBox(height: 8),
                    _buildFooterRow(context),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextCard(BuildContext context) {
    final author = widget.activity.user;
    final timeStr = _formatRelativeTime(widget.activity.createdAt);

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (author != null) ...[
                GestureDetector(
                  onTap: () => _openUser(context, author),
                  child: AppNetworkImage(
                    imageUrl: author.avatarUrl,
                    width: 34,
                    height: 34,
                    borderRadius: BorderRadius.circular(17),
                    fallbackIcon: LucideIcons.user,
                    checkDefault: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openUser(context, author),
                    child: Text(
                      author.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ] else
                const Spacer(),
              if (timeStr.isNotEmpty)
                Text(
                  timeStr,
                  style: const TextStyle(color: textMuted, fontSize: 11.5),
                ),
            ],
          ),
          if (widget.activity.textHtml.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: widget.isFeedMode ? () => _openPost(context) : null,
              behavior: HitTestBehavior.opaque,
              child: ClampedFeedContent(
                maxHeight: widget.maxContentHeight,
                enabled: widget.isFeedMode,
                onOverflowChanged: (val) {
                  if (_isOverflowing != val) {
                    setState(() => _isOverflowing = val);
                  }
                },
                child: HtmlDescription(html: widget.activity.textHtml),
              ),
            ),
          ],
          if (widget.showFooterActions) ...[
            const SizedBox(height: 10),
            _buildFooterRow(context),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageCard(BuildContext context) {
    final messenger = widget.activity.user;
    final recipient = widget.activity.recipient;
    final timeStr = _formatRelativeTime(widget.activity.createdAt);

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (messenger != null) ...[
                GestureDetector(
                  onTap: () => _openUser(context, messenger),
                  child: AppNetworkImage(
                    imageUrl: messenger.avatarUrl,
                    width: 34,
                    height: 34,
                    borderRadius: BorderRadius.circular(17),
                    fallbackIcon: LucideIcons.user,
                    checkDefault: true,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 2,
                  children: [
                    if (messenger != null)
                      GestureDetector(
                        onTap: () => _openUser(context, messenger),
                        child: Text(
                          messenger.name,
                          style: const TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    if (recipient != null && recipient.name.isNotEmpty) ...[
                      const Icon(
                        LucideIcons.arrowRight,
                        size: 13,
                        color: textMuted,
                      ),
                      GestureDetector(
                        onTap: () => _openUser(context, recipient),
                        child: Text(
                          recipient.name,
                          style: const TextStyle(
                            color: textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ],
                    if (widget.activity.isPrivate)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: palettePurple.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: palettePurple.withValues(alpha: 0.45),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.lock,
                              size: 10,
                              color: textSecondary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Private',
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (timeStr.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  timeStr,
                  style: const TextStyle(color: textMuted, fontSize: 11.5),
                ),
              ],
            ],
          ),
          if (widget.activity.textHtml.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: widget.isFeedMode ? () => _openPost(context) : null,
              behavior: HitTestBehavior.opaque,
              child: ClampedFeedContent(
                maxHeight: widget.maxContentHeight,
                enabled: widget.isFeedMode,
                onOverflowChanged: (val) {
                  if (_isOverflowing != val) {
                    setState(() => _isOverflowing = val);
                  }
                },
                child: HtmlDescription(html: widget.activity.textHtml),
              ),
            ),
          ],
          if (widget.showFooterActions) ...[
            const SizedBox(height: 10),
            _buildFooterRow(context),
          ],
        ],
      ),
    );
  }

  Widget _buildFooterRow(BuildContext context) {
    return Row(
      children: [
        if (_isOverflowing)
          GestureDetector(
            onTap: () => _openPost(context),
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Show more',
                style: TextStyle(
                  color: paletteBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        const Spacer(),
        GestureDetector(
          key: ValueKey('activity-comment-${widget.activity.id}'),
          onTap: widget.onOpenComments ?? () => _openComments(context),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  LucideIcons.messageSquare,
                  size: 18,
                  color: textMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  StringUtils.formatCompactNumber(widget.activity.replyCount),
                  style: const TextStyle(
                    color: textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          key: ValueKey('activity-like-${widget.activity.id}'),
          onTap: widget.isTogglingLike ? null : widget.onToggleLike,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LucideHeartIcon(
                  isFilled: widget.activity.isLiked,
                  color: widget.activity.isLiked ? paletteRed : textMuted,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  StringUtils.formatCompactNumber(widget.activity.likeCount),
                  style: TextStyle(
                    color: widget.activity.isLiked ? paletteRed : textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
