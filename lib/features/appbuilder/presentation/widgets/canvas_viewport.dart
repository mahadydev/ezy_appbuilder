import 'package:device_frame/device_frame.dart';
import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/empty_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_ui_builder/json_ui_builder.dart';

import 'helpers/canvas_widget_helper.dart';

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
          device: Devices.android.samsungGalaxyA50,
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
                          color: Colors.lightGreenAccent.withValues(alpha: 0.5),
                          width: 5,
                          strokeAlign: BorderSide.strokeAlignInside,
                        )
                      : null,
                  color: isDraggedOver
                      ? Colors.lightGreenAccent.withValues(alpha: 0.05)
                      : null,
                ),
                child: _buildCanvasContent(appState, ref),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCanvasContent(AppbuilderState appState, WidgetRef ref) {
    if (screenMap.isEmpty) {
      return EmptyCanvas();
    } else {
      final builder = JsonUIBuilder();
      // Wrap the selected widget in the JSON tree
      final updatedJson = CanvasWidgetHelper.wrapSelectedWidgetWithBorder(
        screenMap,
        appState.selectedWidgetId,
      );
      final widget = builder.buildFromJson(updatedJson);
      // Recursively wrap all widgets with GestureDetector if selection is enabled
      if (onWidgetSelected != null) {
        return CanvasWidgetHelper.wrapWidgetsWithGesture(
          widget,
          updatedJson,
          ref,
          onWidgetSelected,
        );
      }
      return widget;
    }
  }
}
