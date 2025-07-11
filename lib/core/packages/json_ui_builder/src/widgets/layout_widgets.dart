import 'package:flutter/material.dart';
import '../core/widget_registry.dart';
import '../models/widget_config.dart';
import '../parsers/widget_parser.dart';

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
