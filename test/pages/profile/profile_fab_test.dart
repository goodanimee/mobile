import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/pages/profile/widgets/profile_fab.dart';
import 'package:goodanime/theme/theme.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget tests for [ProfileFab].
void main() {
  Widget buildFab({
    required bool isSelf,
    bool isFollowing = false,
    bool isFollowLoading = false,
    VoidCallback? onToggleFollow,
    VoidCallback? onSignOut,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ProfileFab(
            isSelf: isSelf,
            isFollowing: isFollowing,
            isFollowLoading: isFollowLoading,
            onToggleFollow: onToggleFollow,
            onSignOut: onSignOut,
          ),
        ),
      ),
    );
  }

  testWidgets('renders sign out FAB for self with redAccent icon only', (
    tester,
  ) async {
    await tester.pumpWidget(buildFab(isSelf: true, onSignOut: () {}));
    await tester.pumpAndSettle();

    final iconFinder = find.byIcon(LucideIcons.logOut);
    expect(iconFinder, findsOneWidget);

    final icon = tester.widget<Icon>(iconFinder);
    expect(icon.color, Colors.redAccent);

    final containerFinder = find.ancestor(
      of: iconFinder,
      matching: find.byType(Container),
    );
    expect(containerFinder, findsWidgets);

    final container = tester.widget<Container>(containerFinder.first);
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, bgColor);
    expect(decoration.border?.top.color, cardBorderColor);
  });

  testWidgets('shows confirmation dialog on sign out tap and handles cancel', (
    tester,
  ) async {
    bool signOutTapped = false;
    await tester.pumpWidget(
      buildFab(isSelf: true, onSignOut: () => signOutTapped = true),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(LucideIcons.logOut));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to sign out?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to sign out?'), findsNothing);
    expect(signOutTapped, isFalse);
  });

  testWidgets('shows confirmation dialog on sign out tap and handles confirm', (
    tester,
  ) async {
    bool signOutTapped = false;
    await tester.pumpWidget(
      buildFab(isSelf: true, onSignOut: () => signOutTapped = true),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(LucideIcons.logOut));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to sign out?'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Sign Out'));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to sign out?'), findsNothing);
    expect(signOutTapped, isTrue);
  });

  testWidgets('renders nothing for self when onSignOut is null', (
    tester,
  ) async {
    await tester.pumpWidget(buildFab(isSelf: true));
    await tester.pumpAndSettle();

    expect(find.byIcon(LucideIcons.logOut), findsNothing);
  });

  testWidgets('renders follow FAB when not self and not following', (
    tester,
  ) async {
    bool toggleTapped = false;
    await tester.pumpWidget(
      buildFab(isSelf: false, onToggleFollow: () => toggleTapped = true),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(LucideIcons.userPlus), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.userPlus));
    expect(toggleTapped, isTrue);
  });

  testWidgets('renders following FAB when not self and isFollowing', (
    tester,
  ) async {
    bool toggleTapped = false;
    await tester.pumpWidget(
      buildFab(
        isSelf: false,
        isFollowing: true,
        onToggleFollow: () => toggleTapped = true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(LucideIcons.userCheck), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.userCheck));
    expect(toggleTapped, isTrue);
  });

  testWidgets('renders progress indicator when follow operation is loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildFab(isSelf: false, isFollowLoading: true, onToggleFollow: () {}),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(LucideIcons.userPlus), findsNothing);
    expect(find.byIcon(LucideIcons.userCheck), findsNothing);
  });
}
