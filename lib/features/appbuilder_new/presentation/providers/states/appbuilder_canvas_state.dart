import 'package:freezed_annotation/freezed_annotation.dart';

part 'appbuilder_canvas_state.freezed.dart';

@freezed
sealed class AppbuilderCanvasState with _$AppbuilderCanvasState {
  const factory AppbuilderCanvasState({
    @Default({}) final Map<String, dynamic> theJson,
    final String? selectedWidgetId,
  }) = _AppbuilderCanvasState;
}
