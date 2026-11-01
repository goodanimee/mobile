import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/floating_nav.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 24,
            right: 20,
            child: child,
          ),
        ],
      ),
    ),
  );
}

void main() {
  group('FloatingNav Custom Lists Integration', () {
    testWidgets('renders quick nav sections, divider, and custom lists button', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          FloatingNav(
            selectedIndex: 0,
            onTap: (_) {},
            quickNavSections: [
              QuickNavSection(
                icon: LucideIcons.playCircle,
                label: 'Watching',
                onTap: () {},
              ),
              QuickNavSection(
                icon: LucideIcons.badgeCheck,
                label: 'Completed',
                onTap: () {},
              ),
            ],
            mediaType: 'ANIME',
            customLists: const ['Tier S', 'Tier A'],
            showCustomListManagement: false,
          ),
        ),
      );

      // Tap FAB to open floating nav
      await tester.tap(find.byType(FloatingNav));
      await tester.pumpAndSettle();

      expect(find.byIcon(LucideIcons.playCircle), findsOneWidget);
      expect(find.byIcon(LucideIcons.badgeCheck), findsOneWidget);
      expect(find.byIcon(LucideIcons.folderCog), findsOneWidget);
    });

    testWidgets(
      'toggling custom lists button opens panel showing custom lists without management controls',
      (tester) async {
        String? selectedList;

        await tester.pumpWidget(
          _wrap(
            FloatingNav(
              selectedIndex: 0,
              onTap: (_) {},
              quickNavSections: [
                QuickNavSection(
                  icon: LucideIcons.playCircle,
                  label: 'Watching',
                  onTap: () {},
                ),
              ],
              mediaType: 'ANIME',
              customLists: const ['Favorites', 'Top 10'],
              activeCustomList: 'Favorites',
              showCustomListManagement: false,
              onSelectCustomList: (name) => selectedList = name,
            ),
          ),
        );

        // Tap FAB to open
        await tester.tap(find.byType(FloatingNav));
        await tester.pumpAndSettle();

        // Custom lists panel automatically opens because activeCustomList != null
        expect(find.text('Custom Lists'), findsOneWidget);
        expect(find.text('Favorites'), findsOneWidget);
        expect(find.text('Top 10'), findsOneWidget);
        expect(find.byIcon(LucideIcons.plus), findsNothing);
        expect(find.byIcon(LucideIcons.trash2), findsNothing);

        // Tap a custom list
        await tester.tap(find.text('Top 10'));
        await tester.pumpAndSettle();

        expect(selectedList, equals('Top 10'));
      },
    );
  });
}
