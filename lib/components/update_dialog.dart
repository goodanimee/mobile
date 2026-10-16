import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/release_info.dart';
import '../services/update_service.dart';
import '../theme/theme.dart';
import '../utils/semver.dart';
import 'button.dart';

/// Minimal dialog prompting the user to download a new application release
class UpdateDialog extends StatelessWidget {
  /// Metadata for the available release
  final ReleaseInfo release;

  /// Creates an update prompt dialog
  const UpdateDialog({super.key, required this.release});

  /// Displays the update prompt dialog
  static Future<void> show(BuildContext context, ReleaseInfo release) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => UpdateDialog(release: release),
    );
  }

  Future<void> _handleLater(BuildContext context) async {
    await UpdateService.skipRelease(release.tagName);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleDownload(BuildContext context) async {
    final targetUrl = release.apkDownloadUrl ?? release.htmlUrl;
    final uri = Uri.tryParse(targetUrl);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  /// Builds the update dialog widget
  Widget build(BuildContext context) {
    final version = SemVer.parse(release.tagName).toString();

    return Dialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: cardBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Available',
              style: TextStyle(
                color: textPrimary,
                fontSize: fontTitle(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You can now update to version $version',
              style: TextStyle(
                color: textSecondary,
                fontSize: fontBody(context),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  onPress: () => _handleLater(context),
                  style: BoxStyler()
                      .color(Colors.transparent)
                      .padding(
                        EdgeInsetsMix.symmetric(horizontal: 16, vertical: 8),
                      )
                      .borderRadius(BorderRadiusMix.circular(6))
                      .border(
                        BorderMix.all(
                          BorderSideMix(color: cardBorderColor, width: 1.0),
                        ),
                      )
                      .onHovered(BoxStyler().color(hoverBgColor))
                      .onPressed(BoxStyler().color(pressBgColor)),
                  child: StyledText(
                    'Later',
                    style: TextStyler().color(textSecondary).fontSize(13),
                  ),
                ),
                const SizedBox(width: 12),
                Button(
                  onPress: () => _handleDownload(context),
                  style: BoxStyler()
                      .color(borderColor)
                      .padding(
                        EdgeInsetsMix.symmetric(horizontal: 16, vertical: 8),
                      )
                      .borderRadius(BorderRadiusMix.circular(6))
                      .border(
                        BorderMix.all(
                          BorderSideMix(color: borderColor, width: 1.0),
                        ),
                      )
                      .onHovered(BoxStyler().color(paletteBlueDark))
                      .onPressed(BoxStyler().color(paletteBlueDark)),
                  child: StyledText(
                    'Download Now',
                    style: TextStyler()
                        .color(textPrimary)
                        .fontSize(13)
                        .fontWeight(FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
