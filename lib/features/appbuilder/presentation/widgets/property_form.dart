import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A dynamic property form widget that can generate forms for different widget properties
class PropertyForm extends StatefulWidget {
  final Map<String, dynamic> properties;
  final Function(Map<String, dynamic>) onPropertiesChanged;
  final String widgetType;

  const PropertyForm({
    super.key,
    required this.properties,
    required this.onPropertiesChanged,
    required this.widgetType,
  });

  @override
  State<PropertyForm> createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  late Map<String, dynamic> _currentProperties;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _currentProperties = Map.from(widget.properties);
    _initializeControllers();
  }

  @override
  void didUpdateWidget(PropertyForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.properties != widget.properties) {
      _currentProperties = Map.from(widget.properties);
      _updateControllers();
    }
  }

  void _initializeControllers() {
    _controllers.clear();
    for (final entry in _currentProperties.entries) {
      if (entry.value is String || entry.value is num) {
        _controllers[entry.key] = TextEditingController(
          text: entry.value.toString(),
        );
      }
    }
  }

  void _updateControllers() {
    for (final entry in _currentProperties.entries) {
      if (entry.value is String || entry.value is num) {
        if (_controllers[entry.key] != null) {
          _controllers[entry.key]!.text = entry.value.toString();
        } else {
          _controllers[entry.key] = TextEditingController(
            text: entry.value.toString(),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateProperty(String key, dynamic value) {
    setState(() {
      _currentProperties[key] = value;
    });
    widget.onPropertiesChanged(_currentProperties);
  }

  Widget _buildPropertyField(String key, dynamic value) {
    switch (key) {
      case 'data':
      case 'text':
      case 'title':
      case 'subtitle':
      case 'hintText':
      case 'labelText':
        return _buildStringField(key, value as String? ?? '');

      case 'width':
      case 'height':
      case 'padding':
      case 'margin':
      case 'fontSize':
      case 'borderRadius':
        return _buildNumberField(key, value as num? ?? 0);

      case 'color':
      case 'backgroundColor':
      case 'borderColor':
        return _buildColorField(key, value as String? ?? '');

      case 'visible':
      case 'enabled':
      case 'expanded':
        return _buildBooleanField(key, value as bool? ?? true);

      case 'alignment':
        return _buildAlignmentField(key, value as String? ?? 'center');

      case 'crossAxisAlignment':
        return _buildCrossAxisAlignmentField(key, value as String? ?? 'center');

      case 'mainAxisAlignment':
        return _buildMainAxisAlignmentField(key, value as String? ?? 'start');

      default:
        if (value is String) {
          return _buildStringField(key, value);
        } else if (value is num) {
          return _buildNumberField(key, value);
        } else if (value is bool) {
          return _buildBooleanField(key, value);
        }
        return _buildStringField(key, value?.toString() ?? '');
    }
  }

  Widget _buildStringField(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: TextFormField(
        controller: _controllers[key],
        decoration: InputDecoration(
          labelText: _formatPropertyName(key),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingS,
          ),
        ),
        onChanged: (newValue) => _updateProperty(key, newValue),
      ),
    );
  }

  Widget _buildNumberField(String key, num value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: TextFormField(
        controller: _controllers[key],
        decoration: InputDecoration(
          labelText: _formatPropertyName(key),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingS,
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        onChanged: (newValue) {
          final parsed = double.tryParse(newValue);
          if (parsed != null) {
            _updateProperty(key, parsed);
          }
        },
      ),
    );
  }

  Widget _buildColorField(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controllers[key],
              decoration: InputDecoration(
                labelText: _formatPropertyName(key),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingM,
                  vertical: AppConstants.spacingS,
                ),
              ),
              onChanged: (newValue) => _updateProperty(key, newValue),
            ),
          ),
          const SizedBox(width: AppConstants.spacingS),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _parseColor(value),
              border: Border.all(color: AppTheme.borderColor),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooleanField(String key, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_formatPropertyName(key), style: const TextStyle(fontSize: 16)),
          Switch(
            value: value,
            onChanged: (newValue) => _updateProperty(key, newValue),
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentField(String key, String value) {
    const alignments = [
      'topLeft',
      'topCenter',
      'topRight',
      'centerLeft',
      'center',
      'centerRight',
      'bottomLeft',
      'bottomCenter',
      'bottomRight',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_formatPropertyName(key), style: const TextStyle(fontSize: 16)),
          const SizedBox(height: AppConstants.spacingS),
          DropdownButtonFormField<String>(
            value: alignments.contains(value) ? value : 'center',
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingS,
              ),
            ),
            items: alignments
                .map(
                  (alignment) => DropdownMenuItem(
                    value: alignment,
                    child: Text(alignment),
                  ),
                )
                .toList(),
            onChanged: (newValue) => _updateProperty(key, newValue ?? 'center'),
          ),
        ],
      ),
    );
  }

  Widget _buildCrossAxisAlignmentField(String key, String value) {
    const alignments = ['start', 'center', 'end', 'stretch', 'baseline'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_formatPropertyName(key), style: const TextStyle(fontSize: 16)),
          const SizedBox(height: AppConstants.spacingS),
          DropdownButtonFormField<String>(
            value: alignments.contains(value) ? value : 'center',
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingS,
              ),
            ),
            items: alignments
                .map(
                  (alignment) => DropdownMenuItem(
                    value: alignment,
                    child: Text(alignment),
                  ),
                )
                .toList(),
            onChanged: (newValue) => _updateProperty(key, newValue ?? 'center'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainAxisAlignmentField(String key, String value) {
    const alignments = [
      'start',
      'center',
      'end',
      'spaceBetween',
      'spaceAround',
      'spaceEvenly',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_formatPropertyName(key), style: const TextStyle(fontSize: 16)),
          const SizedBox(height: AppConstants.spacingS),
          DropdownButtonFormField<String>(
            value: alignments.contains(value) ? value : 'start',
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingS,
              ),
            ),
            items: alignments
                .map(
                  (alignment) => DropdownMenuItem(
                    value: alignment,
                    child: Text(alignment),
                  ),
                )
                .toList(),
            onChanged: (newValue) => _updateProperty(key, newValue ?? 'start'),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.isEmpty) return Colors.blue;

      // Handle common color names
      switch (colorString.toLowerCase()) {
        case 'red':
          return Colors.red;
        case 'blue':
          return Colors.blue;
        case 'green':
          return Colors.green;
        case 'yellow':
          return Colors.yellow;
        case 'orange':
          return Colors.orange;
        case 'purple':
          return Colors.purple;
        case 'pink':
          return Colors.pink;
        case 'black':
          return Colors.black;
        case 'white':
          return Colors.white;
        case 'grey':
        case 'gray':
          return Colors.grey;
        default:
          return Colors.blue;
      }
    } catch (e) {
      return Colors.blue;
    }
  }

  String _formatPropertyName(String propertyName) {
    // Convert camelCase to Title Case
    return propertyName
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  List<String> _getRelevantProperties() {
    // Define properties that are relevant for different widget types
    switch (widget.widgetType) {
      case 'Text':
        return ['data', 'fontSize', 'color'];
      case 'Container':
        return ['width', 'height', 'color', 'padding', 'margin'];
      case 'Column':
      case 'Row':
        return ['mainAxisAlignment', 'crossAxisAlignment', 'padding'];
      case 'AppBar':
        return ['title', 'backgroundColor'];
      case 'ElevatedButton':
      case 'TextButton':
      case 'OutlinedButton':
        return ['text', 'color'];
      case 'TextField':
        return ['hintText', 'labelText'];
      default:
        return _currentProperties.keys.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentProperties.isEmpty) {
      // Show relevant properties for the widget type even if none are set
      final relevantProperties = _getRelevantProperties();
      if (relevantProperties.isNotEmpty) {
        for (final prop in relevantProperties) {
          if (!_currentProperties.containsKey(prop)) {
            _currentProperties[prop] = _getDefaultValue(prop);
            if (_currentProperties[prop] is String ||
                _currentProperties[prop] is num) {
              _controllers[prop] = TextEditingController(
                text: _currentProperties[prop].toString(),
              );
            }
          }
        }
      }
    }

    final relevantProperties = _getRelevantProperties();
    final displayProperties = relevantProperties
        .where(
          (key) =>
              _currentProperties.containsKey(key) || _isCommonProperty(key),
        )
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.widgetType} Properties',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingM),
          if (displayProperties.isNotEmpty) ...[
            ...displayProperties.map(
              (key) => _buildPropertyField(
                key,
                _currentProperties[key] ?? _getDefaultValue(key),
              ),
            ),
          ] else ...[
            const Center(
              child: Text(
                'No editable properties available for this widget',
                style: TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppConstants.spacingM),
          ElevatedButton(
            onPressed: () => _addCustomProperty(),
            child: const Text('Add Custom Property'),
          ),
        ],
      ),
    );
  }

  bool _isCommonProperty(String property) {
    const commonProperties = [
      'data',
      'text',
      'width',
      'height',
      'color',
      'backgroundColor',
      'padding',
      'margin',
      'alignment',
      'visible',
      'enabled',
    ];
    return commonProperties.contains(property);
  }

  dynamic _getDefaultValue(String property) {
    switch (property) {
      case 'data':
      case 'text':
      case 'title':
      case 'subtitle':
        return 'Text';
      case 'hintText':
        return 'Enter text';
      case 'width':
      case 'height':
        return 100.0;
      case 'fontSize':
        return 16.0;
      case 'padding':
      case 'margin':
        return 8.0;
      case 'color':
      case 'backgroundColor':
        return 'blue';
      case 'visible':
      case 'enabled':
        return true;
      case 'alignment':
        return 'center';
      case 'mainAxisAlignment':
        return 'start';
      case 'crossAxisAlignment':
        return 'center';
      default:
        return '';
    }
  }

  void _addCustomProperty() {
    showDialog(
      context: context,
      builder: (context) => _CustomPropertyDialog(
        onPropertyAdded: (key, value) {
          setState(() {
            _currentProperties[key] = value;
            if (value is String || value is num) {
              _controllers[key] = TextEditingController(text: value.toString());
            }
          });
          widget.onPropertiesChanged(_currentProperties);
        },
      ),
    );
  }
}

class _CustomPropertyDialog extends StatefulWidget {
  final Function(String key, dynamic value) onPropertyAdded;

  const _CustomPropertyDialog({required this.onPropertyAdded});

  @override
  State<_CustomPropertyDialog> createState() => _CustomPropertyDialogState();
}

class _CustomPropertyDialogState extends State<_CustomPropertyDialog> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();
  String _selectedType = 'String';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Custom Property'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: const InputDecoration(
              labelText: 'Property Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'String', child: Text('String')),
              DropdownMenuItem(value: 'Number', child: Text('Number')),
              DropdownMenuItem(value: 'Boolean', child: Text('Boolean')),
            ],
            onChanged: (value) => setState(() => _selectedType = value!),
          ),
          const SizedBox(height: AppConstants.spacingM),
          if (_selectedType != 'Boolean')
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
              keyboardType: _selectedType == 'Number'
                  ? TextInputType.number
                  : TextInputType.text,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final key = _keyController.text.trim();
            if (key.isNotEmpty) {
              dynamic value;
              switch (_selectedType) {
                case 'String':
                  value = _valueController.text;
                  break;
                case 'Number':
                  value = double.tryParse(_valueController.text) ?? 0.0;
                  break;
                case 'Boolean':
                  value = true;
                  break;
              }
              widget.onPropertyAdded(key, value);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
