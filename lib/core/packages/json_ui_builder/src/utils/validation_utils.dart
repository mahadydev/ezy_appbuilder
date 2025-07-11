import '../exceptions/json_ui_exceptions.dart';

/// Validation utilities for JSON UI Builder.
class ValidationUtils {
  /// Validates if a JSON map has the required 'type' property.
  static void validateWidgetType(Map<String, dynamic> json) {
    if (!json.containsKey('type') || json['type'] == null) {
      throw const JsonParsingException(
        'Widget configuration must have a "type" property',
      );
    }

    if (json['type'] is! String || (json['type'] as String).isEmpty) {
      throw const JsonParsingException(
        'Widget "type" must be a non-empty string',
      );
    }
  }

  /// Validates if a widget ID is unique within the widget tree.
  static void validateUniqueId(String id, Set<String> existingIds) {
    if (existingIds.contains(id)) {
      throw WidgetIdException('Widget ID "$id" is not unique');
    }
  }

  /// Validates color string format (hex colors).
  static bool isValidColor(String color) {
    if (color.isEmpty) return false;

    // Support hex colors with or without #
    final hexPattern = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
    return hexPattern.hasMatch(color);
  }

  /// Validates numeric values.
  static bool isValidNumber(dynamic value) {
    if (value == null) return false;
    if (value is num) return true;
    if (value is String) {
      return double.tryParse(value) != null;
    }
    return false;
  }

  /// Validates boolean values.
  static bool isValidBoolean(dynamic value) {
    return value is bool || value == 'true' || value == 'false';
  }
}
