import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class AnimeRankingsTab extends StatelessWidget {
  final Map<String, dynamic> media;
  final bool isNested;

  const AnimeRankingsTab({
    super.key,
    required this.media,
    this.isNested = false,
  });

  @override
  Widget build(BuildContext context) {
    final rankings = media['rankings'] as List? ?? [];

    if (rankings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            'No rankings available',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ),
      );
    }

    final content = Column(
      children: rankings.map((ranking) {
        if (ranking is! Map<String, dynamic>) return const SizedBox.shrink();
        return _buildRankingBar(context, ranking);
      }).toList(),
    );

    if (isNested) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: content,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: content,
    );
  }

  Widget _buildRankingBar(BuildContext context, Map<String, dynamic> ranking) {
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
              child: Icon(
                isRated
                    ? Icons.star_rounded
                    : (isPopular ? Icons.favorite_rounded : Icons.info_outline),
                color: isRated
                    ? Colors.orangeAccent
                    : (isPopular ? Colors.pinkAccent : Colors.white70),
                size: 22,
              ),
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

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
