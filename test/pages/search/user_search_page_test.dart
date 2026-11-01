import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/pages/search/page.dart';
import 'package:goodanime/pages/search/widgets/layout/search_type_selector.dart';
import 'package:goodanime/pages/search/widgets/layout/user_results_list.dart';

void main() {
  group('SearchTypeSelector (Users)', () {
    testWidgets('renders Users chip and triggers onChanged with USER', (
      tester,
    ) async {
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchTypeSelector(
              selectedType: 'ANIME',
              onChanged: (val) => selected = val,
            ),
          ),
        ),
      );

      expect(find.text('Users'), findsOneWidget);

      await tester.tap(find.text('Users'));
      await tester.pump();

      expect(selected, 'USER');
    });
  });

  group('SearchPage User Search Integration', () {
    testWidgets('switching to Users type activates UserResultsList', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pump();

      expect(find.text('Users'), findsOneWidget);
      expect(find.byType(UserResultsList), findsNothing);

      await tester.tap(find.text('Users'));
      await tester.pump();

      expect(find.byType(UserResultsList), findsOneWidget);
    });
  });
}
