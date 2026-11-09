import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/lucide_icons_helper.dart';
import 'package:goodanime/models/activity_reply.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/user_activity.dart';
import 'package:goodanime/pages/activity/widgets/activity_comments_sheet.dart';
import 'package:goodanime/proto/api.pb.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  const dummyUser1 = UserActivityAuthor(id: 101, name: 'Kurisu');
  const dummyUser2 = UserActivityAuthor(id: 102, name: 'Okabe');

  final dummyReply1 = ActivityReply(
    id: 1,
    userId: 101,
    activityId: 42,
    text: '<p>This anime is fantastic!</p>',
    createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 600,
    likeCount: 2,
    user: dummyUser1,
  );

  final dummyReply2 = ActivityReply(
    id: 2,
    userId: 102,
    activityId: 42,
    text: '<p>El Psy Kongroo.</p>',
    createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 300,
    user: dummyUser2,
  );

  Widget createSubject({
    int activityId = 42,
    int? initialReplyCount,
    void Function(int)? onReplyCountChanged,
    Future<ActivityRepliesPage> Function(int, int)? fetchReplies,
    Future<ActivityReply> Function(int, String)? saveReply,
    Future<ToggleActivityReplyLikeResponse> Function(int)? toggleLike,
    DraggableScrollableController? sheetController,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ActivityCommentsSheet(
          activityId: activityId,
          initialReplyCount: initialReplyCount,
          onReplyCountChanged: onReplyCountChanged,
          fetchReplies: fetchReplies,
          saveReply: saveReply,
          toggleLike: toggleLike,
          sheetController: sheetController,
        ),
      ),
    );
  }

  group('ActivityCommentsSheet widget tests', () {
    testWidgets('renders comments list with header count, author, and text', (
      tester,
    ) async {
      await tester.pumpWidget(
        createSubject(
          initialReplyCount: 2,
          fetchReplies: (id, page) async => ActivityRepliesPage(
            pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
            replies: [dummyReply1, dummyReply2],
            total: 2,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Comments (2)'), findsOneWidget);
      expect(find.text('Kurisu'), findsOneWidget);
      expect(find.text('This anime is fantastic!'), findsOneWidget);
      expect(find.text('Okabe'), findsOneWidget);
      expect(find.text('El Psy Kongroo.'), findsOneWidget);
      expect(find.text('Reply'), findsNWidgets(2));
    });

    testWidgets('renders empty state when there are no comments', (
      tester,
    ) async {
      await tester.pumpWidget(
        createSubject(
          fetchReplies: (id, page) async => const ActivityRepliesPage(
            pageInfo: PageInfo(hasNextPage: false, currentPage: 1),
            replies: [],
            total: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Comments (0)'), findsOneWidget);
      expect(find.text('No comments yet'), findsOneWidget);
      expect(find.text('Be the first to share your thoughts!'), findsOneWidget);
    });

    testWidgets('starts and cancels replying to an author', (tester) async {
      await tester.pumpWidget(
        createSubject(
          fetchReplies: (id, page) async => ActivityRepliesPage(
            pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
            replies: [dummyReply1],
            total: 1,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Replying to @Kurisu'), findsNothing);

      await tester.tap(find.text('Reply'));
      await tester.pumpAndSettle();

      expect(find.text('Replying to @Kurisu'), findsOneWidget);
      expect(find.text('@Kurisu '), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.x).last);
      await tester.pumpAndSettle();

      expect(find.text('Replying to @Kurisu'), findsNothing);
    });

    testWidgets('posts comment, increments count, and clears input', (
      tester,
    ) async {
      int? reportedCount;
      String? submittedText;

      final createdReply = ActivityReply(
        id: 3,
        userId: 999,
        activityId: 42,
        text: '<p>Testing comment submission</p>',
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        user: const UserActivityAuthor(id: 999, name: 'CurrentViewer'),
      );

      await tester.pumpWidget(
        createSubject(
          initialReplyCount: 1,
          onReplyCountChanged: (count) => reportedCount = count,
          fetchReplies: (id, page) async => ActivityRepliesPage(
            pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
            replies: [dummyReply1],
            total: 1,
          ),
          saveReply: (id, text) async {
            submittedText = text;
            return createdReply;
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Comments (1)'), findsOneWidget);

      await tester.enterText(
        find.byType(TextField),
        'Testing comment submission',
      );
      await tester.pump();

      await tester.tap(find.byIcon(LucideIcons.send));
      await tester.pumpAndSettle();

      expect(submittedText, equals('Testing comment submission'));
      expect(find.text('Comments (2)'), findsOneWidget);
      expect(find.text('CurrentViewer'), findsOneWidget);
      expect(find.text('Testing comment submission'), findsOneWidget);
      expect(reportedCount, equals(2));
      expect(find.text('Add a comment...'), findsOneWidget);
    });

    testWidgets('toggles like optimistically and updates state on success', (
      tester,
    ) async {
      int? likedReplyId;

      await tester.pumpWidget(
        createSubject(
          fetchReplies: (id, page) async => ActivityRepliesPage(
            pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
            replies: [dummyReply1],
            total: 1,
          ),
          toggleLike: (replyId) async {
            likedReplyId = replyId;
            return ToggleActivityReplyLikeResponse(
              replyId: replyId,
              likedUserIds: [101, 102, 999],
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byType(LucideHeartIcon));
      await tester.pump();

      expect(find.text('3'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(likedReplyId, equals(1));
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('reverts optimistic like when toggleLike throws error', (
      tester,
    ) async {
      await tester.pumpWidget(
        createSubject(
          fetchReplies: (id, page) async => ActivityRepliesPage(
            pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
            replies: [dummyReply1],
            total: 1,
          ),
          toggleLike: (replyId) async {
            await Future<void>.delayed(const Duration(milliseconds: 50));
            throw Exception('Network error');
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byType(LucideHeartIcon));
      await tester.pump();

      expect(find.text('3'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 60));
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('dismisses bottom sheet when close button is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ActivityCommentsSheet(
                      activityId: 42,
                      initialReplyCount: 0,
                      fetchReplies: (id, page) async =>
                          const ActivityRepliesPage(
                            pageInfo: PageInfo(
                              hasNextPage: false,
                              currentPage: 1,
                            ),
                            replies: [],
                            total: 0,
                          ),
                    ),
                  );
                },
                child: const Text('Open Sheet'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Comments (0)'), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.x).first);
      await tester.pumpAndSettle();

      expect(find.text('Comments (0)'), findsNothing);
    });

    testWidgets('renders backdrop blur and 60% default initial height', (
      tester,
    ) async {
      final controller = DraggableScrollableController();

      await tester.pumpWidget(
        createSubject(
          sheetController: controller,
          fetchReplies: (id, page) async => const ActivityRepliesPage(
            pageInfo: PageInfo(hasNextPage: false, currentPage: 1),
            replies: [],
            total: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(controller.size, closeTo(0.6, 0.01));

      final sheet = tester.widget<DraggableScrollableSheet>(
        find.byType(DraggableScrollableSheet),
      );
      expect(sheet.initialChildSize, equals(0.6));
      expect(sheet.minChildSize, equals(0.35));
      expect(sheet.maxChildSize, equals(0.95));
    });

    testWidgets('resizes sheet when dragging header and expands on focus', (
      tester,
    ) async {
      final controller = DraggableScrollableController();

      await tester.pumpWidget(
        createSubject(
          sheetController: controller,
          fetchReplies: (id, page) async => const ActivityRepliesPage(
            pageInfo: PageInfo(hasNextPage: false, currentPage: 1),
            replies: [],
            total: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(controller.size, closeTo(0.6, 0.01));

      await tester.drag(find.text('Comments (0)'), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(controller.size, greaterThan(0.65));

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(controller.size, closeTo(0.95, 0.01));
    });
  });
}
