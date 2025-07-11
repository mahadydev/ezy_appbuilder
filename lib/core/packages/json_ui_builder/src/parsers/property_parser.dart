import 'dart:ui';

import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/exceptions/json_ui_exceptions.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/models/widget_config.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/utils/widget_utils.dart';

/// Utility class for parsing widget properties from WidgetConfig.
class PropertyParser {
  /// Parses a string property.
  static String? parseString(
    WidgetConfig config,
    String propertyName, [
    String? defaultValue,
  ]) {
    final value = config.getProperty(propertyName);
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// Parses a required string property.
  static String parseRequiredString(WidgetConfig config, String propertyName) {
    final value = parseString(config, propertyName);
    if (value == null || value.isEmpty) {
      throw MissingPropertyException(propertyName, config.type);
    }
    return value;
  }

  /// Parses a color property.
  static Color? parseColor(
    WidgetConfig config,
    String propertyName, [
    Color? defaultValue,
  ]) {
    final value = config.getProperty(propertyName);
    return WidgetUtils.parseColor(value) ?? defaultValue;
  }
}
