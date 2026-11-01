import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/custom_lists/custom_list_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('CustomListPanel', () {
    testWidgets('renders management controls when showManagementControls is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const CustomListPanel(
            mediaType: 'ANIME',
            customLists: ['Favorites', 'Watch Later'],
          ),
        ),
      );

      expect(find.text('Custom Lists'), findsOneWidget);
      expect(find.byIcon(LucideIcons.plus), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Watch Later'), findsOneWidget);
      expect(find.byIcon(LucideIcons.trash2), findsNWidgets(2));
    });

    testWidgets(
      'hides management controls in read-only mode and highlights active custom list',
      (tester) async {
        String? selectedName;

        await tester.pumpWidget(
          _wrap(
            CustomListPanel(
              mediaType: 'ANIME',
              customLists: const ['Tier S', 'Masterpieces', 'Classics'],
              activeCustomList: 'Masterpieces',
              showManagementControls: false,
              onSelectList: (name) => selectedName = name,
            ),
          ),
        );

        expect(find.text('Custom Lists'), findsOneWidget);
        expect(find.byIcon(LucideIcons.plus), findsNothing);
        expect(find.byIcon(LucideIcons.trash2), findsNothing);
        expect(find.text('Tier S'), findsOneWidget);
        expect(find.text('Masterpieces'), findsOneWidget);
        expect(find.text('Classics'), findsOneWidget);

        await tester.tap(find.text('Tier S'));
        await tester.pumpAndSettle();

        expect(selectedName, equals('Tier S'));
      },
    );

    testWidgets('renders empty state without create button in read-only mode', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const CustomListPanel(
            mediaType: 'ANIME',
            customLists: [],
            showManagementControls: false,
          ),
        ),
      );

      expect(find.text('No custom lists yet'), findsOneWidget);
      expect(find.text('Create a custom list'), findsNothing);
      expect(find.byIcon(LucideIcons.plus), findsNothing);
    });
  });
}
