import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/media_options/custom_list_selector.dart';
import 'package:goodanime/services/custom_list_service.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Widget tests for CustomListSelector.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    CustomListService.instance.reset();
    await CustomListService.instance.init();
    await CustomListService.instance.setCustomLists('ANIME', [
      'Favorites',
      'Top Tier',
    ]);
  });

  Widget buildWidget({
    required List<String> selected,
    required ValueChanged<List<String>> onChanged,
    String mediaType = 'ANIME',
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CustomListSelector(
          mediaType: mediaType,
          selectedCustomLists: selected,
          onCustomListsChanged: onChanged,
        ),
      ),
    );
  }

  testWidgets('renders list names and switches with correct selection state', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildWidget(selected: ['Favorites'], onChanged: (_) {}),
    );
    await tester.pumpAndSettle();

    expect(find.text('Custom Lists'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Top Tier'), findsOneWidget);

    final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
    expect(switches.length, 2);
    expect(switches[0].value, isTrue);
    expect(switches[1].value, isFalse);
  });

  testWidgets('toggling switch triggers onCustomListsChanged callback', (
    tester,
  ) async {
    List<String>? updated;

    await tester.pumpWidget(
      buildWidget(selected: ['Favorites'], onChanged: (val) => updated = val),
    );
    await tester.pumpAndSettle();

    final switches = find.byType(Switch);
    await tester.tap(switches.at(1));
    await tester.pump();

    expect(updated, ['Favorites', 'Top Tier']);
  });

  testWidgets('renders empty state when no custom lists exist', (tester) async {
    await CustomListService.instance.setCustomLists('MANGA', []);

    await tester.pumpWidget(
      buildWidget(selected: [], onChanged: (_) {}, mediaType: 'MANGA'),
    );
    await tester.pumpAndSettle();

    expect(find.text('No custom lists yet'), findsOneWidget);
    expect(find.text('Create a custom list'), findsOneWidget);
  });

  testWidgets('plus icon reveals inline add field', (tester) async {
    await tester.pumpWidget(buildWidget(selected: [], onChanged: (_) {}));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byIcon(LucideIcons.plus));
    await tester.pump();

    expect(find.byType(TextField), findsOneWidget);
  });
}
