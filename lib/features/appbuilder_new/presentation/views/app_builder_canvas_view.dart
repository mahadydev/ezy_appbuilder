import 'dart:convert';

import 'package:device_frame/device_frame.dart';
import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/core/json_ui_builder.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_canvas_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/empty_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderCanvasView extends ConsumerWidget {
  const AppBuilderCanvasView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const _BuildCanvasToolbar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingXL),
            child: DeviceFrame(
              device: Devices.ios.iPhone15ProMax,
              isFrameVisible: true,
              orientation: Orientation.portrait,
              screen: DragTarget<String>(
                onAcceptWithDetails: (DragTargetDetails<String> details) {
                  ref
                      .read(appBuilderCanvasNotifierProvider.notifier)
                      .addWidgetToCanvas(details.data);
                },
                builder: (context, candidateData, rejectedData) {
                  return _buildCanvasContent(ref);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the content of the canvas based on the current state.
  Widget _buildCanvasContent(WidgetRef ref) {
    final canvasState = ref.watch(appBuilderCanvasNotifierProvider);

    if (canvasState.theJson.isEmpty) {
      return const EmptyCanvas();
    } else {
      final builder = JsonUIBuilder();

      final widget = builder.buildFromJson(canvasState.theJson);

      return widget;
    }
  }
}

/// Builds the toolbar for the canvas with undo, redo, reset, and export buttons.
class _BuildCanvasToolbar extends ConsumerWidget {
  const _BuildCanvasToolbar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(appBuilderCanvasNotifierProvider.notifier);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: notifier.undo,
            icon: const Icon(Icons.undo),
            tooltip: 'Undo',
          ),
          IconButton(
            onPressed: notifier.redo,
            icon: const Icon(Icons.redo),
            tooltip: 'Redo',
          ),

          const SizedBox(width: AppConstants.spacingM),
          Container(width: 1, height: 30, color: AppTheme.dividerColor),
          const SizedBox(width: AppConstants.spacingM),

          // Reset canvas button
          IconButton(
            onPressed: notifier.resetCanvas,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Reset Canvas',
          ),

          const SizedBox(width: AppConstants.spacingM),

          // Export JSON button
          IconButton(
            onPressed: () => _showJsonCodeDialog(
              context,
              ref.read(appBuilderCanvasNotifierProvider).theJson,
            ),
            icon: const Icon(Icons.code),
            tooltip: 'View JSON Code',
          ),

          const Spacer(),
        ],
      ),
    );
  }

  /// Show JSON code dialog
  void _showJsonCodeDialog(BuildContext context, Map<String, dynamic> json) {
    final prettyJson = const JsonEncoder.withIndent('  ').convert(json);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Code'),
          content: SingleChildScrollView(child: SelectableText(prettyJson)),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
