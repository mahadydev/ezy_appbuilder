import 'package:ezy_appbuilder/core/utils/toast.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_ui_builder/json_ui_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appbuilder_state_provider.g.dart';

@riverpod
class AppBuilderStateNotifier extends _$AppBuilderStateNotifier {
  // History for undo/redo functionality
  final List<Map<String, dynamic>> _history = [];
  int _historyIndex = -1;
  static const int _maxHistorySize = 50;

  @override
  AppbuilderState build() {
    return const AppbuilderState();
  }

  /// Save current state to history for undo/redo
  void _saveToHistory() {
    // Remove any states after current index (when we're in the middle of history)
    if (_historyIndex < _history.length - 1) {
      _history.removeRange(_historyIndex + 1, _history.length);
    }

    // Add current state to history
    _history.add(Map.from(state.theJson));
    _historyIndex = _history.length - 1;

    // Limit history size
    if (_history.length > _maxHistorySize) {
      _history.removeAt(0);
      _historyIndex--;
    }
  }

  /// Undo the last action
  void undo() {
    if (canUndo()) {
      _historyIndex--;
      final previousState = _history[_historyIndex];
      state = state.copyWith(
        theJson: previousState,
        selectedWidgetId: null,
        selectedWidgetProperties: {},
      );
      Toast.success('Undone');
    }
  }

  /// Redo the last undone action
  void redo() {
    if (canRedo()) {
      _historyIndex++;
      final nextState = _history[_historyIndex];
      state = state.copyWith(
        theJson: nextState,
        selectedWidgetId: null,
        selectedWidgetProperties: {},
      );
      Toast.success('Redone');
    }
  }

  /// Check if undo is possible
  bool canUndo() => _historyIndex > 0;

  /// Check if redo is possible
  bool canRedo() => _historyIndex < _history.length - 1;

  /// Toggle the preview mode
  void togglePreview() {
    state = state.copyWith(showPreview: !state.showPreview);
  }

  /// Reset the JSON state
  void resetJson() {
    _saveToHistory();
    state = state.copyWith(
      theJson: {},
      selectedWidgetId: null,
      selectedWidgetProperties: {},
    );
    Toast.success('Canvas reset');
  }

  /// Select a widget for editing
  void selectWidget(String widgetId, Map<String, dynamic> properties) {
    state = state.copyWith(
      selectedWidgetId: widgetId,
      selectedWidgetProperties: properties,
    );
  }

  /// Clear widget selection
  void clearSelection() {
    state = state.copyWith(
      selectedWidgetId: null,
      selectedWidgetProperties: {},
    );
  }

  /// Update properties of the selected widget
  void updateWidgetProperties(Map<String, dynamic> newProperties) {
    if (state.selectedWidgetId == null) return;

    _saveToHistory(); // Save current state before making changes

    final builder = JsonUIBuilder();
    final currentConfig = builder.jsonToConfig(state.theJson);

    // Find and update the widget with the given ID
    if (_updateWidgetInConfig(
      currentConfig,
      state.selectedWidgetId!,
      newProperties,
    )) {
      state = state.copyWith(
        theJson: builder.configToJson(currentConfig),
        selectedWidgetProperties: newProperties,
      );
    }
  }

  /// Helper method to find and update a widget by ID in the config tree
  bool _updateWidgetInConfig(
    WidgetConfig config,
    String targetId,
    Map<String, dynamic> newProperties,
  ) {
    // Generate a unique ID for this widget if it doesn't exist
    final currentId = _generateWidgetId(config);

    if (currentId == targetId) {
      config.properties.addAll(newProperties);
      return true;
    }

    // Check child
    if (config.child != null) {
      if (_updateWidgetInConfig(config.child!, targetId, newProperties)) {
        return true;
      }
    }

    // Check children
    if (config.children != null) {
      for (final child in config.children!) {
        if (_updateWidgetInConfig(child, targetId, newProperties)) {
          return true;
        }
      }
    }

    return false;
  }

  /// Generate a unique ID for a widget based on its type and position
  String _generateWidgetId(WidgetConfig config) {
    return '${config.type}_${config.hashCode}';
  }

  /// Delete a widget from the tree
  void deleteWidget(String widgetId) {
    if (state.theJson.isEmpty) return;

    _saveToHistory(); // Save current state before making changes

    final builder = JsonUIBuilder();
    final currentConfig = builder.jsonToConfig(state.theJson);

    if (_deleteWidgetInConfig(currentConfig, widgetId)) {
      state = state.copyWith(
        theJson: builder.configToJson(currentConfig),
        selectedWidgetId: null,
        selectedWidgetProperties: {},
      );
      Toast.success('Widget deleted');
    }
  }

  /// Helper method to find and delete a widget by ID
  bool _deleteWidgetInConfig(WidgetConfig config, String targetId) {
    // Check child
    if (config.child != null) {
      final childId = _generateWidgetId(config.child!);
      if (childId == targetId) {
        config.child = null;
        return true;
      }
      if (_deleteWidgetInConfig(config.child!, targetId)) {
        return true;
      }
    }

    // Check children
    if (config.children != null) {
      for (int i = 0; i < config.children!.length; i++) {
        final childId = _generateWidgetId(config.children![i]);
        if (childId == targetId) {
          config.children!.removeAt(i);
          return true;
        }
        if (_deleteWidgetInConfig(config.children![i], targetId)) {
          return true;
        }
      }
    }

    return false;
  }

  /// Add a widget to the canvas
  void addWidgetToCanvas(String widgetType) {
    final builder = JsonUIBuilder();

    if (state.theJson.isEmpty && widgetType != 'Scaffold') {
      Toast.error('Canvas is empty. Please add a scaffold first.');
      return;
    }

    _saveToHistory(); // Save current state before making changes

    try {
      switch (widgetType) {
        case 'Scaffold':
          // Handle adding a Scaffold widget
          final scaffoldConfig = WidgetConfig(type: 'Scaffold');
          state = state.copyWith(theJson: builder.configToJson(scaffoldConfig));
          break;
        case 'AppBar':
          final appBarConfig = WidgetConfig(type: 'AppBar');
          final currentConfig = builder.jsonToConfig(state.theJson);
          if (currentConfig.type == 'Scaffold') {
            currentConfig.properties['appBar'] = appBarConfig.toJson();
            state = state.copyWith(
              theJson: builder.configToJson(currentConfig),
            );
          }
          break;
        case 'Column':
        case 'Row':
          final layoutConfig = WidgetConfig(type: widgetType);
          final currentConfig = builder.jsonToConfig(state.theJson);
          if (currentConfig.type == 'Scaffold' && currentConfig.child == null) {
            currentConfig.child = layoutConfig;
            state = state.copyWith(
              theJson: builder.configToJson(currentConfig),
            );
          } else {
            _addGenericWidget(widgetType);
          }
          break;
        default:
          // For other widgets, try to add them to a suitable parent
          _addGenericWidget(widgetType);
          break;
      }
      debugPrint('Widget added: $widgetType');
      debugPrint('Current JSON: ${state.theJson}');
    } catch (e) {
      Toast.error('Failed to add widget: $e');
    }
  }

  /// Helper method to add generic widgets
  void _addGenericWidget(String widgetType) {
    final builder = JsonUIBuilder();
    final currentConfig = builder.jsonToConfig(state.theJson);
    final newWidgetConfig = WidgetConfig(type: widgetType);

    // Set default properties based on widget type
    switch (widgetType) {
      case 'Text':
        newWidgetConfig.properties['text'] = 'Hello World';
        break;
      case 'Container':
        newWidgetConfig.properties['width'] = 100.0;
        newWidgetConfig.properties['height'] = 100.0;
        newWidgetConfig.properties['color'] = 'blue';
        break;
      case 'ElevatedButton':
      case 'TextButton':
      case 'OutlinedButton':
        newWidgetConfig.properties['text'] = 'Button';
        break;
      case 'TextField':
        newWidgetConfig.properties['hintText'] = 'Enter text';
        break;
    }

    if (_addWidgetToSuitableParent(currentConfig, newWidgetConfig)) {
      state = state.copyWith(theJson: builder.configToJson(currentConfig));
    } else {
      Toast.error('Could not find a suitable parent for $widgetType');
    }
  }

  /// Find a suitable parent for a widget and add it
  bool _addWidgetToSuitableParent(
    WidgetConfig parentConfig,
    WidgetConfig newWidget,
  ) {
    // If parent is a Column or Row, add to children
    if (parentConfig.type == 'Column' || parentConfig.type == 'Row') {
      parentConfig.children ??= [];
      parentConfig.children!.add(newWidget);
      return true;
    }

    // If parent is a Container or Center and has no child, set as child
    if ((parentConfig.type == 'Container' || parentConfig.type == 'Center') &&
        parentConfig.child == null) {
      parentConfig.child = newWidget;
      return true;
    }

    // If parent is Scaffold and we're adding to body
    if (parentConfig.type == 'Scaffold' && parentConfig.child == null) {
      parentConfig.child = newWidget;
      return true;
    }

    // Recursively try children
    if (parentConfig.child != null) {
      if (_addWidgetToSuitableParent(parentConfig.child!, newWidget)) {
        return true;
      }
    }

    if (parentConfig.children != null) {
      for (final child in parentConfig.children!) {
        if (_addWidgetToSuitableParent(child, newWidget)) {
          return true;
        }
      }
    }

    return false;
  }
}
