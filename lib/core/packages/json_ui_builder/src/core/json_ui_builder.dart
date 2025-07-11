import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/widgets/button_widgets.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/widgets/layout_widgets.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../converters/json_to_widget_converter.dart';
import '../converters/widget_to_json_converter.dart';
import '../exceptions/json_ui_exceptions.dart';
import '../models/widget_config.dart';
import '../utils/widget_utils.dart';

// Import all widget builders to register them
import '../widgets/material_widgets.dart';

import 'widget_builder.dart' as widget_builder;

/// Main class for JSON UI Builder package.
/// Provides methods for converting between JSON and Flutter widgets.
class JsonUIBuilder {
  static final JsonUIBuilder _instance = JsonUIBuilder._internal();
  factory JsonUIBuilder() => _instance;
  JsonUIBuilder._internal() {
    _initialize();
  }

  late final JsonToWidgetConverter _jsonToWidgetConverter;
  late final WidgetToJsonConverter _widgetToJsonConverter;
  bool _initialized = false;

  /// Initializes the JSON UI Builder with default widget builders.
  void _initialize() {
    if (_initialized) return;

    _jsonToWidgetConverter = JsonToWidgetConverter();
    _widgetToJsonConverter = WidgetToJsonConverter();

    // Register all default widget builders
    MaterialWidgets.register();
    TextWidgets.register();
    ButtonWidgets.register();
    LayoutWidgets.register();

    _initialized = true;
  }

  /// Builds a Flutter widget from JSON configuration.
  ///
  // ignore: unintended_html_in_doc_comment
  /// [json] can be either a Map<String, dynamic> or a JSON string.
  /// Returns the built widget.
  Widget buildFromJson(dynamic json) {
    try {
      final config = _jsonToWidgetConverter.convert(json);
      return widget_builder.WidgetBuilder.build(config);
    } catch (e) {
      throw JsonParsingException('Failed to build widget from JSON: $e');
    }
  }

  /// Builds a Flutter widget from WidgetConfig.
  Widget buildFromConfig(WidgetConfig config) {
    return widget_builder.WidgetBuilder.build(config);
  }

  /// Converts a WidgetConfig to JSON.
  Map<String, dynamic> configToJson(WidgetConfig config) {
    return _widgetToJsonConverter.convert(config);
  }

  /// Converts JSON to WidgetConfig.
  WidgetConfig jsonToConfig(dynamic json) {
    return _jsonToWidgetConverter.convert(json);
  }

  /// Validates a JSON configuration.
  bool validateJson(dynamic json) {
    try {
      _jsonToWidgetConverter.convert(json);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Gets validation errors for a JSON configuration.
  List<String> getValidationErrors(dynamic json) {
    final errors = <String>[];
    try {
      _jsonToWidgetConverter.convert(json);
    } catch (e) {
      if (e is JsonUIException) {
        errors.add(e.message);
      } else {
        errors.add(e.toString());
      }
    }
    return errors;
  }

  /// Finds a widget by ID in the widget tree.
  WidgetConfig? findWidgetById(WidgetConfig root, String id) {
    return WidgetUtils.findWidgetById(root, id);
  }

  /// Updates a widget by ID in the widget tree.
  bool updateWidgetById(WidgetConfig root, String id, WidgetConfig newConfig) {
    return WidgetUtils.updateWidgetById(root, id, newConfig);
  }

  /// Removes a widget by ID from the widget tree.
  bool removeWidgetById(WidgetConfig root, String id) {
    return WidgetUtils.removeWidgetById(root, id);
  }

  /// Gets all widget IDs from a widget tree.
  Set<String> getAllWidgetIds(WidgetConfig root) {
    return WidgetUtils.extractAllIds(root);
  }

  /// Gets all supported widget types.
  List<String> getSupportedWidgetTypes() {
    return widget_builder.WidgetBuilder.registry.getSupportedTypes();
  }

  /// Gets supported properties for a widget type.
  List<String> getSupportedProperties(String widgetType) {
    return widget_builder.WidgetBuilder.registry.getSupportedProperties(
      widgetType,
    );
  }

  /// Checks if a widget type is supported.
  bool isWidgetTypeSupported(String type) {
    return widget_builder.WidgetBuilder.registry.isSupported(type);
  }
}
