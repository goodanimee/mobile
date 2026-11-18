import '../models/activity_reply.dart';
import '../models/user_activity.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API client for AniList activities and comments operations.
class ActivityApi {
  /// Fetches a single activity by its [activityId].
  static Future<UserActivity> getActivityById({
    required int activityId,
    required String token,
  }) async {
    final request = GetActivityByIdRequest(activityId: activityId);
    final bytes = await FfiCore.executeProtoCall(
      'GetActivityById',
      request.writeToBuffer(),
      token,
    );
    final response = GetActivityByIdResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return UserActivity.fromProto(response.activity);
  }

  /// Fetches paginated replies for [activityId].
  static Future<ActivityRepliesPage> getActivityReplies({
    required int activityId,
    int page = 1,
    int perPage = 25,
    required String token,
  }) async {
    final request = GetActivityRepliesRequest(
      activityId: activityId,
      page: page,
      perPage: perPage,
    );
    final bytes = await FfiCore.executeProtoCall(
      'GetActivityReplies',
      request.writeToBuffer(),
      token,
    );
    final response = GetActivityRepliesResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return ActivityRepliesPage.fromProto(response);
  }

  /// Posts or edits an activity reply.
  static Future<ActivityReply> saveActivityReply({
    required int activityId,
    required String text,
    int? replyId,
    required String token,
  }) async {
    final request = SaveActivityReplyRequest(
      activityId: activityId,
      text: text,
      replyId: replyId,
    );
    final bytes = await FfiCore.executeProtoCall(
      'SaveActivityReply',
      request.writeToBuffer(),
      token,
    );
    final response = SaveActivityReplyResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return ActivityReply.fromProto(response.reply);
  }

  /// Toggles like status for an activity reply.
  static Future<ToggleActivityReplyLikeResponse> toggleActivityReplyLike({
    required int replyId,
    required String token,
  }) async {
    final request = ToggleActivityReplyLikeRequest(replyId: replyId);
    final bytes = await FfiCore.executeProtoCall(
      'ToggleActivityReplyLike',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleActivityReplyLikeResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }
}
