import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/activity_reply.dart';
import 'package:goodanime/models/media_activity.dart';
import 'package:goodanime/models/user_activity.dart';
import 'package:goodanime/proto/api.pb.dart' as pb_api;
import 'package:goodanime/proto/common.pb.dart' as pb_common;
import 'package:goodanime/proto/media_activity.pb.dart' as pb_media_act;
import 'package:goodanime/proto/user.pb.dart' as pb_user;

void main() {
  group('ActivityReply model & protobuf mapping', () {
    test('roundtrips ActivityReply through protobuf', () {
      const reply = ActivityReply(
        id: 501,
        userId: 42,
        activityId: 1001,
        text: '<p>Great update!</p>',
        createdAt: 1700000000,
        likeCount: 3,
        isLiked: true,
        user: UserActivityAuthor(
          id: 42,
          name: 'animelover',
          avatarLarge: 'https://img.com/u42_lg.jpg',
          avatarMedium: 'https://img.com/u42_med.jpg',
        ),
      );

      final proto = reply.toProto();
      expect(proto.id, 501);
      expect(proto.userId, 42);
      expect(proto.activityId, 1001);
      expect(proto.text, '<p>Great update!</p>');
      expect(proto.likeCount, 3);
      expect(proto.isLiked, isTrue);
      expect(proto.user.name, 'animelover');

      final restored = ActivityReply.fromProto(proto);
      expect(restored.id, reply.id);
      expect(restored.userId, reply.userId);
      expect(restored.activityId, reply.activityId);
      expect(restored.text, reply.text);
      expect(restored.createdAt, reply.createdAt);
      expect(restored.likeCount, reply.likeCount);
      expect(restored.isLiked, reply.isLiked);
      expect(restored.user?.id, reply.user?.id);
      expect(restored.user?.name, reply.user?.name);
    });

    test('toggleLikeOptimistic flips like state and clamps count', () {
      const unliked = ActivityReply(
        id: 1,
        userId: 2,
        activityId: 3,
        text: 'Hello',
        likeCount: 0,
        isLiked: false,
      );

      final liked = unliked.toggleLikeOptimistic();
      expect(liked.isLiked, isTrue);
      expect(liked.likeCount, 1);

      final toggledBack = liked.toggleLikeOptimistic();
      expect(toggledBack.isLiked, isFalse);
      expect(toggledBack.likeCount, 0);

      const zeroLiked = ActivityReply(
        id: 1,
        userId: 2,
        activityId: 3,
        text: 'Hello',
        likeCount: 0,
        isLiked: true,
      );
      expect(zeroLiked.toggleLikeOptimistic().likeCount, 0);
    });

    test('ActivityRepliesPage converts from protobuf response correctly', () {
      final pbResponse = pb_api.GetActivityRepliesResponse(
        total: 1,
        pageInfo: pb_common.PageInfo(currentPage: 1, hasNextPage: false),
        replies: [
          pb_user.ActivityReply(
            id: 10,
            userId: 20,
            activityId: 30,
            text: 'Test comment',
            createdAt: 1710000000,
            likeCount: 0,
            isLiked: false,
          ),
        ],
      );

      final page = ActivityRepliesPage.fromProto(pbResponse);
      expect(page.total, 1);
      expect(page.pageInfo.currentPage, 1);
      expect(page.pageInfo.hasNextPage, isFalse);
      expect(page.replies.length, 1);
      expect(page.replies.first.id, 10);
      expect(page.replies.first.text, 'Test comment');
    });

    test('ListActivity supports replyCount in protobuf mapping', () {
      final pbList = pb_media_act.ListActivity(
        id: 99,
        createdAt: 1700000000,
        isLiked: false,
        likeCount: 2,
        replyCount: 5,
        progress: '12',
        status: 'completed',
      );

      final listActivity = ListActivity.fromProto(pbList);
      expect(listActivity.replyCount, 5);

      final restoredProto = listActivity.toProto();
      expect(restoredProto.replyCount, 5);
    });
  });
}
