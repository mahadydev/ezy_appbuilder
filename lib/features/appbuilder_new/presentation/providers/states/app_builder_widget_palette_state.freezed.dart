// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_builder_widget_palette_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBuilderWidgetPaletteState {

 List<String> get widgets;
/// Create a copy of AppBuilderWidgetPaletteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBuilderWidgetPaletteStateCopyWith<AppBuilderWidgetPaletteState> get copyWith => _$AppBuilderWidgetPaletteStateCopyWithImpl<AppBuilderWidgetPaletteState>(this as AppBuilderWidgetPaletteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBuilderWidgetPaletteState&&const DeepCollectionEquality().equals(other.widgets, widgets));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(widgets));

@override
String toString() {
  return 'AppBuilderWidgetPaletteState(widgets: $widgets)';
}


}

/// @nodoc
abstract mixin class $AppBuilderWidgetPaletteStateCopyWith<$Res>  {
  factory $AppBuilderWidgetPaletteStateCopyWith(AppBuilderWidgetPaletteState value, $Res Function(AppBuilderWidgetPaletteState) _then) = _$AppBuilderWidgetPaletteStateCopyWithImpl;
@useResult
$Res call({
 List<String> widgets
});




}
/// @nodoc
class _$AppBuilderWidgetPaletteStateCopyWithImpl<$Res>
    implements $AppBuilderWidgetPaletteStateCopyWith<$Res> {
  _$AppBuilderWidgetPaletteStateCopyWithImpl(this._self, this._then);

  final AppBuilderWidgetPaletteState _self;
  final $Res Function(AppBuilderWidgetPaletteState) _then;

/// Create a copy of AppBuilderWidgetPaletteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? widgets = null,}) {
  return _then(_self.copyWith(
widgets: null == widgets ? _self.widgets : widgets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppBuilderWidgetPaletteState].
extension AppBuilderWidgetPaletteStatePatterns on AppBuilderWidgetPaletteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppBuilderWidgetPaletteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppBuilderWidgetPaletteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppBuilderWidgetPaletteState value)  $default,){
final _that = this;
switch (_that) {
case _AppBuilderWidgetPaletteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppBuilderWidgetPaletteState value)?  $default,){
final _that = this;
switch (_that) {
case _AppBuilderWidgetPaletteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> widgets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppBuilderWidgetPaletteState() when $default != null:
return $default(_that.widgets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> widgets)  $default,) {final _that = this;
switch (_that) {
case _AppBuilderWidgetPaletteState():
return $default(_that.widgets);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> widgets)?  $default,) {final _that = this;
switch (_that) {
case _AppBuilderWidgetPaletteState() when $default != null:
return $default(_that.widgets);case _:
  return null;

}
}

}

/// @nodoc


class _AppBuilderWidgetPaletteState implements AppBuilderWidgetPaletteState {
  const _AppBuilderWidgetPaletteState({final  List<String> widgets = const <String>[]}): _widgets = widgets;
  

 final  List<String> _widgets;
@override@JsonKey() List<String> get widgets {
  if (_widgets is EqualUnmodifiableListView) return _widgets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_widgets);
}


/// Create a copy of AppBuilderWidgetPaletteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppBuilderWidgetPaletteStateCopyWith<_AppBuilderWidgetPaletteState> get copyWith => __$AppBuilderWidgetPaletteStateCopyWithImpl<_AppBuilderWidgetPaletteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppBuilderWidgetPaletteState&&const DeepCollectionEquality().equals(other._widgets, _widgets));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_widgets));

@override
String toString() {
  return 'AppBuilderWidgetPaletteState(widgets: $widgets)';
}


}

/// @nodoc
abstract mixin class _$AppBuilderWidgetPaletteStateCopyWith<$Res> implements $AppBuilderWidgetPaletteStateCopyWith<$Res> {
  factory _$AppBuilderWidgetPaletteStateCopyWith(_AppBuilderWidgetPaletteState value, $Res Function(_AppBuilderWidgetPaletteState) _then) = __$AppBuilderWidgetPaletteStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> widgets
});




}
/// @nodoc
class __$AppBuilderWidgetPaletteStateCopyWithImpl<$Res>
    implements _$AppBuilderWidgetPaletteStateCopyWith<$Res> {
  __$AppBuilderWidgetPaletteStateCopyWithImpl(this._self, this._then);

  final _AppBuilderWidgetPaletteState _self;
  final $Res Function(_AppBuilderWidgetPaletteState) _then;

/// Create a copy of AppBuilderWidgetPaletteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? widgets = null,}) {
  return _then(_AppBuilderWidgetPaletteState(
widgets: null == widgets ? _self._widgets : widgets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
