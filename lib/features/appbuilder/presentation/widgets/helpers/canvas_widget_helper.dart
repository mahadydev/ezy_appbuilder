import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/helpers/widget_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget_type.dart';

/// Helper for drag-and-drop logic and widget wrapping in CanvasViewport
class CanvasWidgetHelper {
  static const multiChildTypes = [
    WidgetType.column,
    WidgetType.row,
    WidgetType.wrap,
    WidgetType.listView,
    WidgetType.gridView,
    WidgetType.stack,
  ];
  static const singleChildTypes = [
    WidgetType.container,
    WidgetType.center,
    WidgetType.align,
    WidgetType.card,
    WidgetType.padding,
    WidgetType.sizedBox,
    WidgetType.expanded,
    WidgetType.flexible,
    WidgetType.singleChildScrollView,
    WidgetType.pageView,
    WidgetType.positioned,
    WidgetType.scaffold,
  ];
  static const leafTypes = [
    WidgetType.text,
    WidgetType.icon,
    WidgetType.checkbox,
    WidgetType.switchWidget,
    WidgetType.radio,
    WidgetType.slider,
    WidgetType.image,
    WidgetType.listTile,
    WidgetType.elevatedButton,
    WidgetType.textButton,
    WidgetType.outlinedButton,
    WidgetType.textField,
    WidgetType.textFormField,
  ];

  static bool canAcceptDrop(Map<String, dynamic> config) {
    final type = widgetTypeFromString(config['type']);
    if (type == null) return false;
    if (multiChildTypes.contains(type)) {
      if (leafTypes.contains(type)) return false;
      return true;
    } else if (singleChildTypes.contains(type)) {
      if (leafTypes.contains(type)) return false;
      return config['child'] == null;
    }
    return false;
  }

  /// Wraps a widget with DragTarget and GestureDetector for drop/select logic
  static Widget wrapWithDropTarget({
    required Widget widget,
    required Map<String, dynamic> config,
    required WidgetRef ref,
    required void Function(String widgetId, Map<String, dynamic> properties)?
    onWidgetSelected,
    required List<Widget> children,
  }) {
    return DragTarget<WidgetInfo>(
      onAcceptWithDetails: (details) {
        ref
            .read(appBuilderStateNotifierProvider.notifier)
            .addWidgetToParent(config['id'], details.data.name);
      },
      builder: (context, candidateData, rejectedData) {
        final isDraggedOver = candidateData.isNotEmpty;
        return Container(
          decoration: BoxDecoration(
            border: isDraggedOver
                ? Border.all(
                    color: Colors.red.withValues(alpha: 0.5),
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignInside,
                  )
                : null,
            color: isDraggedOver ? Colors.red.withValues(alpha: 0.05) : null,
          ),
          child: GestureDetector(
            onTap: () {
              final widgetId = config['id']?.toString() ?? '';
              onWidgetSelected?.call(widgetId, config);
            },
            child: widget,
          ),
        );
      },
    );
  }

  static Map<String, dynamic> wrapSelectedWidgetWithBorder(
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

      return node; // Always return node at the end
    }

    return traverse(json);
  }

  // This function is used to recursively wrap widgets with GestureDetector
  // to handle selection and drag-and-drop functionality.
  // It checks the widget type and wraps it accordingly.
  static Widget wrapWidgetsWithGesture(
    Widget widget,
    Map<String, dynamic> config,
    WidgetRef ref,
    final void Function(String widgetId, Map<String, dynamic> properties)?
    onWidgetSelected,
  ) {
    final type = widgetTypeFromString(config['type']);
    //This function calls itself to wrap child widgets.
    // So if a widget has children or nested child widgets (like Scaffold -> body -> Container -> child), it keeps calling itself on each child.
    if (type == WidgetType.scaffold) {
      if (config.containsKey('child') && widget is Scaffold) {
        final childConfig = config['child'] as Map<String, dynamic>?;
        if (childConfig != null && widget.body != null) {
          return Scaffold(
            key: widget.key,
            appBar: widget.appBar,
            body: wrapWidgetsWithGesture(
              widget.body!,
              childConfig,
              ref,
              onWidgetSelected,
            ),
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
    // Handle multi-child widgets like Column, Row, etc.
    if (config.containsKey('children') &&
        widget is MultiChildRenderObjectWidget) {
      final childrenConfigs = config['children'] as List?;
      final children = (widget.children as List<Widget>?) ?? [];
      final wrappedChildren =
          childrenConfigs != null && childrenConfigs.isNotEmpty
          ? List<Widget>.generate(
              childrenConfigs.length,
              (i) => wrapWidgetsWithGesture(
                i < children.length ? children[i] : const SizedBox.shrink(),
                childrenConfigs[i],
                ref,
                onWidgetSelected,
              ),
            ).cast<Widget>()
          : <Widget>[];
      if (CanvasWidgetHelper.canAcceptDrop(config)) {
        final rebuilt = WidgetFactory.buildMultiChildWidget(
          type: type!,
          children: wrappedChildren,
          config: config,
          widget: widget,
        );
        return CanvasWidgetHelper.wrapWithDropTarget(
          widget: rebuilt,
          config: config,
          ref: ref,
          onWidgetSelected: onWidgetSelected,
          children: wrappedChildren,
        );
      } else {
        return WidgetFactory.buildMultiChildWidget(
          type: type!,
          children: wrappedChildren,
          config: config,
          widget: widget,
        );
      }
    }
    // Handle single child widgets like Container and recursively wrap the child
    if (widget is Container) {
      final childConfig = config['child'] as Map<String, dynamic>?;
      Widget wrappedChild = widget.child ?? const SizedBox.shrink();
      if (childConfig != null && widget.child != null) {
        wrappedChild = wrapWidgetsWithGesture(
          widget.child!,
          childConfig,
          ref,
          onWidgetSelected,
        );
      }
      final containerWidget = Container(
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
      if (CanvasWidgetHelper.canAcceptDrop(config)) {
        return CanvasWidgetHelper.wrapWithDropTarget(
          widget: containerWidget,
          config: config,
          ref: ref,
          onWidgetSelected: onWidgetSelected,
          children: [wrappedChild],
        );
      } else {
        return GestureDetector(
          onTap: () {
            final widgetId = config['id']?.toString() ?? '';
            onWidgetSelected?.call(widgetId, config);
          },
          child: containerWidget,
        );
      }
    }
    // Handle other single child widgets like Text, Icon, etc.
    if (CanvasWidgetHelper.canAcceptDrop(config)) {
      return CanvasWidgetHelper.wrapWithDropTarget(
        widget: widget,
        config: config,
        ref: ref,
        onWidgetSelected: onWidgetSelected,
        children: const [],
      );
    } else {
      return GestureDetector(
        onTap: () {
          final widgetId = config['id']?.toString() ?? '';
          onWidgetSelected?.call(widgetId, config);
        },
        child: widget,
      );
    }
  }

  //[IMPORTANT NOTE]
  //Recursion flow of _wrapWidgetsWithGesture
  //example json
  //
  //   {
  //   "type": "scaffold",
  //   "child": {
  //     "type": "container",
  //     "child": {
  //       "type": "text",
  //       "value": "Hello"
  //     }
  //   }
  // }
  //
  //   Here’s what happens:

  // _wrapWidgetsWithGesture(scaffold, config, ref)
  // → finds a child (container) → calls itself

  // _wrapWidgetsWithGesture(container, childConfig, ref)
  // → finds a child (text) → calls itself

  // _wrapWidgetsWithGesture(text, childConfig, ref)
  // → no children → base case → wraps text in GestureDetector and returns.

  // Moves back up to container → wraps container with gesture/drop logic and returns.

  // Moves back up to scaffold → wraps scaffold and returns.
}
