import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/notifiers/app_builder_canvas_provider.dart';

/// A wrapper widget that makes any child widget selectable on the canvas.
/// When clicked, it notifies the canvas provider about the selection.
/// Provides visual feedback when the widget is selected.
class SelectableWidget extends ConsumerWidget {
  /// Creates a selectable widget wrapper.
  ///
  /// [widgetId] - Unique identifier for the widget
  /// [child] - The actual widget to wrap
  /// [isSelected] - Whether this widget is currently selected
  const SelectableWidget({
    super.key,
    required this.widgetId,
    required this.child,
    required this.isSelected,
  });

  /// Unique identifier for the wrapped widget
  final String widgetId;

  /// The widget to make selectable
  final Widget child;

  /// Whether this widget is currently selected
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // Select this widget when tapped
        ref
            .read(appBuilderCanvasNotifierProvider.notifier)
            .selectWidget(widgetId);
      },
      child: DragTarget<String>(
        // Allow dropping widgets onto this widget if it can accept children
        onWillAcceptWithDetails: (details) {
          // This will be handled by the individual widget's acceptance logic
          return true;
        },
        onAcceptWithDetails: (details) {
          // Handle dropping a widget onto this widget
          ref
              .read(appBuilderCanvasNotifierProvider.notifier)
              .addWidgetToParent(details.data, widgetId);
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: _buildSelectionDecoration(context),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                child,
                if (isSelected) _buildSelectionIndicator(context),
                if (candidateData.isNotEmpty) _buildDropIndicator(context),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the decoration for selection highlighting
  BoxDecoration? _buildSelectionDecoration(BuildContext context) {
    if (!isSelected) return null;

    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  /// Builds the selection indicator (small handle in top-right corner)
  Widget _buildSelectionIndicator(BuildContext context) {
    return Positioned(
      top: -8,
      right: -8,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.check, size: 10, color: Colors.white),
      ),
    );
  }

  /// Builds the drop indicator when a widget is being dragged over
  Widget _buildDropIndicator(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
        ),
      ),
    );
  }
}
