import 'dart:convert';

import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/core/json_ui_builder.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/models/widget_config.dart';
import 'package:ezy_appbuilder/core/utils/toast.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/states/appbuilder_canvas_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_builder_canvas_provider.g.dart';

@riverpod
class AppBuilderCanvasNotifier extends _$AppBuilderCanvasNotifier {
  @override
  AppbuilderCanvasState build() {
    return const AppbuilderCanvasState();
  }

  // History for undo/redo functionality
  final List<Map<String, dynamic>> _history = [];
  int _historyIndex = -1;
  static const int _maxHistorySize = 50;

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
      state = state.copyWith(theJson: previousState);
      Toast.success('Undone');
    }
  }

  /// Redo the last undone action
  void redo() {
    if (canRedo()) {
      _historyIndex++;
      final nextState = _history[_historyIndex];
      state = state.copyWith(theJson: nextState);
      Toast.success('Redone');
    }
  }

  /// Check if undo is possible
  bool canUndo() => _historyIndex > 0;

  /// Check if redo is possible
  bool canRedo() => _historyIndex < _history.length - 1;

  /// Accepts a widget type and adds it to the canvas state.
  void addWidgetToCanvas(String widgetType) {
    final builder = JsonUIBuilder();

    // Validate the widget type
    if (!builder.isWidgetTypeSupported(widgetType)) {
      Toast.error('Unsupported widget type: $widgetType');
      return;
    }

    if (state.theJson.isEmpty && widgetType != 'Scaffold') {
      Toast.error('Canvas is empty. Please add a scaffold first.');
      return;
    }

    _saveToHistory();

    switch (widgetType) {
      case 'Scaffold':
        final scaffoldConfig = WidgetConfig(type: widgetType);
        state = state.copyWith(theJson: builder.configToJson(scaffoldConfig));
        break;

      case 'AppBar':
        final scaffoldConfig = builder.jsonToConfig(state.theJson);
        final appBarConfig = WidgetConfig(type: widgetType);
        scaffoldConfig.properties['appBar'] = appBarConfig.toJson();
        state = state.copyWith(theJson: builder.configToJson(scaffoldConfig));
        break;

      case 'Drawer':
        final scaffoldConfig = builder.jsonToConfig(state.theJson);
        final drawerConfig = WidgetConfig(type: widgetType);
        scaffoldConfig.properties['drawer'] = drawerConfig.toJson();
        state = state.copyWith(theJson: builder.configToJson(scaffoldConfig));
        break;

      default:
        _addChildWidget(widgetType);
        break;
    }
  }

  /// Helper method to add a child widget to the appropriate parent container
  void _addChildWidget(String widgetType) {
    final builder = JsonUIBuilder();
    final parentConfig = builder.jsonToConfig(state.theJson);

    // Create the new widget config
    final newWidgetConfig = WidgetConfig(type: widgetType);

    // Set default properties for required properties
    switch (widgetType) {
      case 'Text':
        newWidgetConfig.setProperty('data', 'Your Text Here');
        newWidgetConfig.setProperty('color', '#000000');
        break;
      default:
        break;
    }

    _saveToHistory();

    if (_addToParentWidget(parentConfig, newWidgetConfig)) {
      state = state.copyWith(theJson: builder.configToJson(parentConfig));
    }
  }

  /// Determines the best place to add a child widget based on parent type
  bool _addToParentWidget(WidgetConfig parent, WidgetConfig child) {
    switch (parent.type) {
      case 'Scaffold':
        if (parent.child == null) {
          parent.child = child;
          return true;
        } else {
          Toast.error('Scaffold can only have one child widget');
          return false;
        }

      case 'Column':
      case 'Row':
      case 'ListView':
        parent.children ??= [];
        parent.addChild(child);
        return true;
      default:
        return false;
    }
  }

  /// Delete a widget from the tree
  void deleteWidget(String widgetId) {
    if (state.theJson.isEmpty) return;

    final builder = JsonUIBuilder();
    final currentConfig = builder.jsonToConfig(state.theJson);

    if (_deleteWidgetInConfig(currentConfig, widgetId)) {
      // Save current state before making changes
      _saveToHistory();

      state = state.copyWith(theJson: builder.configToJson(currentConfig));
      Toast.success('Widget deleted');
    }
  }

  /// Helper method to find and delete a widget by ID
  bool _deleteWidgetInConfig(WidgetConfig config, String targetId) {
    // Check child
    if (config.child != null) {
      if (config.child?.id == targetId) {
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
        final childId = config.children![i].id;
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

  void resetCanvas() {
    _saveToHistory();
    state = state.copyWith(theJson: {});
    Toast.success('Canvas reset');
  }

  /// Select a widget by its ID
  void selectWidget(String? widgetId) {
    state = state.copyWith(selectedWidgetId: widgetId);
  }

  /// Load project from local storage
  Future<void> loadProject(String projectName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final projectDataString = prefs.getString('project_$projectName');

      if (projectDataString != null) {
        final projectData = jsonDecode(projectDataString);
        final json = Map<String, dynamic>.from(projectData['json']);

        _saveToHistory(); // Save current state before loading

        state = state.copyWith(theJson: json, selectedWidgetId: null);

        Toast.success('Project loaded successfully');
      } else {
        Toast.error('Project not found');
      }
    } catch (e) {
      Toast.error('Failed to load project: $e');
    }
  }

  /// Get list of saved projects
  Future<List<String>> getSavedProjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final projectKeys = keys
          .where((key) => key.startsWith('project_'))
          .toList();
      return projectKeys.map((key) => key.substring(8)).toList();
    } catch (e) {
      Toast.error('Failed to get saved projects: $e');
      return [];
    }
  }

  /// Delete a saved project
  Future<void> deleteProject(String projectName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('project_$projectName');
      Toast.success('Project deleted successfully');
    } catch (e) {
      Toast.error('Failed to delete project: $e');
    }
  }
}
