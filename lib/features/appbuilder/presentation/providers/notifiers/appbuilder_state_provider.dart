import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
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

  void addWidgetToCanvas(String widgetType) {}
}
