import 'dart:convert';

import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanvasToolbar extends ConsumerWidget {
  const CanvasToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(appBuilderStateNotifierProvider.notifier);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(
          bottom: BorderSide(color: AppTheme.dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Undo/Redo buttons
          IconButton(
            onPressed: notifier.canUndo() ? () => notifier.undo() : null,
            icon: const Icon(Icons.undo),
            tooltip: 'Undo (Ctrl+Z)',
          ),
          IconButton(
            onPressed: notifier.canRedo() ? () => notifier.redo() : null,
            icon: const Icon(Icons.redo),
            tooltip: 'Redo (Ctrl+Y)',
          ),

          const SizedBox(width: AppConstants.spacingM),
          Container(width: 1, height: 30, color: AppTheme.dividerColor),
          const SizedBox(width: AppConstants.spacingM),

          // Reset canvas button
          IconButton(
            onPressed: () => notifier.resetJson(),
            icon: const Icon(Icons.clear_all),
            tooltip: 'Reset Canvas (Ctrl+R)',
          ),

          const SizedBox(width: AppConstants.spacingM),

          // Export JSON button
          IconButton(
            onPressed: () => _showExportDialog(context, ref),
            icon: const Icon(Icons.code),
            tooltip: 'Export JSON',
          ),

          const Spacer(),

          // Canvas info
          Consumer(
            builder: (context, ref, _) {
              final json = ref.watch(appBuilderStateNotifierProvider).theJson;
              final widgetCount = _countWidgets(json);

              return Text(
                'Widgets: $widgetCount',
                style: TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              );
            },
          ),

          const SizedBox(width: AppConstants.spacingM),
        ],
      ),
    );
  }

  int _countWidgets(Map<String, dynamic> json) {
    if (json.isEmpty) return 0;

    int count = 1; // Count the root widget

    // Count child
    if (json['child'] != null) {
      count += _countWidgets(json['child'] as Map<String, dynamic>);
    }

    // Count children
    if (json['children'] != null) {
      final children = json['children'] as List;
      for (final child in children) {
        count += _countWidgets(child as Map<String, dynamic>);
      }
    }

    return count;
  }

  void _showExportDialog(BuildContext context, WidgetRef ref) {
    final json = ref.read(appBuilderStateNotifierProvider).theJson;
    final prettyJson = const JsonEncoder.withIndent('  ').convert(json);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export JSON'),
        content: SizedBox(
          width: 360,
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Copy the JSON below to use in your application:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: AppConstants.spacingS),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      prettyJson,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: prettyJson));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('JSON copied to clipboard!')),
              );
            },
            child: const Text('Copy to Clipboard'),
          ),
        ],
      ),
    );
  }
}
