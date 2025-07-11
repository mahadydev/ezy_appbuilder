/// Represents a widget property with type information and validation.
class WidgetProperty {
  const WidgetProperty({
    required this.name,
    required this.type,
    this.defaultValue,
    this.isRequired = false,
    this.description,
    this.validator,
  });

  /// The name of the property.
  final String name;

  /// The type of the property (e.g., 'String', 'double', 'Color', 'EdgeInsets').
  final String type;

  /// Default value for the property.
  final dynamic defaultValue;

  /// Whether this property is required.
  final bool isRequired;

  /// Description of what this property does.
  final String? description;

  /// Custom validator function for the property value.
  final bool Function(dynamic value)? validator;

  /// Validates if a value is valid for this property.
  bool isValid(dynamic value) {
    if (value == null) {
      return !isRequired;
    }

    // Use custom validator if provided
    if (validator != null) {
      return validator!(value);
    }

    // Default type validation
    return _validateByType(value);
  }

  bool _validateByType(dynamic value) {
    switch (type.toLowerCase()) {
      case 'string':
        return value is String;
      case 'int':
        return value is int || (value is String && int.tryParse(value) != null);
      case 'double':
        return value is num ||
            (value is String && double.tryParse(value) != null);
      case 'bool':
        return value is bool || value == 'true' || value == 'false';
      default:
        return false; // Unknown types are considered invalid
    }
  }

  @override
  String toString() {
    return 'WidgetProperty(name: $name, type: $type, required: $isRequired)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WidgetProperty &&
        other.name == name &&
        other.type == type &&
        other.defaultValue == defaultValue &&
        other.isRequired == isRequired &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        defaultValue.hashCode ^
        isRequired.hashCode ^
        description.hashCode;
  }
}
