import 'package:device_frame/device_frame.dart';
import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/empty_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_ui_builder/json_ui_builder.dart';

class CanvasViewport extends ConsumerWidget {
  const CanvasViewport({
    super.key,
    required this.screenMap,
    required this.onDragAccept,
    this.onWidgetSelected,
  });

  final Map<String, dynamic> screenMap;
  final void Function(DragTargetDetails<WidgetInfo>) onDragAccept;
  final void Function(String widgetId, Map<String, dynamic> properties)?
  onWidgetSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appBuilderStateNotifierProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: DeviceFrame(
          device: Devices.ios.iPhone16ProMax,
          isFrameVisible: true,
          orientation: Orientation.portrait,
          screen: DragTarget<WidgetInfo>(
            onAcceptWithDetails: onDragAccept,
            onWillAcceptWithDetails: (details) => true,
            builder: (context, candidateData, rejectedData) {
              final isDraggedOver = candidateData.isNotEmpty;
              return Container(
                width: AppConstants.canvasWidth,
                height: AppConstants.canvasHeight,
                decoration: BoxDecoration(
                  border: isDraggedOver
                      ? Border.all(
                          color: Colors.blue.withValues(alpha: 0.5),
                          width: 3,
                          strokeAlign: BorderSide.strokeAlignInside,
                        )
                      : null,
                  color: isDraggedOver
                      ? Colors.blue.withValues(alpha: 0.05)
                      : null,
                ),
                child: _buildCanvasContent(appState),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCanvasContent(AppbuilderState appState) {
    if (screenMap.isEmpty) {
      return EmptyCanvas();
    } else {
      final builder = JsonUIBuilder();
      // Wrap the selected widget in the JSON tree
      final updatedJson = wrapSelectedWidgetWithBorder(
        screenMap,
        appState.selectedWidgetId,
      );
      final widget = builder.buildFromJson(updatedJson);

      // Wrap the root with selection gestures if needed
      if (onWidgetSelected != null) {
        return _wrapWithSelectionGestures(widget, updatedJson);
      }
      return widget;
    }
  }

  Widget _wrapWithSelectionGestures(
    Widget widget,
    Map<String, dynamic> config,
  ) {
    // This is a simplified version - in practice, you'd need to recursively
    // wrap each widget with GestureDetector to make them individually selectable
    return GestureDetector(
      onTap: () {
        // Generate widget ID similar to the hierarchy tree
        final widgetId = '${config['id']}';
        final properties = config['properties'] as Map<String, dynamic>? ?? {};
        onWidgetSelected?.call(widgetId, properties);
      },
      child: widget,
    );
  }

  Map<String, dynamic> wrapSelectedWidgetWithBorder(
    Map<String, dynamic> json,
    String? selectedId,
  ) {
    if (selectedId == null) return json;

    // Helper to wrap a widget config in a border container
    Map<String, dynamic> wrapWithBorder(Map<String, dynamic> child) {
      return {
        'type': 'Container',
        'id': "border_${child['id']}",
        'properties': {
          'decoration': {
            'type': 'BoxDecoration',
            'border': {'color': '0000ff', 'width': 3},
          },
        },
        'child': child,
      };
    }

    // Recursive function to traverse and wrap
    Map<String, dynamic> traverse(Map<String, dynamic> node) {
      if (node['id'] == selectedId) {
        return wrapWithBorder(node);
      }

      // Handle single child
      if (node.containsKey('child') && node['child'] is Map<String, dynamic>) {
        node = Map<String, dynamic>.from(
          node,
        ); // clone to avoid mutating original
        node['child'] = traverse(node['child']);
      }

      // Handle children list
      if (node.containsKey('children') && node['children'] is List) {
        node = Map<String, dynamic>.from(node);
        node['children'] = (node['children'] as List)
            .map(
              (child) =>
                  child is Map<String, dynamic> ? traverse(child) : child,
            )
            .toList();
      }

      return node;
    }

    return traverse(json);
  }
}
