import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:flutter/material.dart';
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
}
