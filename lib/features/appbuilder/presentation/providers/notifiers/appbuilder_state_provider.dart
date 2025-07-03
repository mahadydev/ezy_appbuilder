import 'package:ezy_appbuilder/core/utils/toast.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_ui_builder/json_ui_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appbuilder_state_provider.g.dart';

@riverpod
class AppBuilderStateNotifier extends _$AppBuilderStateNotifier {
  @override
  AppbuilderState build() {
    return const AppbuilderState();
  }

  /// Toggle the preview mode
  void togglePreview() {
    state = state.copyWith(showPreview: !state.showPreview);
  }

  /// Reset the JSON state
  void resetJson() {
    state = state.copyWith(theJson: {});
  }

  /// Add a widget to the canvas root (or as a child in the future)
  void addWidgetToCanvas(String widgetType) {
    final builder = JsonUIBuilder();
    if (state.theJson.isEmpty && widgetType != 'Scaffold') {
      return Toast.error('Canvas is empty. Please add a scaffold first.');
    } else {
      switch (widgetType) {
        case 'Scaffold':
          // Handle adding a Scaffold widget
          final scaffoldConfig = WidgetConfig(type: 'Scaffold');
          state = state.copyWith(theJson: builder.configToJson(scaffoldConfig));
          break;
        case 'AppBar':
          final appBarConfig = WidgetConfig(type: 'AppBar');
          final currentJson = builder.jsonToConfig(state.theJson);
          if (currentJson.type == 'Scaffold') {
            currentJson.properties['appBar'] = appBarConfig.toJson();
            state = state.copyWith(theJson: builder.configToJson(currentJson));
          }
          break;
        case 'Column':
          // Handle adding a Column widget
          break;
        default:
      }
    }
    debugPrint('${state.theJson}');
  }
}
