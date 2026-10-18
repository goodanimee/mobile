import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../services/custom_list_service.dart';
import '../../services/media_list_controller.dart';
import '../../theme/theme.dart';

/// Expandable management panel for creating, viewing, and deleting custom lists
class CustomListPanel extends StatefulWidget {
  /// The media type ('ANIME' or 'MANGA')
  final String mediaType;

  /// Optional width to match the bottom navigation bar
  final double? width;

  /// Optional height to match the vertical quick navigation bar
  final double? height;

  /// Optional callback invoked when a custom list is selected
  final void Function(String name)? onSelectList;

  /// Creates a custom list management panel
  const CustomListPanel({
    super.key,
    required this.mediaType,
    this.width,
    this.height,
    this.onSelectList,
  });

  @override
  State<CustomListPanel> createState() => _CustomListPanelState();
}

class _CustomListPanelState extends State<CustomListPanel> {
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

    MediaListController.forType(widget.mediaType).addCustomList(text);

    setState(() {
      _isAdding = false;
      _errorMessage = null;
      _textController.clear();
    });
  }

  Future<void> _deleteList(String name) async {
    final success = await CustomListService.instance.deleteCustomList(
      widget.mediaType,
      name,
    );
    if (success) {
      MediaListController.forType(widget.mediaType).removeCustomList(name);
    }
  }

  double _resolveDefaultWidth() {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth < 486.0)
        ? (360.0 * (screenWidth / 486.0)).clamp(200.0, 360.0)
        : 360.0;
  }

  @override
  Widget build(BuildContext context) {
    final panelWidth = widget.width ?? _resolveDefaultWidth();
    final panelHeight = widget.height;

    final controller = MediaListController.forType(widget.mediaType);

    return ListenableBuilder(
      listenable: Listenable.merge([CustomListService.instance, controller]),
      builder: (context, _) {
        final lists = CustomListService.instance.getCustomLists(
          widget.mediaType,
        );
        final activeCustomList = controller.activeCustomList;

        Widget content = lists.isEmpty
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
            : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                itemCount: lists.length,
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final listName = lists[index];
                  final isSelected = activeCustomList == listName;
                  return Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? borderColor.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(
                              color: borderColor.withValues(alpha: 0.35),
                            )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () => widget.onSelectList?.call(listName),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.list,
                              size: 16,
                              color: isSelected ? borderColor : textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                listName,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected ? borderColor : textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _deleteList(listName),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  LucideIcons.trash2,
                                  size: 16,
                                  color: Colors.redAccent.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );

        if (panelHeight != null) {
          content = Expanded(child: content);
        } else {
          content = Flexible(child: content);
        }

        return Container(
          width: panelWidth,
          height: panelHeight,
          constraints: panelHeight == null
              ? BoxConstraints(maxHeight: getResponsiveSize(context, 320.0))
              : null,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardBorderColor),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: panelHeight != null
                ? MainAxisSize.max
                : MainAxisSize.min,
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
                const Divider(height: 1, thickness: 1, color: cardBorderColor),
              ],
              content,
            ],
          ),
        );
      },
    );
  }
}
