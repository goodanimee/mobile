import 'package:flutter/material.dart';
import '../widgets/ranking_pill.dart';

class AnimeRankingsTab extends StatefulWidget {
  final Map<String, dynamic> media;
  final bool isNested;

  const AnimeRankingsTab({
    super.key,
    required this.media,
    this.isNested = false,
  });

  @override
  State<AnimeRankingsTab> createState() => _AnimeRankingsTabState();
}

class _AnimeRankingsTabState extends State<AnimeRankingsTab> {
  @override
  Widget build(BuildContext context) {
    final rankings = widget.media['rankings'] as List? ?? [];

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
        return RankingPill(ranking: ranking);
      }).toList(),
    );

    if (widget.isNested) {
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
}
