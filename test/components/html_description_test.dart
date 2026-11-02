import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/html_anilist_link_card.dart';
import 'package:goodanime/components/html_description.dart';
import 'package:goodanime/components/html_description_widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  group('HtmlDescription.unpackAccidentalCodeBlocks', () {
    test(
      'unpacks accidental code block with markdown heading in language attribute',
      () {
        const input = '''
<pre><code class="language-**Fall 2023 Anime I&#039;m Excited For**">
&lt;span class='markdown_spoiler'&gt;&lt;span&gt;https://anilist.co/anime/161645/The-Apothecary-Diaries/&lt;/span&gt;&lt;/span&gt;
</code></pre>''';

        final unpacked = HtmlDescription.unpackAccidentalCodeBlocks(input);

        expect(unpacked.contains('<pre'), isFalse);
        expect(unpacked.contains('</code>'), isFalse);
        expect(
          unpacked.contains("**Fall 2023 Anime I'm Excited For**"),
          isTrue,
        );
        expect(
          unpacked.contains(
            "<span class='markdown_spoiler'><span>https://anilist.co/anime/161645/The-Apothecary-Diaries/</span></span>",
          ),
          isTrue,
        );
      },
    );

    test(
      'unpacks accidental code block with escaped markup in language and content',
      () {
        const input = '''
<pre><code class="language-&lt;span class=&#039;markdown_spoiler&#039;&gt;&lt;span&gt;&lt;img width=&#039;600&#039; src=&#039;https://example.com/pic.png&#039;&gt;&lt;/span&gt;&lt;/span&gt; &lt;center&gt;">
I chose 5 anime from each season.
&lt;/center&gt;
</code></pre>''';

        final unpacked = HtmlDescription.unpackAccidentalCodeBlocks(input);

        expect(unpacked.contains('<pre'), isFalse);
        expect(
          unpacked.contains(
            '<img width=\'600\' src=\'https://example.com/pic.png\'>',
          ),
          isTrue,
        );
        expect(unpacked.contains('I chose 5 anime from each season.'), isTrue);
        expect(unpacked.contains('</center>'), isTrue);
      },
    );

    test('preserves legitimate programming language code blocks', () {
      const input = '''
<pre><code class="language-dart">
void main() {
  print('Hello, world!');
}
</code></pre>''';

      final unpacked = HtmlDescription.unpackAccidentalCodeBlocks(input);
      expect(unpacked, equals(input));
    });

    test('preserves plain unlabelled code blocks', () {
      const input = '''
<pre><code>
git status
git commit -m "feat: test"
</code></pre>''';

      final unpacked = HtmlDescription.unpackAccidentalCodeBlocks(input);
      expect(unpacked, equals(input));
    });
  });

  group('HtmlDescription widget rendering', () {
    testWidgets('renders unpacked accidental code block as rich elements', (
      tester,
    ) async {
      const accidentalPost = '''
<pre><code class="language-**Featured Shows**">
&lt;span class='markdown_spoiler'&gt;&lt;span&gt;Frieren Beyond Journey&#039;s End&lt;/span&gt;&lt;/span&gt;
</code></pre>''';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HtmlDescription(html: accidentalPost)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Featured Shows'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsNothing);
    });

    testWidgets('renders legitimate code block in scrollable code container', (
      tester,
    ) async {
      const legitimateCode = '''
<pre><code class="language-dart">
void main() {
    final x = 42;
}
</code></pre>''';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HtmlDescription(html: legitimateCode)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.textContaining('    final x = 42;'), findsOneWidget);
    });

    testWidgets(
      'promotes spoiler with AniList links to HtmlBlockSpoiler and renders link cards upon reveal',
      (tester) async {
        HtmlAnilistLinkCard.clearCache();
        HtmlAnilistLinkCard.debugResolverOverride = (target) async => null;

        const postWithSpoilerLinks = '''
**Fall 2023 Anime I'm Excited For**
<span class="markdown_spoiler"><span>https://anilist.co/anime/161645/The-Apothecary-Diaries/
https://anilist.co/anime/154587/Frieren-Beyond-Journeys-End/
</span></span>
''';

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: HtmlDescription(html: postWithSpoilerLinks)),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HtmlBlockSpoiler), findsOneWidget);
        expect(find.byType(HtmlInlineSpoiler), findsNothing);
        expect(find.text('Spoiler'), findsOneWidget);
        expect(find.byIcon(LucideIcons.eye), findsOneWidget);
        expect(find.byType(HtmlAnilistLinkCard), findsNothing);

        await tester.tap(find.text('Spoiler'));
        await tester.pumpAndSettle();

        expect(find.text('Hide Spoiler'), findsOneWidget);
        expect(find.byIcon(LucideIcons.eyeOff), findsOneWidget);
        expect(find.byType(HtmlAnilistLinkCard), findsNWidgets(2));

        await tester.tap(find.text('Hide Spoiler'));
        await tester.pumpAndSettle();

        expect(find.text('Spoiler'), findsOneWidget);
        expect(find.byType(HtmlAnilistLinkCard), findsNothing);
      },
    );

    testWidgets(
      'keeps inline spoiler without block elements as HtmlInlineSpoiler',
      (tester) async {
        const inlineSpoilerHtml =
            '<p>This is a <span class="markdown_spoiler"><span>secret inline spoiler</span></span> inside text.</p>';

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: HtmlDescription(html: inlineSpoilerHtml)),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HtmlInlineSpoiler), findsOneWidget);
        expect(find.byType(HtmlBlockSpoiler), findsNothing);
      },
    );
  });
}
