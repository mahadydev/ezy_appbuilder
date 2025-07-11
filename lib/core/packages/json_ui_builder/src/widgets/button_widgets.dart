import 'package:flutter/material.dart';
import '../core/widget_registry.dart';
import '../models/widget_config.dart';

/// Text widgets implementation for JSON UI Builder.
class ButtonWidgets {
  /// Registers all text widgets with the widget registry.
  static void register() {
    final registry = WidgetRegistry();

    // Button widgets
    registry.registerWidget('ElevatedButton', _buildElevatedButton, []);
    registry.registerWidget('OutlinedButton', _buildOutlinedButton, []);
    registry.registerWidget('TextButton', _buildTextButton, []);
  }

  static Widget _buildElevatedButton(WidgetConfig config) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('This is an ElevatedButton'),
    );
  }

  static Widget _buildOutlinedButton(WidgetConfig config) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text('This is an OutlinedButton'),
    );
  }

  static Widget _buildTextButton(WidgetConfig config) {
    return TextButton(
      onPressed: () {},
      child: const Text('This is a TextButton'),
    );
  }
}
