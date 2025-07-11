/// A powerful Flutter package for building dynamic UIs from JSON configurations.
///
/// This library provides comprehensive support for converting JSON configurations
/// into Flutter widgets with bi-directional conversion capabilities, widget
/// identification system, and extensive widget support.
library;

// Converters
export 'src/converters/json_to_widget_converter.dart';
export 'src/converters/widget_to_json_converter.dart';
// Core exports
export 'src/core/json_ui_builder.dart';
export 'src/core/widget_builder.dart';
export 'src/core/widget_registry.dart';
// Exceptions
export 'src/exceptions/json_ui_exceptions.dart';
// Models
export 'src/models/widget_config.dart';
export 'src/models/widget_property.dart';
export 'src/parsers/property_parser.dart';
// Parsers
export 'src/parsers/widget_parser.dart';
export 'src/utils/validation_utils.dart';
// Utils
export 'src/utils/widget_utils.dart';

// Widget builders
export 'src/widgets/material_widgets.dart';
