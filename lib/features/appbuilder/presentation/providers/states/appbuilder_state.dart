import 'package:freezed_annotation/freezed_annotation.dart';

part 'appbuilder_state.freezed.dart';

@freezed
sealed class AppbuilderState with _$AppbuilderState {
  const factory AppbuilderState({
    @Default(false) final bool isCanvasLoading,
    @Default(false) final bool showPreview,
    @Default({}) final Map<String, dynamic> theJson,
  }) = _AppbuilderState;
}
