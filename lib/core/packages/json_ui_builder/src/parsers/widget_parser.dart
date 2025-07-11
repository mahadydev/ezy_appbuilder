import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/models/widget_config.dart';
import 'package:flutter/material.dart';
import '../core/widget_builder.dart' as ui_builder;

/// Core widget parser that handles parsing of WidgetConfig into Flutter widgets.
class WidgetParser {
  /// Parses a child widget from WidgetConfig.
  static Widget? parseChild(WidgetConfig config) {
    if (config.child != null) {
      return ui_builder.WidgetBuilder.build(config.child!);
    }
    return null;
  }

  /// Parses multiple children widgets from WidgetConfig.
  static List<Widget> parseChildren(WidgetConfig config) {
    if (config.children == null || config.children!.isEmpty) {
      return <Widget>[];
    }

    return config.children!
        .map((childConfig) => ui_builder.WidgetBuilder.build(childConfig))
        .toList();
  }
}
