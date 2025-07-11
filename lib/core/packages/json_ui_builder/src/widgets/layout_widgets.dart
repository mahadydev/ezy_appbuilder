import 'package:ezy_appbuilder/core/packages/json_ui_builder/json_ui_builder.dart';
import 'package:flutter/material.dart';

/// Layout widgets implementation for JSON UI Builder.
class LayoutWidgets {
  /// Registers all layout widgets with the widget registry.
  static void register() {
    final registry = WidgetRegistry();

    registry.registerWidget('Column', _buildColumn, []);

    registry.registerWidget('Row', _buildRow, []);
  }

  static Widget _buildColumn(WidgetConfig config) {
    final children = WidgetParser.parseChildren(config);

    return Column(children: children);
  }

  static Widget _buildRow(WidgetConfig config) {
    final children = WidgetParser.parseChildren(config);

    return Row(children: children);
  }
}
