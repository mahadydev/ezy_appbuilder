import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/parsers/widget_parser.dart';
import 'package:flutter/material.dart';
import '../core/widget_registry.dart';
import '../models/widget_config.dart';

/// Material Design widgets implementation for JSON UI Builder.
class MaterialWidgets {
  /// Registers all material widgets with the widget registry.
  static void register() {
    final registry = WidgetRegistry();

    registry.registerWidget('Scaffold', _buildScaffold, [
      'appBar',
      'drawer',
      'body',
    ]);
    registry.registerWidget('AppBar', _buildAppBar, ['title']);
    registry.registerWidget('Drawer', _buildDrawer, []);
  }

  static Widget _buildScaffold(WidgetConfig config) {
    final appBar = _parseAppBar(config.getProperty('appBar'));
    final drawer = _parseDrawer(config.getProperty('drawer'));
    final body = WidgetParser.parseChild(config);

    return Scaffold(appBar: appBar, drawer: drawer, body: body);
  }

  static AppBar _buildAppBar(WidgetConfig config) {
    final title = config.getProperty('title') ?? 'AppBar';
    return AppBar(title: Text(title));
  }

  static Drawer _buildDrawer(WidgetConfig config) {
    return const Drawer();
  }

  /// Helper methods for parsing complex widgets
  static AppBar? _parseAppBar(dynamic value) {
    if (value == null) return null;

    if (value is Map<String, dynamic>) {
      final config = WidgetConfig.fromJson({...value, 'type': 'AppBar'});
      return _buildAppBar(config);
    }

    return null;
  }

  static Drawer? _parseDrawer(dynamic value) {
    if (value == null) return null;

    if (value is Map<String, dynamic>) {
      final config = WidgetConfig.fromJson({...value, 'type': 'Drawer'});
      return _buildDrawer(config);
    }

    return null;
  }
}
