import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../services/custom_list_service.dart';
import '../../theme/theme.dart';

/// Selector component for managing and assigning media entries to custom lists.
class CustomListSelector extends StatefulWidget {
  /// The media type ('ANIME' or 'MANGA').
  final String mediaType;

  /// Custom lists currently selected for this entry.
  final List<String> selectedCustomLists;

  /// Callback when the selected custom lists change.
  final ValueChanged<List<String>> onCustomListsChanged;

  /// Creates a custom list selector widget.
  const CustomListSelector({
    super.key,
    required this.mediaType,
    required this.selectedCustomLists,
    required this.onCustomListsChanged,
  });

  @override
  State<CustomListSelector> createState() => _CustomListSelectorState();
}

class _CustomListSelectorState extends State<CustomListSelector> {
  bool _isAdding = false;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorMessage;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startAdding() {
    setState(() {
      _isAdding = true;
      _errorMessage = null;
      _textController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  void _cancelAdding() {
    setState(() {
      _isAdding = false;
      _errorMessage = null;
      _textController.clear();
    });
  }

  Future<void> _submitAdd() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      setState(() => _errorMessage = 'Name cannot be empty');
      return;
    }

    final success = await CustomListService.instance.addCustomList(
      widget.mediaType,
      text,
    );

    if (!mounted) return;

    if (!success) {
      setState(() => _errorMessage = 'List already exists');
      return;
    }

    final updated = List<String>.from(widget.selectedCustomLists);
    if (!updated.contains(text)) {
      updated.add(text);
      widget.onCustomListsChanged(updated);
    }

    setState(() {
      _isAdding = false;
      _errorMessage = null;
      _textController.clear();
    });
  }

  void _toggleList(String listName, bool select) {
    final updated = List<String>.from(widget.selectedCustomLists);
    if (select) {
      if (!updated.contains(listName)) updated.add(listName);
    } else {
      updated.remove(listName);
    }
    widget.onCustomListsChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CustomListService.instance,
      builder: (context, _) {
        final lists = CustomListService.instance.getCustomLists(
          widget.mediaType,
        );

        final Widget content = lists.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        LucideIcons.folder,
                        size: 28,
                        color: textMuted,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'No custom lists yet',
                        style: TextStyle(fontSize: 12, color: textMuted),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: _startAdding,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                LucideIcons.plus,
                                size: 14,
                                color: borderColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Create a custom list',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: borderColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int index = 0; index < lists.length; index++) ...[
                    if (index > 0)
                      const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: cardBorderColor,
                      ),
                    _buildRow(lists[index]),
                  ],
                ],
              );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cardBorderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.folderCog,
                        size: 16,
                        color: borderColor,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Custom Lists',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _isAdding ? _cancelAdding : _startAdding,
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            _isAdding ? LucideIcons.x : LucideIcons.plus,
                            size: 16,
                            color: textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, thickness: 1, color: cardBorderColor),
                if (_isAdding) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 36,
                                child: TextField(
                                  controller: _textController,
                                  focusNode: _focusNode,
                                  style: const TextStyle(
                                    color: textPrimary,
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'New list name...',
                                    hintStyle: const TextStyle(
                                      color: textMuted,
                                      fontSize: 12,
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    filled: true,
                                    fillColor: hoverBgColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: cardBorderColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: borderColor,
                                      ),
                                    ),
                                  ),
                                  onSubmitted: (_) => _submitAdd(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: _submitAdd,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  LucideIcons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: cardBorderColor,
                  ),
                ],
                content,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(String listName) {
    final isSelected = widget.selectedCustomLists.contains(listName);

    return InkWell(
      onTap: () => _toggleList(listName, !isSelected),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Row(
          children: [
            const Icon(LucideIcons.list, size: 16, color: textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                listName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Switch(
              value: isSelected,
              onChanged: (val) => _toggleList(listName, val),
              activeTrackColor: borderColor,
              activeThumbColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.08),
              inactiveThumbColor: textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
