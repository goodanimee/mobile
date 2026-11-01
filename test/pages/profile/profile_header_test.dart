import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/social_user.dart';
import 'package:goodanime/models/user_profile.dart';
import 'package:goodanime/pages/profile/widgets/profile_header.dart';
import 'package:goodanime/pages/profile/widgets/profile_sticky_header.dart';
import 'package:goodanime/utils/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget tests for [ProfileHeader] and [ProfileStickyHeader].
void main() {
  const sampleProfile = UserProfile(
    id: 5114158,
    name: 'thedrone7',
    followersCount: 1250,
    followingCount: 340,
    isFollower: true,
  );

  Widget buildHeader({
    UserProfile profile = sampleProfile,
    SocialSegment? activeSocialSegment,
    VoidCallback? onTapFollowing,
    VoidCallback? onTapFollowers,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: ProfileHeader(
            profile: profile,
            activeSocialSegment: activeSocialSegment,
            onTapFollowing: onTapFollowing,
            onTapFollowers: onTapFollowers,
          ),
        ),
      ),
    );
  }

  Widget buildStickyHeader({
    UserProfile profile = sampleProfile,
    bool showStickyBar = false,
    VoidCallback? onBack,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ProfileStickyHeader(
          profile: profile,
          showStickyBar: showStickyBar,
          onBack: onBack,
        ),
      ),
    );
  }

  testWidgets('renders identity and social counts without user ID', (
    tester,
  ) async {
    await tester.pumpWidget(buildHeader());
    await tester.pumpAndSettle();

    expect(find.text('thedrone7'), findsOneWidget);
    expect(find.text('#5114158'), findsNothing);
    expect(find.text('Follows you'), findsOneWidget);
    expect(
      find.text(StringUtils.formatCompactNumber(sampleProfile.followingCount)),
      findsOneWidget,
    );
    expect(find.text('Following'), findsWidgets);
    expect(
      find.text(StringUtils.formatCompactNumber(sampleProfile.followersCount)),
      findsOneWidget,
    );
    expect(find.text('Followers'), findsOneWidget);
    expect(find.byIcon(LucideIcons.chevronRight), findsNWidgets(2));

    final avatarContainer = tester.getRect(
      find
          .ancestor(of: find.byType(ClipOval), matching: find.byType(Container))
          .first,
    );
    final chipMaterial = tester.getRect(
      find
          .ancestor(of: find.text('Following'), matching: find.byType(Material))
          .first,
    );
    expect(chipMaterial.bottom, equals(avatarContainer.bottom));
  });

  testWidgets(
    'invokes onTapFollowing and onTapFollowers callbacks when tapped',
    (tester) async {
      bool followingTapped = false;
      bool followersTapped = false;

      await tester.pumpWidget(
        buildHeader(
          onTapFollowing: () => followingTapped = true,
          onTapFollowers: () => followersTapped = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Following'));
      expect(followingTapped, isTrue);

      await tester.tap(find.text('Followers'));
      expect(followersTapped, isTrue);
    },
  );

  testWidgets(
    'renders active chip with close cross icon when activeSocialSegment is set',
    (tester) async {
      await tester.pumpWidget(
        buildHeader(activeSocialSegment: SocialSegment.following),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(LucideIcons.x), findsOneWidget);
      expect(find.byIcon(LucideIcons.chevronRight), findsOneWidget);
    },
  );

  testWidgets(
    'renders active followers chip with close cross icon when activeSocialSegment is followers',
    (tester) async {
      await tester.pumpWidget(
        buildHeader(activeSocialSegment: SocialSegment.followers),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(LucideIcons.x), findsOneWidget);
      expect(find.byIcon(LucideIcons.chevronRight), findsOneWidget);
    },
  );

  testWidgets('sticky header renders back button only when onBack provided', (
    tester,
  ) async {
    bool backPressed = false;
    await tester.pumpWidget(
      buildStickyHeader(onBack: () => backPressed = true),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
    expect(find.byIcon(LucideIcons.share2), findsOneWidget);
    await tester.tap(find.byIcon(LucideIcons.arrowLeft));
    expect(backPressed, isTrue);

    await tester.pumpWidget(buildStickyHeader());
    await tester.pumpAndSettle();

    expect(find.byIcon(LucideIcons.arrowLeft), findsNothing);
    expect(find.byIcon(LucideIcons.share2), findsOneWidget);
  });

  testWidgets('sticky header fades username in when showStickyBar is true', (
    tester,
  ) async {
    await tester.pumpWidget(buildStickyHeader());
    await tester.pumpAndSettle();

    AnimatedOpacity opacity = tester.widget(find.byType(AnimatedOpacity));
    expect(opacity.opacity, 0.0);

    await tester.pumpWidget(buildStickyHeader(showStickyBar: true));
    await tester.pumpAndSettle();

    opacity = tester.widget(find.byType(AnimatedOpacity));
    expect(opacity.opacity, 1.0);
    expect(find.text('thedrone7'), findsOneWidget);
  });

  testWidgets('does not display follower badge when isFollower is false', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHeader(profile: sampleProfile.copyWith(isFollower: false)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Follows you'), findsNothing);
    expect(find.text('thedrone7'), findsOneWidget);
  });
}
