import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/user_activity.dart';
import 'package:goodanime/proto/api.pb.dart' as pb_api;
import 'package:goodanime/proto/common.pb.dart' as pb_common;

void main() {
  const sampleMedia = MediaMin(
    id: 21,
    type: 'ANIME',
    title: Title(
      english: 'One Piece',
      native: 'ONE PIECE',
      romaji: 'One Piece',
      userPreferred: 'One Piece',
    ),
    averageScore: 88,
    coverImage: CoverImage(
      medium: 'https://img.com/op_med.jpg',
      large: 'https://img.com/op_lg.jpg',
      extraLarge: 'https://img.com/op_xl.jpg',
      color: '#e4a15d',
    ),
    episodes: 1100,
    chapters: 0,
    volumes: 0,
    format: 'TV',
    isAdult: false,
    isFavourite: true,
    siteUrl: 'https://anilist.co/anime/21',
    startYear: 1999,
  );

  group('UserActivity model & protobuf mapping', () {
    test('roundtrips ListActivity, TextActivity, and MessageActivity', () {
      const listAct = UserActivity(
        id: 1001,
        type: 'ANIME_LIST',
        createdAt: 1700000000,
        isLiked: true,
        likeCount: 5,
        replyCount: 2,
        status: 'watched episode',
        progress: '1 - 3',
        user: UserActivityAuthor(
          id: 10,
          name: 'thedrone7',
          avatarLarge: 'https://img.com/u10_lg.jpg',
          avatarMedium: 'https://img.com/u10_med.jpg',
        ),
        media: sampleMedia,
      );

      const textAct = UserActivity(
        id: 1002,
        type: 'TEXT',
        createdAt: 1700000100,
        likeCount: 12,
        replyCount: 4,
        textHtml: '<p>Hello AniList!</p>',
        user: UserActivityAuthor(
          id: 10,
          name: 'thedrone7',
          avatarMedium: 'https://img.com/u10_med.jpg',
        ),
      );

      const msgAct = UserActivity(
        id: 1003,
        type: 'MESSAGE',
        createdAt: 1700000200,
        isPrivate: true,
        textHtml: '<p>Hey there!</p>',
        user: UserActivityAuthor(id: 20, name: 'friendUser'),
        recipient: UserActivityAuthor(id: 10, name: 'thedrone7'),
      );

      final restoredList = UserActivity.fromProto(listAct.toProto());
      expect(restoredList.id, 1001);
      expect(restoredList.kind, UserActivityKind.list);
      expect(restoredList.isLiked, isTrue);
      expect(restoredList.likeCount, 5);
      expect(restoredList.replyCount, 2);
      expect(restoredList.user?.avatarUrl, 'https://img.com/u10_lg.jpg');
      expect(restoredList.media?.id, 21);
      expect(restoredList.media?.startYear, 1999);

      final restoredText = UserActivity.fromProto(textAct.toProto());
      expect(restoredText.id, 1002);
      expect(restoredText.kind, UserActivityKind.text);
      expect(restoredText.textHtml, '<p>Hello AniList!</p>');
      expect(restoredText.user?.avatarUrl, 'https://img.com/u10_med.jpg');

      final restoredMsg = UserActivity.fromProto(msgAct.toProto());
      expect(restoredMsg.id, 1003);
      expect(restoredMsg.kind, UserActivityKind.message);
      expect(restoredMsg.isPrivate, isTrue);
      expect(restoredMsg.user?.name, 'friendUser');
      expect(restoredMsg.recipient?.name, 'thedrone7');

      final pageResp = pb_api.GetUserActivitiesResponse(
        pageInfo: pb_common.PageInfo(hasNextPage: true, currentPage: 1),
        activities: [listAct.toProto(), textAct.toProto(), msgAct.toProto()],
      );
      final page = UserActivityPage.fromProto(pageResp);
      expect(page.pageInfo.hasNextPage, isTrue);
      expect(page.pageInfo.currentPage, 1);
      expect(page.activities.length, 3);
    });

    test('formats list activity action prefixes and summaries cleanly', () {
      const watched = UserActivity(
        id: 1,
        type: 'ANIME_LIST',
        status: 'watched episode',
        progress: '4 - 6',
        media: sampleMedia,
      );
      expect(watched.formattedListPrefix, 'Watched episode 4 - 6 of');
      expect(
        watched.formattedListSummary,
        'Watched episode 4 - 6 of One Piece',
      );

      const completed = UserActivity(
        id: 2,
        type: 'ANIME_LIST',
        status: 'completed',
        media: sampleMedia,
      );
      expect(completed.formattedListPrefix, 'Completed');
      expect(completed.formattedListSummary, 'Completed One Piece');

      const planning = UserActivity(
        id: 3,
        type: 'MANGA_LIST',
        status: 'plans to read',
        media: sampleMedia,
      );
      expect(planning.formattedListSummary, 'Plans to read One Piece');
    });

    test(
      'toggleLikeOptimistic updates like state and clamps count at zero',
      () {
        const unliked = UserActivity(id: 50, type: 'TEXT');
        final liked = unliked.toggleLikeOptimistic();
        expect(liked.isLiked, isTrue);
        expect(liked.likeCount, 1);

        final backToUnliked = liked.toggleLikeOptimistic();
        expect(backToUnliked.isLiked, isFalse);
        expect(backToUnliked.likeCount, 0);

        const zeroCountLiked = UserActivity(
          id: 51,
          type: 'TEXT',
          isLiked: true,
        );
        final clamped = zeroCountLiked.toggleLikeOptimistic();
        expect(clamped.isLiked, isFalse);
        expect(clamped.likeCount, 0);
      },
    );

    test(
      'UserActivityTypeFilter exposes expected labels and API enum lists',
      () {
        expect(UserActivityTypeFilter.all.label, 'All');
        expect(UserActivityTypeFilter.listUpdates.label, 'Lists');
        expect(UserActivityTypeFilter.statusPosts.label, 'Posts');
        expect(UserActivityTypeFilter.messages.label, 'Messages');
        expect(UserActivityTypeFilter.all.apiTypes, isEmpty);
        expect(UserActivityTypeFilter.listUpdates.apiTypes, [
          'ANIME_LIST',
          'MANGA_LIST',
        ]);
        expect(UserActivityTypeFilter.statusPosts.apiTypes, ['TEXT']);
        expect(UserActivityTypeFilter.messages.apiTypes, ['MESSAGE']);
      },
    );
  });
}
