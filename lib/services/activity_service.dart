import '../api/activity_api.dart';
import '../models/activity_reply.dart';
import '../models/user_activity.dart';
import '../proto/api.pb.dart';
import 'auth_service.dart';

/// High-level service handling activity and reply actions.
class ActivityService {
  /// Fetches a single activity by [activityId].
  static Future<UserActivity> getActivityById(int activityId) async {
    final token = await AuthService.getRawToken() ?? '';
    return ActivityApi.getActivityById(activityId: activityId, token: token);
  }

  /// Fetches paginated replies for [activityId].
  static Future<ActivityRepliesPage> getActivityReplies(
    int activityId, {
    int page = 1,
    int perPage = 25,
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    return ActivityApi.getActivityReplies(
      activityId: activityId,
      page: page,
      perPage: perPage,
      token: token,
    );
  }

  /// Posts a new reply or edits an existing reply on an activity.
  static Future<ActivityReply> saveActivityReply({
    required int activityId,
    required String text,
    int? replyId,
  }) async {
    final token = await AuthService.getValidToken();
    return ActivityApi.saveActivityReply(
      activityId: activityId,
      text: text,
      replyId: replyId,
      token: token,
    );
  }

  /// Toggles the like status of an activity reply.
  static Future<ToggleActivityReplyLikeResponse> toggleActivityReplyLike(
    int replyId,
  ) async {
    final token = await AuthService.getValidToken();
    return ActivityApi.toggleActivityReplyLike(replyId: replyId, token: token);
  }
}
