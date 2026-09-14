import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/theme.dart';

/// Bottom sheet for selecting a voice actor language
class CharacterLanguageSheet extends StatelessWidget {
  /// Available languages to select from
  final List<String> languages;

  /// Currently selected language
  final String selectedLanguage;

  /// Callback when a language is selected
  final ValueChanged<String> onLanguageSelected;

  /// Creates a character language selection bottom sheet
  const CharacterLanguageSheet({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        border: Border.all(color: cardBorderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12.0),
          Container(
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVal),
            child: Row(
              children: [
                Text(
                  'Voice Acting Language',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: fontMedium(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: paddingVal,
                right: paddingVal,
                bottom: MediaQuery.of(context).padding.bottom + 16.0,
              ),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final lang = languages[index];
                final isSelected =
                    lang.toLowerCase() == selectedLanguage.toLowerCase();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Material(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        onLanguageSelected(lang);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                lang,
                                style: TextStyle(
                                  color: isSelected
                                      ? textPrimary
                                      : textSecondary,
                                  fontSize: fontMedium(context),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                LucideIcons.check,
                                color: textPrimary,
                                size: 18.0,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
