import 'dart:convert';

import 'package:ezy_appbuilder/core/utils/toast.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_ui_builder/json_ui_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final currentId = config.id;

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

  // Use this function to add a widget to a specific parent
  /// Add a widget to a specific parent by ID
  void addWidgetToParent(String parentId, String widgetType) {
    _saveToHistory();
    final builder = JsonUIBuilder();
    final currentConfig = builder.jsonToConfig(state.theJson);
    final newWidgetConfig = WidgetConfig(type: widgetType);

    // Set default properties based on widget type (copied from _addGenericWidget)
    switch (widgetType) {
      case 'Text':
        newWidgetConfig.properties['text'] = 'Hello World';
        newWidgetConfig.properties['fontSize'] = 16.0;
        newWidgetConfig.properties['color'] = 'black';
        break;
      case 'Container':
        newWidgetConfig.properties['width'] = 100.0;
        newWidgetConfig.properties['height'] = 100.0;
        newWidgetConfig.properties['color'] = '#ffeedd';
        //  newWidgetConfig.properties['padding'] = 8.0;
        break;
      case 'ElevatedButton':
      case 'TextButton':
      case 'OutlinedButton':
        newWidgetConfig.properties['text'] = 'Button';
        newWidgetConfig.properties['color'] = 'primary';
        break;
      case 'TextField':
      case 'TextFormField':
        newWidgetConfig.properties['hintText'] = 'Enter text';
        newWidgetConfig.properties['labelText'] = 'Label';
        break;
      case 'Icon':
        newWidgetConfig.properties['icon'] = 'star';
        newWidgetConfig.properties['size'] = 24.0;
        newWidgetConfig.properties['color'] = 'black';
        break;
      case 'Image':
        newWidgetConfig.properties['src'] = 'https://via.placeholder.com/150';
        newWidgetConfig.properties['width'] = 150.0;
        newWidgetConfig.properties['height'] = 150.0;
        break;
      case 'Card':
        newWidgetConfig.properties['elevation'] = 4.0;
        newWidgetConfig.properties['margin'] = 8.0;
        break;
      case 'ListTile':
        newWidgetConfig.properties['title'] = 'List Item';
        newWidgetConfig.properties['subtitle'] = 'Subtitle';
        break;
      case 'Checkbox':
        newWidgetConfig.properties['value'] = false;
        break;
      case 'Switch':
        newWidgetConfig.properties['value'] = false;
        break;
      case 'Radio':
        newWidgetConfig.properties['value'] = 'option1';
        newWidgetConfig.properties['groupValue'] = 'option1';
        break;
      case 'Slider':
        newWidgetConfig.properties['value'] = 0.5;
        newWidgetConfig.properties['min'] = 0.0;
        newWidgetConfig.properties['max'] = 1.0;
        break;
      case 'FloatingActionButton':
        newWidgetConfig.properties['backgroundColor'] = 'primary';
        newWidgetConfig.properties['foregroundColor'] = 'white';
        break;
      case 'AppBar':
        newWidgetConfig.properties['title'] = 'App Bar';
        newWidgetConfig.properties['backgroundColor'] = 'primary';
        break;
      case 'Column':
      case 'Row':
        newWidgetConfig.properties['mainAxisAlignment'] = 'start';
        newWidgetConfig.properties['crossAxisAlignment'] = 'center';
        break;
      case 'Stack':
        newWidgetConfig.properties['alignment'] = 'center';
        break;
      case 'Positioned':
        newWidgetConfig.properties['top'] = 0.0;
        newWidgetConfig.properties['left'] = 0.0;
        break;
      case 'Expanded':
      case 'Flexible':
        newWidgetConfig.properties['flex'] = 1;
        break;
      case 'Padding':
        newWidgetConfig.properties['padding'] = 8.0;
        break;
      case 'SizedBox':
        newWidgetConfig.properties['width'] = 100.0;
        newWidgetConfig.properties['height'] = 100.0;
        break;
      default:
        break;
    }

    if (_addWidgetToSpecificParent(currentConfig, parentId, newWidgetConfig)) {
      state = state.copyWith(theJson: builder.configToJson(currentConfig));
    } else {
      Toast.error('Could not add widget to $parentId');
    }
  }

  // Helper method for addWidgetToParent

  bool _addWidgetToSpecificParent(
    WidgetConfig config,
    String parentId,
    WidgetConfig newWidget,
  ) {
    if (config.id == parentId) {
      // Add as child or to children depending on config.type
      if ([
        'Column',
        'Row',
        'Wrap',
        'ListView',
        'GridView',
        'Stack',
      ].contains(config.type)) {
        config.children ??= [];
        config.children!.add(newWidget);
      } else if (config.child == null) {
        config.child = newWidget;
      } else {
        // Optionally handle replacing or error
        return false;
      }
      return true;
    }
    if (config.child != null &&
        _addWidgetToSpecificParent(config.child!, parentId, newWidget))
      return true;
    if (config.children != null) {
      for (final child in config.children!) {
        if (_addWidgetToSpecificParent(child, parentId, newWidget)) return true;
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
          appBarConfig.properties['title'] = 'App Bar';
          final currentConfig = builder.jsonToConfig(state.theJson);
          if (currentConfig.type == 'Scaffold') {
            currentConfig.properties['appBar'] = appBarConfig.toJson();
            state = state.copyWith(
              theJson: builder.configToJson(currentConfig),
            );
          }
          break;
        case 'FloatingActionButton':
          final fabConfig = WidgetConfig(type: 'FloatingActionButton');
          fabConfig.properties['backgroundColor'] = 'primary';
          final currentConfig = builder.jsonToConfig(state.theJson);
          if (currentConfig.type == 'Scaffold') {
            currentConfig.properties['floatingActionButton'] = fabConfig
                .toJson();
            state = state.copyWith(
              theJson: builder.configToJson(currentConfig),
            );
          }
          break;
        case 'Drawer':
          final drawerConfig = WidgetConfig(type: 'Drawer');
          final currentConfig = builder.jsonToConfig(state.theJson);
          if (currentConfig.type == 'Scaffold') {
            currentConfig.properties['drawer'] = drawerConfig.toJson();
            state = state.copyWith(
              theJson: builder.configToJson(currentConfig),
            );
          }
          break;
        case 'BottomNavigationBar':
          final bottomNavConfig = WidgetConfig(type: 'BottomNavigationBar');
          final currentConfig = builder.jsonToConfig(state.theJson);
          if (currentConfig.type == 'Scaffold') {
            currentConfig.properties['bottomNavigationBar'] = bottomNavConfig
                .toJson();
            state = state.copyWith(
              theJson: builder.configToJson(currentConfig),
            );
          }
          break;
        case 'Column':
        case 'Row':
        case 'Stack':
        case 'Wrap':
        case 'ListView':
        case 'GridView':
          final layoutConfig = WidgetConfig(type: widgetType);
          layoutConfig.properties['mainAxisAlignment'] = 'start';
          layoutConfig.properties['crossAxisAlignment'] = 'center';
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
        newWidgetConfig.properties['fontSize'] = 16.0;
        newWidgetConfig.properties['color'] = 'black';
        break;
      case 'Container':
        newWidgetConfig.properties['width'] = 100.0;
        newWidgetConfig.properties['height'] = 100.0;
        newWidgetConfig.properties['color'] = '#ffeedd';
        //   newWidgetConfig.properties['padding'] = 8.0;
        break;
      case 'ElevatedButton':
      case 'TextButton':
      case 'OutlinedButton':
        newWidgetConfig.properties['text'] = 'Button';
        newWidgetConfig.properties['color'] = 'primary';
        break;
      case 'TextField':
      case 'TextFormField':
        newWidgetConfig.properties['hintText'] = 'Enter text';
        newWidgetConfig.properties['labelText'] = 'Label';
        break;
      case 'Icon':
        newWidgetConfig.properties['icon'] = 'star';
        newWidgetConfig.properties['size'] = 24.0;
        newWidgetConfig.properties['color'] = 'black';
        break;
      case 'Image':
        newWidgetConfig.properties['src'] = 'https://via.placeholder.com/150';
        newWidgetConfig.properties['width'] = 150.0;
        newWidgetConfig.properties['height'] = 150.0;
        break;
      case 'Card':
        newWidgetConfig.properties['elevation'] = 4.0;
        newWidgetConfig.properties['margin'] = 8.0;
        break;
      case 'ListTile':
        newWidgetConfig.properties['title'] = 'List Item';
        newWidgetConfig.properties['subtitle'] = 'Subtitle';
        break;
      case 'Checkbox':
        newWidgetConfig.properties['value'] = false;
        break;
      case 'Switch':
        newWidgetConfig.properties['value'] = false;
        break;
      case 'Radio':
        newWidgetConfig.properties['value'] = 'option1';
        newWidgetConfig.properties['groupValue'] = 'option1';
        break;
      case 'Slider':
        newWidgetConfig.properties['value'] = 0.5;
        newWidgetConfig.properties['min'] = 0.0;
        newWidgetConfig.properties['max'] = 1.0;
        break;
      case 'FloatingActionButton':
        newWidgetConfig.properties['backgroundColor'] = 'primary';
        newWidgetConfig.properties['foregroundColor'] = 'white';
        break;
      case 'AppBar':
        newWidgetConfig.properties['title'] = 'App Bar';
        newWidgetConfig.properties['backgroundColor'] = 'primary';
        break;
      case 'Column':
      case 'Row':
        newWidgetConfig.properties['mainAxisAlignment'] = 'start';
        newWidgetConfig.properties['crossAxisAlignment'] = 'center';
        break;
      case 'Stack':
        newWidgetConfig.properties['alignment'] = 'center';
        break;
      case 'Positioned':
        newWidgetConfig.properties['top'] = 0.0;
        newWidgetConfig.properties['left'] = 0.0;
        break;
      case 'Expanded':
      case 'Flexible':
        newWidgetConfig.properties['flex'] = 1;
        break;
      case 'Padding':
        newWidgetConfig.properties['padding'] = 8.0;
        break;
      case 'SizedBox':
        newWidgetConfig.properties['width'] = 100.0;
        newWidgetConfig.properties['height'] = 100.0;
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
    // If parent is a Column, Row, Wrap, ListView, or GridView, add to children
    if ([
      'Column',
      'Row',
      'Wrap',
      'ListView',
      'GridView',
      'Stack',
    ].contains(parentConfig.type)) {
      parentConfig.children ??= [];
      parentConfig.children!.add(newWidget);
      return true;
    }

    // If parent is a Container, Center, Align, Card, Padding, or SizedBox and has no child, set as child
    if ([
          'Container',
          'Center',
          'Align',
          'Card',
          'Padding',
          'SizedBox',
          'Expanded',
          'Flexible',
          'SingleChildScrollView',
          'PageView',
        ].contains(parentConfig.type) &&
        parentConfig.child == null) {
      parentConfig.child = newWidget;
      return true;
    }

    // If parent is Scaffold and we're adding to body
    if (parentConfig.type == 'Scaffold' && parentConfig.child == null) {
      parentConfig.child = newWidget;
      return true;
    }

    // If parent is Stack, add to children with positioning
    if (parentConfig.type == 'Stack') {
      parentConfig.children ??= [];
      // Wrap non-positioned widgets in Positioned
      if (newWidget.type != 'Positioned') {
        final positionedWrapper = WidgetConfig(type: 'Positioned');
        positionedWrapper.properties['top'] = 0.0;
        positionedWrapper.properties['left'] = 0.0;
        positionedWrapper.child = newWidget;
        parentConfig.children!.add(positionedWrapper);
      } else {
        parentConfig.children!.add(newWidget);
      }
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

  /// Save current project to local storage
  Future<void> saveProject(String projectName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final projectData = {
        'name': projectName,
        'json': state.theJson,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await prefs.setString('project_$projectName', jsonEncode(projectData));
      Toast.success('Project saved successfully');
    } catch (e) {
      Toast.error('Failed to save project: $e');
    }
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

        state = state.copyWith(
          theJson: json,
          selectedWidgetId: null,
          selectedWidgetProperties: {},
        );

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
      return projectKeys
          .map((key) => key.substring(8))
          .toList(); // Remove 'project_' prefix
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

  /// Import JSON from external source
  void importJson(Map<String, dynamic> json) {
    try {
      _saveToHistory(); // Save current state before importing

      state = state.copyWith(
        theJson: json,
        selectedWidgetId: null,
        selectedWidgetProperties: {},
      );

      Toast.success('JSON imported successfully');
    } catch (e) {
      Toast.error('Failed to import JSON: $e');
    }
  }

  /// Export current JSON
  Map<String, dynamic> exportJson() {
    return Map<String, dynamic>.from(state.theJson);
  }
}
