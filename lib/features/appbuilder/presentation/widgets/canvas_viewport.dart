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
          device: Devices.android.onePlus8Pro,
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
                          width: 20,
                          strokeAlign: BorderSide.strokeAlignInside,
                        )
                      : null,
                  color: isDraggedOver
                      ? Colors.blue.withValues(alpha: 0.05)
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
      final updatedJson = wrapSelectedWidgetWithBorder(
        screenMap,
        appState.selectedWidgetId,
      );
      final widget = builder.buildFromJson(updatedJson);
      // Recursively wrap all widgets with GestureDetector if selection is enabled
      if (onWidgetSelected != null) {
        return wrapWidgetsWithGesture(widget, updatedJson, ref);
      }
      return widget;
    }
  }

  /// Recursively wrap all widgets (except root Scaffold) with GestureDetector after building
  Widget wrapWidgetsWithGesture(
      Widget widget, Map<String, dynamic> config, WidgetRef ref) {
    // Don't wrap root Scaffold
    if (config['type'] == 'Scaffold') {
      // Handle child
      if (config.containsKey('child') && widget is Scaffold) {
        final childConfig = config['child'] as Map<String, dynamic>?;
        if (childConfig != null && widget.body != null) {
          return Scaffold(
            key: widget.key,
            appBar: widget.appBar,
            body: wrapWidgetsWithGesture(widget.body!, childConfig, ref),
            floatingActionButton: widget.floatingActionButton,
            drawer: widget.drawer,
            endDrawer: widget.endDrawer,
            bottomNavigationBar: widget.bottomNavigationBar,
            backgroundColor: widget.backgroundColor,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            primary: widget.primary,
            extendBody: widget.extendBody,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            drawerScrimColor: widget.drawerScrimColor,
            drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture:
                widget.endDrawerEnableOpenDragGesture,
          );
        }
      }
      return widget;
    }

    // Helper to determine if this widget can accept drops
    bool canAcceptDrop(Map<String, dynamic> config) {
      const multiChildTypes = [
        'Column',
        'Row',
        'Wrap',
        'ListView',
        'GridView',
        'Stack',
      ];
      const singleChildTypes = [
        'Container',
        'Center',
        'Align',
        'Card',
        'Padding',
        'SizedBox',
        'Expanded',
        'Flexible',
        'SingleChildScrollView',
        'PageView',
        'Positioned',
        'Scaffold',
      ];
      const leafTypes = [
        'Text',
        'Icon',
        'Checkbox',
        'Switch',
        'Radio',
        'Slider',
        'Image',
        'ListTile',
        'ElevatedButton',
        'TextButton',
        'OutlinedButton',
        'TextField',
        'TextFormField',
      ];
      final type = config['type'];
      if (multiChildTypes.contains(type)) {
        // Always allow drop for multi-child widgets (e.g., Column, Row, etc.)
        if (leafTypes.contains(type)) return false;
        return true;
      } else if (singleChildTypes.contains(type)) {
        // Only allow drop for single-child widgets if they don't have a child
        if (leafTypes.contains(type)) return false;
        return config['child'] == null;
      }
      return false;
    }

    // Handle children
    if (config.containsKey('children') &&
        widget is MultiChildRenderObjectWidget) {
      final childrenConfigs = config['children'] as List?;
      final children = (widget.children as List<Widget>?) ?? [];
      if (childrenConfigs != null &&
          children.length == childrenConfigs.length) {
        final wrappedChildren = List<Widget>.generate(
          children.length,
          (i) => wrapWidgetsWithGesture(children[i], childrenConfigs[i], ref),
        );
        if (widget is Column) {
          return Column(
            key: widget.key,
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            children: wrappedChildren,
          );
        } else if (widget is Row) {
          return Row(
            key: widget.key,
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            children: wrappedChildren,
          );
        } else if (widget is Stack) {
          return Stack(
            key: widget.key,
            alignment: widget.alignment,
            textDirection: widget.textDirection,
            fit: widget.fit,
            clipBehavior: widget.clipBehavior,
            children: wrappedChildren,
          );
        }
        // Add more widgets as needed
      }
    }

    // Handle single child for Container only
    if (config.containsKey('child') && widget is Container) {
      final childConfig = config['child'] as Map<String, dynamic>?;
      if (childConfig != null && widget.child != null) {
        final wrappedChild =
            wrapWidgetsWithGesture(widget.child!, childConfig, ref);
        return Container(
          key: widget.key,
          alignment: widget.alignment,
          padding: widget.padding,
          color: widget.color,
          decoration: widget.decoration,
          foregroundDecoration: widget.foregroundDecoration,
          constraints: widget.constraints,
          margin: widget.margin,
          transform: widget.transform,
          transformAlignment: widget.transformAlignment,
          clipBehavior: widget.clipBehavior,
          child: wrappedChild,
        );
      }
    }
    // Only wrap with DragTarget if can accept drop, else just GestureDetector
    if (canAcceptDrop(config)) {
      return DragTarget<WidgetInfo>(
        onAcceptWithDetails: (details) {
          ref.read(appBuilderStateNotifierProvider.notifier).addWidgetToParent(
                config['id'],
                details.data.name,
              );
        },
        builder: (context, candidateData, rejectedData) {
          final isDraggedOver = candidateData.isNotEmpty;
          return Container(
            decoration: BoxDecoration(
              border: isDraggedOver
                  ? Border.all(
                      color: Colors.red.withValues(alpha: 0.5),
                      width: 20,
                      strokeAlign: BorderSide.strokeAlignInside,
                    )
                  : null,
              color: isDraggedOver ? Colors.red.withValues(alpha: 0.05) : null,
            ),
            child: GestureDetector(
              onTap: () {
                final widgetId = config['id']?.toString() ?? '';
                final properties =
                    config['properties'] as Map<String, dynamic>? ?? {};
                onWidgetSelected?.call(widgetId, properties);
              },
              child: widget,
            ),
          );
        },
      );
    } else {
      // Just wrap with GestureDetector, no DragTarget or red border
      return GestureDetector(
        onTap: () {
          final widgetId = config['id']?.toString() ?? '';
          final properties =
              config['properties'] as Map<String, dynamic>? ?? {};
          onWidgetSelected?.call(widgetId, properties);
        },
        child: widget,
      );
    }
  }

  // Recursively wrap all widgets in the JSON tree with GestureDetector
  Map<String, dynamic> wrapAllWidgetsWithGesture(Map<String, dynamic> node) {
    // Don't wrap GestureDetector nodes again
    if (node['type'] == 'GestureDetector') return node;

    // Helper to wrap a node with GestureDetector
    Map<String, dynamic> wrap(Map<String, dynamic> child) {
      return {
        'type': 'GestureDetector',
        'id': 'gesture_${child['id']}',
        'properties': {
          'onTap':
              true, // This is a marker; actual callback is handled in builder
        },
        'child': child,
      };
    }

    Map<String, dynamic> newNode = Map<String, dynamic>.from(node);

    // Handle single child
    if (newNode.containsKey('child') &&
        newNode['child'] is Map<String, dynamic>) {
      newNode['child'] = wrapAllWidgetsWithGesture(newNode['child']);
    }

    // Handle children list
    if (newNode.containsKey('children') && newNode['children'] is List) {
      newNode['children'] = (newNode['children'] as List)
          .map((child) => child is Map<String, dynamic>
              ? wrapAllWidgetsWithGesture(child)
              : child)
          .toList();
    }

    // Only wrap if node is not root Scaffold (to avoid double wrapping root)
    if (newNode['type'] != 'Scaffold') {
      return wrap(newNode);
    }
    return newNode;
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
            'border': {'color': '#0000ff', 'width': 3},
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
