import 'package:device_frame/device_frame.dart';
import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/empty_canvas.dart';
import 'package:flutter/material.dart';
import 'package:json_ui_builder/json_ui_builder.dart';

class CanvasViewport extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                child: _buildCanvasContent(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCanvasContent() {
    if (screenMap.isEmpty) {
      return EmptyCanvas();
    } else {
      final builder = JsonUIBuilder();
      final widget = builder.buildFromJson(screenMap);

      // Wrap the widget with gesture detection for selection
      if (onWidgetSelected != null) {
        return _wrapWithSelectionGestures(widget, screenMap);
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
}
