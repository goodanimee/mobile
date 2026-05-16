import 'package:flutter/material.dart';
import '../section_title.dart';

class ProgressEditor extends StatelessWidget {
  final int progress;
  final int? maximum;
  final ValueChanged<int> onProgressChanged;

  const ProgressEditor({
    super.key,
    required this.progress,
    this.maximum,
    required this.onProgressChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Progress', fontSize: 14, bottomPadding: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: progress > 0
                    ? () => onProgressChanged(progress - 1)
                    : null,
                icon: const Icon(Icons.remove_circle_outline_rounded),
                color: Colors.white70,
                iconSize: 32,
              ),
              const SizedBox(width: 24),
              Text(
                '$progress / ${maximum ?? '?'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 24),
              IconButton(
                onPressed: (maximum == null || progress < maximum!)
                    ? () => onProgressChanged(progress + 1)
                    : null,
                icon: const Icon(Icons.add_circle_outline_rounded),
                color: Colors.white70,
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
