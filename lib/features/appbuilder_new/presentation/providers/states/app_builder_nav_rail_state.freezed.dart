// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_builder_nav_rail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBuilderNavRailState {

 int get selectedIndex;
/// Create a copy of AppBuilderNavRailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBuilderNavRailStateCopyWith<AppBuilderNavRailState> get copyWith => _$AppBuilderNavRailStateCopyWithImpl<AppBuilderNavRailState>(this as AppBuilderNavRailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBuilderNavRailState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex);

@override
String toString() {
  return 'AppBuilderNavRailState(selectedIndex: $selectedIndex)';
}


}

/// @nodoc
abstract mixin class $AppBuilderNavRailStateCopyWith<$Res>  {
  factory $AppBuilderNavRailStateCopyWith(AppBuilderNavRailState value, $Res Function(AppBuilderNavRailState) _then) = _$AppBuilderNavRailStateCopyWithImpl;
@useResult
$Res call({
 int selectedIndex
});




}
/// @nodoc
class _$AppBuilderNavRailStateCopyWithImpl<$Res>
    implements $AppBuilderNavRailStateCopyWith<$Res> {
  _$AppBuilderNavRailStateCopyWithImpl(this._self, this._then);

  final AppBuilderNavRailState _self;
  final $Res Function(AppBuilderNavRailState) _then;

/// Create a copy of AppBuilderNavRailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = null,}) {
  return _then(_self.copyWith(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppBuilderNavRailState].
extension AppBuilderNavRailStatePatterns on AppBuilderNavRailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppBuilderNavRailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppBuilderNavRailState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppBuilderNavRailState value)  $default,){
final _that = this;
switch (_that) {
case _AppBuilderNavRailState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppBuilderNavRailState value)?  $default,){
final _that = this;
switch (_that) {
case _AppBuilderNavRailState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int selectedIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppBuilderNavRailState() when $default != null:
return $default(_that.selectedIndex);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int selectedIndex)  $default,) {final _that = this;
switch (_that) {
case _AppBuilderNavRailState():
return $default(_that.selectedIndex);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int selectedIndex)?  $default,) {final _that = this;
switch (_that) {
case _AppBuilderNavRailState() when $default != null:
return $default(_that.selectedIndex);case _:
  return null;

}
}

}

/// @nodoc


class _AppBuilderNavRailState implements AppBuilderNavRailState {
  const _AppBuilderNavRailState({this.selectedIndex = 0});
  

@override@JsonKey() final  int selectedIndex;

/// Create a copy of AppBuilderNavRailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppBuilderNavRailStateCopyWith<_AppBuilderNavRailState> get copyWith => __$AppBuilderNavRailStateCopyWithImpl<_AppBuilderNavRailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppBuilderNavRailState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex);

@override
String toString() {
  return 'AppBuilderNavRailState(selectedIndex: $selectedIndex)';
}


}

/// @nodoc
abstract mixin class _$AppBuilderNavRailStateCopyWith<$Res> implements $AppBuilderNavRailStateCopyWith<$Res> {
  factory _$AppBuilderNavRailStateCopyWith(_AppBuilderNavRailState value, $Res Function(_AppBuilderNavRailState) _then) = __$AppBuilderNavRailStateCopyWithImpl;
@override @useResult
$Res call({
 int selectedIndex
});




}
/// @nodoc
class __$AppBuilderNavRailStateCopyWithImpl<$Res>
    implements _$AppBuilderNavRailStateCopyWith<$Res> {
  __$AppBuilderNavRailStateCopyWithImpl(this._self, this._then);

  final _AppBuilderNavRailState _self;
  final $Res Function(_AppBuilderNavRailState) _then;

/// Create a copy of AppBuilderNavRailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = null,}) {
  return _then(_AppBuilderNavRailState(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
