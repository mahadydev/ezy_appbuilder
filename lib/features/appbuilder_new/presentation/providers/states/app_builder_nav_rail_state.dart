import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_builder_nav_rail_state.freezed.dart';

@freezed
sealed class AppBuilderNavRailState with _$AppBuilderNavRailState {
  const factory AppBuilderNavRailState({@Default(0) final int selectedIndex}) =
      _AppBuilderNavRailState;
}
