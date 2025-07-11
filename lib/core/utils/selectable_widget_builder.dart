import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../packages/json_ui_builder/src/core/json_ui_builder.dart';
import '../packages/json_ui_builder/src/models/widget_config.dart';
import '../../features/appbuilder_new/presentation/widgets/selectable_widget.dart';

/// A specialized widget builder that creates selectable widgets for the canvas.
/// This builder wraps widgets with selection capabilities and visual feedback.
class SelectableWidgetBuilder {
  static final SelectableWidgetBuilder _instance =
      SelectableWidgetBuilder._internal();
  factory SelectableWidgetBuilder() => _instance;
  SelectableWidgetBuilder._internal();

  /// Builds a widget from JSON configuration with selection capabilities.
  ///
  /// [json] - The JSON configuration for the widget
  /// [ref] - The widget ref for accessing providers
  /// [selectedWidgetId] - The currently selected widget ID
  Widget buildSelectableFromJson(
    dynamic json,
    WidgetRef ref,
    String? selectedWidgetId,
  ) {
    final builder = JsonUIBuilder();
    final config = builder.jsonToConfig(json);
    return _buildSelectableWidget(config, ref, selectedWidgetId);
  }

  /// Builds a selectable widget from a WidgetConfig.
  Widget buildSelectableFromConfig(
    WidgetConfig config,
    WidgetRef ref,
    String? selectedWidgetId,
  ) {
    return _buildSelectableWidget(config, ref, selectedWidgetId);
  }

  /// Internal method to build a selectable widget recursively.
  Widget _buildSelectableWidget(
    WidgetConfig config,
    WidgetRef ref,
    String? selectedWidgetId,
  ) {
    final builder = JsonUIBuilder();

    // Create a modified config for building the actual widget
    final modifiedConfig = _createModifiedConfig(config, ref, selectedWidgetId);

    // Build the actual widget
    final widget = builder.buildFromConfig(modifiedConfig);

    // Wrap with selection capability (except for root Scaffold to avoid interference)
    if (config.type == 'Scaffold') {
      return widget;
    }

    return SelectableWidget(
      widgetId: config.id,
      isSelected: selectedWidgetId == config.id,
      child: widget,
    );
  }

  /// Creates a modified config where child widgets are wrapped with selection capability.
  WidgetConfig _createModifiedConfig(
    WidgetConfig originalConfig,
    WidgetRef ref,
    String? selectedWidgetId,
  ) {
    final modifiedConfig = WidgetConfig(
      type: originalConfig.type,
      id: originalConfig.id,
      properties: Map<String, dynamic>.from(originalConfig.properties),
    );

    // Handle single child
    if (originalConfig.child != null) {
      modifiedConfig.child = originalConfig.child!.copyWith();

      // For certain widgets, we need to replace the child with a selectable version
      if (_shouldWrapChild(originalConfig.type)) {
        final selectableChild = _buildSelectableWidget(
          originalConfig.child!,
          ref,
          selectedWidgetId,
        );

        // Store the selectable widget in a way that can be used by the builder
        // This is a workaround since we can't directly pass widgets through WidgetConfig
        _registerSelectableWidget(originalConfig.child!.id, selectableChild);
      }
    }

    // Handle multiple children
    if (originalConfig.children != null) {
      modifiedConfig.children = [];
      for (final child in originalConfig.children!) {
        final childCopy = child.copyWith();
        modifiedConfig.children!.add(childCopy);

        if (_shouldWrapChild(originalConfig.type)) {
          final selectableChild = _buildSelectableWidget(
            child,
            ref,
            selectedWidgetId,
          );
          _registerSelectableWidget(child.id, selectableChild);
        }
      }
    }

    return modifiedConfig;
  }

  /// Determines if children of this widget type should be wrapped with selection capability.
  bool _shouldWrapChild(String parentType) {
    const wrapableParents = {
      'Column',
      'Row',
      'Stack',
      'Wrap',
      'ListView',
      'Container',
      'Padding',
      'Center',
      'Align',
      'Card',
      'Scaffold',
    };
    return wrapableParents.contains(parentType);
  }

  // Temporary storage for selectable widgets
  static final Map<String, Widget> _selectableWidgets = {};

  /// Registers a selectable widget for later retrieval.
  void _registerSelectableWidget(String id, Widget widget) {
    _selectableWidgets[id] = widget;
  }

  /// Gets a registered selectable widget.
  static Widget? getSelectableWidget(String id) {
    return _selectableWidgets[id];
  }

  /// Clears all registered selectable widgets.
  static void clearSelectableWidgets() {
    _selectableWidgets.clear();
  }
}
