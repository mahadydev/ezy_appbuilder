import 'package:ezy_appbuilder/core/packages/json_ui_builder/json_ui_builder.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/states/app_builder_widget_palette_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_builder_widget_palette_provider.g.dart';

@riverpod
class AppBuilderWidgetPaletteNotifier
    extends _$AppBuilderWidgetPaletteNotifier {
  @override
  AppBuilderWidgetPaletteState build() {
    // Initialize the state with all supported widgets
    return AppBuilderWidgetPaletteState(widgets: _widgets);
  }

  // all widgets from package:json_ui_builder
  List<String> get _widgets =>
      JsonUIBuilder().getSupportedWidgetTypes()
        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

  void filterWidgets(String query) {
    if (query.isEmpty) {
      state = state.copyWith(widgets: _widgets);
    } else {
      final filteredWidgets =
          _widgets
              .where(
                (widget) => widget.toLowerCase().contains(query.toLowerCase()),
              )
              .toList()
            ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      state = state.copyWith(widgets: filteredWidgets);
    }
  }
}
