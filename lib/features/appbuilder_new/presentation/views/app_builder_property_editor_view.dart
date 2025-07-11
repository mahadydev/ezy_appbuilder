import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/core/json_ui_builder.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/models/widget_config.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_canvas_provider.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Property editor view that shows editable properties for the selected widget.
/// Displays widget-specific properties based on the widget type and allows
/// real-time editing with immediate reflection on the canvas.
class AppBuilderPropertyEditorView extends ConsumerWidget {
  const AppBuilderPropertyEditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(appBuilderCanvasNotifierProvider);
    final selectedWidget = _getSelectedWidget(
      ref,
      canvasState.selectedWidgetId,
    );

    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: 'Property Editor',
            icon: Icons.tune,
            subtitle: selectedWidget != null
                ? 'Configure properties of ${selectedWidget.type}'
                : 'Select a widget to edit properties',
          ),
          const SizedBox(height: AppConstants.spacingM),
          Expanded(
            child: selectedWidget != null
                ? _buildPropertyEditor(context, ref, selectedWidget)
                : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  /// Gets the currently selected widget configuration
  WidgetConfig? _getSelectedWidget(WidgetRef ref, String? selectedWidgetId) {
    if (selectedWidgetId == null) return null;

    final canvasState = ref.read(appBuilderCanvasNotifierProvider);
    if (canvasState.theJson.isEmpty) return null;

    final builder = JsonUIBuilder();
    final rootConfig = builder.jsonToConfig(canvasState.theJson);
    return builder.findWidgetById(rootConfig, selectedWidgetId);
  }

  /// Builds the property editor interface for the selected widget
  Widget _buildPropertyEditor(
    BuildContext context,
    WidgetRef ref,
    WidgetConfig widget,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget info section
          _buildWidgetInfoSection(widget),
          const SizedBox(height: AppConstants.spacingL),

          // Widget properties section
          _buildWidgetPropertiesSection(context, ref, widget),

          // Widget actions section
          const SizedBox(height: AppConstants.spacingL),
          _buildWidgetActionsSection(ref, widget),
        ],
      ),
    );
  }

  /// Builds the widget information section
  Widget _buildWidgetInfoSection(WidgetConfig widget) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.widgets, color: Colors.blue[600]),
                const SizedBox(width: AppConstants.spacingS),
                Text(
                  'Widget Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingM),
            _buildInfoRow('Type', widget.type),
            _buildInfoRow('ID', widget.id),
            _buildInfoRow('Children Count', '${widget.childCount}'),
            if (widget.canAcceptChildren)
              _buildInfoRow(
                'Can Accept Children',
                widget.childAcceptanceDescription,
              ),
          ],
        ),
      ),
    );
  }

  /// Builds an info row for the widget information section
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingXS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the widget properties section with editable fields
  Widget _buildWidgetPropertiesSection(
    BuildContext context,
    WidgetRef ref,
    WidgetConfig widget,
  ) {
    final supportedProperties = _getSupportedProperties(widget.type);

    if (supportedProperties.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          child: Column(
            children: [
              Icon(Icons.info_outline, size: 48, color: Colors.grey[400]),
              const SizedBox(height: AppConstants.spacingM),
              Text(
                'No editable properties available for ${widget.type}',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.edit, color: Colors.green[600]),
                const SizedBox(width: AppConstants.spacingS),
                Text(
                  'Properties',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingM),
            ...supportedProperties.map(
              (property) => _buildPropertyField(context, ref, widget, property),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an individual property editor based on property type
  Widget _buildPropertyField(
    BuildContext context,
    WidgetRef ref,
    WidgetConfig widget,
    String propertyName,
  ) {
    return _createPropertyEditor(
      propertyName: propertyName,
      widgetType: widget.type,
      currentValue: widget.getProperty(propertyName),
      onChanged: (value) {
        ref
            .read(appBuilderCanvasNotifierProvider.notifier)
            .updateWidgetProperty(widget.id, propertyName, value);
      },
    );
  }

  /// Creates a property editor widget based on the property type and widget type
  Widget _createPropertyEditor({
    required String propertyName,
    required String widgetType,
    required dynamic currentValue,
    required Function(dynamic) onChanged,
  }) {
    // Determine the property type and create appropriate editor
    switch (propertyName) {
      case 'data':
      case 'text':
        return _buildTextFieldEditor(
          propertyName,
          currentValue?.toString() ?? '',
          onChanged,
        );

      case 'width':
      case 'height':
      case 'elevation':
      case 'padding':
      case 'margin':
        return _buildNumberFieldEditor(
          propertyName,
          currentValue?.toDouble() ?? 0.0,
          onChanged,
        );

      case 'mainAxisAlignment':
        return _buildDropdownEditor(
          propertyName,
          currentValue?.toString() ?? 'start',
          [
            'start',
            'center',
            'end',
            'spaceBetween',
            'spaceAround',
            'spaceEvenly',
          ],
          onChanged,
        );

      case 'crossAxisAlignment':
        return _buildDropdownEditor(
          propertyName,
          currentValue?.toString() ?? 'center',
          ['start', 'center', 'end', 'stretch', 'baseline'],
          onChanged,
        );

      case 'textAlign':
        return _buildDropdownEditor(
          propertyName,
          currentValue?.toString() ?? 'left',
          ['left', 'right', 'center', 'justify', 'start', 'end'],
          onChanged,
        );

      case 'alignment':
        return _buildDropdownEditor(
          propertyName,
          currentValue?.toString() ?? 'center',
          [
            'topLeft',
            'topCenter',
            'topRight',
            'centerLeft',
            'center',
            'centerRight',
            'bottomLeft',
            'bottomCenter',
            'bottomRight',
          ],
          onChanged,
        );

      default:
        return _buildTextFieldEditor(
          propertyName,
          currentValue?.toString() ?? '',
          onChanged,
        );
    }
  }

  /// Builds a text field editor for string properties
  Widget _buildTextFieldEditor(
    String propertyName,
    String currentValue,
    Function(dynamic) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatPropertyName(propertyName),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppConstants.spacingXS),
          TextFormField(
            initialValue: currentValue,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter ${propertyName.toLowerCase()}',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingS,
                vertical: AppConstants.spacingS,
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  /// Builds a number field editor for numeric properties
  Widget _buildNumberFieldEditor(
    String propertyName,
    double currentValue,
    Function(dynamic) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatPropertyName(propertyName),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppConstants.spacingXS),
          TextFormField(
            initialValue: currentValue.toString(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter ${propertyName.toLowerCase()}',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingS,
                vertical: AppConstants.spacingS,
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final numValue = double.tryParse(value);
              if (numValue != null) {
                onChanged(numValue);
              }
            },
          ),
        ],
      ),
    );
  }

  /// Builds a dropdown editor for enum-like properties
  Widget _buildDropdownEditor(
    String propertyName,
    String currentValue,
    List<String> options,
    Function(dynamic) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatPropertyName(propertyName),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppConstants.spacingXS),
          DropdownButtonFormField<String>(
            value: options.contains(currentValue)
                ? currentValue
                : options.first,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppConstants.spacingS,
                vertical: AppConstants.spacingS,
              ),
            ),
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(_formatPropertyName(option)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }

  /// Formats property names for display (camelCase to Title Case)
  String _formatPropertyName(String propertyName) {
    if (propertyName.isEmpty) return propertyName;

    // Convert camelCase to Title Case
    final result = propertyName.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );

    return result[0].toUpperCase() + result.substring(1);
  }

  /// Builds the widget actions section
  Widget _buildWidgetActionsSection(WidgetRef ref, WidgetConfig widget) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.build, color: Colors.orange[600]),
                const SizedBox(width: AppConstants.spacingS),
                Text(
                  'Actions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingM),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(appBuilderCanvasNotifierProvider.notifier)
                          .deleteWidget(widget.id);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Widget'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      foregroundColor: Colors.red[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the empty state when no widget is selected
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.touch_app, size: 64, color: Colors.grey),
          SizedBox(height: AppConstants.spacingM),
          Text(
            'Select a widget on the canvas\nto edit its properties',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// Gets the supported editable properties for a widget type
  List<String> _getSupportedProperties(String widgetType) {
    // This would ideally come from the JSON UI Builder package
    // For now, we'll define common properties for each widget type
    switch (widgetType) {
      case 'Text':
        return ['data', 'style', 'textAlign', 'maxLines', 'overflow'];
      case 'Container':
        return [
          'width',
          'height',
          'decoration',
          'padding',
          'margin',
          'alignment',
        ];
      case 'Column':
        return ['mainAxisAlignment', 'crossAxisAlignment', 'mainAxisSize'];
      case 'Row':
        return ['mainAxisAlignment', 'crossAxisAlignment', 'mainAxisSize'];
      case 'Padding':
        return ['padding'];
      case 'SizedBox':
        return ['width', 'height'];
      case 'ElevatedButton':
        return ['style', 'onPressed'];
      case 'Card':
        return ['elevation', 'margin', 'shape'];
      case 'Center':
        return ['widthFactor', 'heightFactor'];
      case 'Align':
        return ['alignment', 'widthFactor', 'heightFactor'];
      default:
        return [];
    }
  }
}
