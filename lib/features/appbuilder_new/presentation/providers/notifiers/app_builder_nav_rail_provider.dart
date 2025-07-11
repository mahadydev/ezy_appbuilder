import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/states/app_builder_nav_rail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_builder_nav_rail_provider.g.dart';

@riverpod
class AppBuilderNavRailNotifier extends _$AppBuilderNavRailNotifier {
  @override
  AppBuilderNavRailState build() {
    return const AppBuilderNavRailState();
  }

  void selectIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
