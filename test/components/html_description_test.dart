import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/html_description.dart';
import 'package:goodanime/components/html_description_widgets.dart';

/// Widget tests for [HtmlDescription] AniList HTML and markdown support.
void main() {
  Widget buildSubject(String html) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: HtmlDescription(html: html)),
      ),
    );
  }

  testWidgets(
    'renders multi-section bio with center blocks, hr dividers, newlines, links, and sized image',
    (tester) async {
      const multiSectionLoremHtml =
          '<center>_"Lorem ipsum dolor sit amet, consectetur adipiscing elit."_</center> \n'
          '<p>lorem | 23 | ipsum | dolor/sit | amet consectetur</p>\n'
          '<p>first item: lorem ipsum (2001)<br />\n'
          'second item: dolor sit </p>\n'
          '<p>third item: ut enim ad minim veniam. </p>\n'
          '<hr>\n'
          '<center>Lorem Section</center>\n'
          '<center>consectetur adipiscing elit\n'
          '100 - sed do eiusmod tempor incididunt\n'
          '91-99 - ut labore et dolore magna aliqua\n'
          '<=50 ut enim ad minim veniam. </center>\n'
          '<center>[lorem badges](https://example.com/lorem)</center>\n'
          '<hr>\n'
          '<center>adipiscing theme\n'
          'https://anilist.co/anime/1/Lorem-Ipsum/\n'
          'https://anilist.co/manga/2/Dolor-Sit/\n'
          ' </center>\n'
          "<center><img width='350' src='https://example.com/lorem.jpg'> </center>";

      await tester.pumpWidget(buildSubject(multiSectionLoremHtml));
      await tester.pump();

      expect(find.byType(Divider), findsNWidgets(2));

      expect(
        find.text('"Lorem ipsum dolor sit amet, consectetur adipiscing elit."'),
        findsOneWidget,
      );
      expect(find.textContaining('_"Lorem'), findsNothing);

      expect(find.text('Lorem Section'), findsOneWidget);

      final multiLineCentered = tester.widget<Text>(
        find.byWidgetPredicate(
          (w) =>
              w is Text &&
              (w.textSpan?.toPlainText().contains(
                    '100 - sed do eiusmod tempor incididunt\n91-99',
                  ) ??
                  false),
        ),
      );
      expect(multiLineCentered.textAlign, TextAlign.center);
      expect(
        multiLineCentered.textSpan!.toPlainText(),
        contains('<=50 ut enim ad minim veniam.'),
      );

      expect(find.text('lorem badges'), findsOneWidget);

      final themeBlock = tester.widget<Text>(
        find.byWidgetPredicate(
          (w) =>
              w is Text &&
              (w.textSpan?.toPlainText().contains(
                    'https://anilist.co/anime/1/Lorem-Ipsum/',
                  ) ??
                  false),
        ),
      );
      expect(themeBlock.textAlign, TextAlign.center);
      final rootSpan = themeBlock.textSpan! as TextSpan;
      final recognizerCount = <GestureRecognizer>[];
      rootSpan.visitChildren((span) {
        if (span is TextSpan && span.recognizer != null) {
          recognizerCount.add(span.recognizer!);
        }
        return true;
      });
      expect(recognizerCount.length, 2);

      final imgEmbed = tester.widget<HtmlImageEmbed>(
        find.byType(HtmlImageEmbed),
      );
      expect(imgEmbed.src, 'https://example.com/lorem.jpg');
      expect(imgEmbed.widthAttr, '350');
    },
  );

  testWidgets(
    'supports headings h4-h6, blockquote, pre/code, strikethrough, and inline markdown',
    (tester) async {
      const richHtml =
          '<h4>Heading Four</h4>'
          '<h5>Heading Five</h5>'
          '<h6>Heading Six</h6>'
          '<blockquote><p>Lorem quoted text</p></blockquote>'
          '<pre><code>const lorem = 42;\nprint(lorem);</code></pre>'
          '<p>Inline <del>deleted</del> and <code>snippet</code> text</p>'
          '<center>**bold lorem** and ~~struck lorem~~ and ~!hidden lorem!~</center>';

      await tester.pumpWidget(buildSubject(richHtml));
      await tester.pump();

      expect(find.text('Heading Four'), findsOneWidget);
      expect(find.text('Heading Five'), findsOneWidget);
      expect(find.text('Heading Six'), findsOneWidget);
      expect(find.text('Lorem quoted text'), findsOneWidget);
      expect(
        find.textContaining('const lorem = 42;\nprint(lorem);'),
        findsOneWidget,
      );
      expect(find.textContaining('deleted'), findsOneWidget);

      expect(find.text('Spoiler'), findsOneWidget);
      expect(find.text('hidden lorem'), findsNothing);

      await tester.tap(find.text('Spoiler'));
      await tester.pump();

      expect(find.text('hidden lorem'), findsOneWidget);
    },
  );

  testWidgets(
    'renders tappable YouTube and Video link cards and clickable linked images',
    (tester) async {
      const mediaHtml =
          '<div class="youtube" id="dQw4w9WgXcQ"></div>'
          '<video><source src="https://files.example.com/demo.webm" type="video/webm"></video>'
          '<center><a href="https://example.com/target"><img width="120" src="https://example.com/badge.png"></a></center>';

      await tester.pumpWidget(buildSubject(mediaHtml));
      await tester.pump();

      expect(find.byType(HtmlYoutubeCard), findsOneWidget);
      expect(find.text('Watch on YouTube'), findsOneWidget);

      expect(find.byType(HtmlVideoCard), findsOneWidget);
      expect(find.text('Open Video'), findsOneWidget);
      expect(find.text('files.example.com - demo.webm'), findsOneWidget);

      final badgeEmbed = tester.widget<HtmlImageEmbed>(
        find.byType(HtmlImageEmbed),
      );
      expect(badgeEmbed.linkUrl, 'https://example.com/target');
      expect(badgeEmbed.widthAttr, '120');
    },
  );
}
