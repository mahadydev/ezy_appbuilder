import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_builder_widget_palette_state.freezed.dart';

@freezed
sealed class AppBuilderWidgetPaletteState with _$AppBuilderWidgetPaletteState {
  const factory AppBuilderWidgetPaletteState({
    @Default(<String>[]) final List<String> widgets,
  }) = _AppBuilderWidgetPaletteState;
}
