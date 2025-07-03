import 'package:device_frame/device_frame.dart';
import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/empty_canvas.dart';
import 'package:flutter/material.dart';
import 'package:json_ui_builder/json_ui_builder.dart';

class CanvasViewport extends StatelessWidget {
  const CanvasViewport({
    super.key,
    required this.screenMap,
    required this.onDragAccept,
  });

  final Map<String, dynamic> screenMap;
  final void Function(DragTargetDetails<String>) onDragAccept;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: DeviceFrame(
          device: Devices.ios.iPhone16ProMax,
          isFrameVisible: true,
          orientation: Orientation.portrait,
          screen: DragTarget(
            onAcceptWithDetails: onDragAccept,
            onWillAcceptWithDetails: (details) => true,
            builder: (context, candidateData, rejectedData) {
              return SizedBox(
                width: AppConstants.canvasWidth,
                height: AppConstants.canvasHeight,
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
      return JsonUIBuilder().buildFromJson(screenMap);
    }
  }
}
