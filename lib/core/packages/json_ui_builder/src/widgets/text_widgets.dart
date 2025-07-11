import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/parsers/property_parser.dart';
import 'package:flutter/material.dart';
import '../core/widget_registry.dart';
import '../models/widget_config.dart';

/// Text widgets implementation for JSON UI Builder.
class TextWidgets {
  /// Registers all text widgets with the widget registry.
  static void register() {
    final registry = WidgetRegistry();

    registry.registerWidget('Text', _buildText, ['data']);
  }

  static Widget _buildText(WidgetConfig config) {
    final data = PropertyParser.parseRequiredString(config, 'data');

    return Text(data);
  }
}
