import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class RankingPill extends StatelessWidget {
  final Map<String, dynamic> ranking;

  const RankingPill({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    final type = ranking['type']?.toString().toUpperCase() ?? '';
    final isRated = type == 'RATED';
    final isPopular = type == 'POPULAR';

    final allTime = ranking['allTime'] == true;
    final season = ranking['season']?.toString();
    final year = ranking['year'];
    final rank = ranking['rank'];

    String titleText = isRated
        ? 'Highest Rated'
        : (isPopular ? 'Most Popular' : 'Ranked');

    String suffix = '';
    if (allTime) {
      suffix = 'of All Time';
    } else if (season != null || year != null) {
      final parts = ['of'];
      if (season != null) parts.add(_capitalize(season));
      if (year != null) parts.add(year.toString());
      suffix = parts.join(' ');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: cardBorderColor, width: 1.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildPremiumIcon(isRated, isPopular),
            ),
          ),
          Expanded(
            child: Text(
              '$titleText $suffix'.trim(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '#$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumIcon(bool isRated, bool isPopular) {
    final IconData iconData = isRated
        ? Icons.star_outline_rounded
        : (isPopular ? Icons.favorite_border_rounded : Icons.info_outline);

    final List<Color> colors = isRated
        ? goldGradient
        : (isPopular ? loveGradient : [paletteGray, paletteGrayDark]);

    return SizedBox(
      width: 32,
      height: 32,
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Icon(iconData, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
