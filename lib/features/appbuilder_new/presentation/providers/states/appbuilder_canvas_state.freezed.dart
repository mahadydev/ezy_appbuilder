// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appbuilder_canvas_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppbuilderCanvasState {

 Map<String, dynamic> get theJson; String? get selectedWidgetId;
/// Create a copy of AppbuilderCanvasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppbuilderCanvasStateCopyWith<AppbuilderCanvasState> get copyWith => _$AppbuilderCanvasStateCopyWithImpl<AppbuilderCanvasState>(this as AppbuilderCanvasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppbuilderCanvasState&&const DeepCollectionEquality().equals(other.theJson, theJson)&&(identical(other.selectedWidgetId, selectedWidgetId) || other.selectedWidgetId == selectedWidgetId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(theJson),selectedWidgetId);

@override
String toString() {
  return 'AppbuilderCanvasState(theJson: $theJson, selectedWidgetId: $selectedWidgetId)';
}


}

/// @nodoc
abstract mixin class $AppbuilderCanvasStateCopyWith<$Res>  {
  factory $AppbuilderCanvasStateCopyWith(AppbuilderCanvasState value, $Res Function(AppbuilderCanvasState) _then) = _$AppbuilderCanvasStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> theJson, String? selectedWidgetId
});




}
/// @nodoc
class _$AppbuilderCanvasStateCopyWithImpl<$Res>
    implements $AppbuilderCanvasStateCopyWith<$Res> {
  _$AppbuilderCanvasStateCopyWithImpl(this._self, this._then);

  final AppbuilderCanvasState _self;
  final $Res Function(AppbuilderCanvasState) _then;

/// Create a copy of AppbuilderCanvasState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theJson = null,Object? selectedWidgetId = freezed,}) {
  return _then(_self.copyWith(
theJson: null == theJson ? _self.theJson : theJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,selectedWidgetId: freezed == selectedWidgetId ? _self.selectedWidgetId : selectedWidgetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppbuilderCanvasState].
extension AppbuilderCanvasStatePatterns on AppbuilderCanvasState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppbuilderCanvasState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppbuilderCanvasState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppbuilderCanvasState value)  $default,){
final _that = this;
switch (_that) {
case _AppbuilderCanvasState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppbuilderCanvasState value)?  $default,){
final _that = this;
switch (_that) {
case _AppbuilderCanvasState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> theJson,  String? selectedWidgetId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppbuilderCanvasState() when $default != null:
return $default(_that.theJson,_that.selectedWidgetId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> theJson,  String? selectedWidgetId)  $default,) {final _that = this;
switch (_that) {
case _AppbuilderCanvasState():
return $default(_that.theJson,_that.selectedWidgetId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> theJson,  String? selectedWidgetId)?  $default,) {final _that = this;
switch (_that) {
case _AppbuilderCanvasState() when $default != null:
return $default(_that.theJson,_that.selectedWidgetId);case _:
  return null;

}
}

}

/// @nodoc


class _AppbuilderCanvasState implements AppbuilderCanvasState {
  const _AppbuilderCanvasState({final  Map<String, dynamic> theJson = const {}, this.selectedWidgetId}): _theJson = theJson;
  

 final  Map<String, dynamic> _theJson;
@override@JsonKey() Map<String, dynamic> get theJson {
  if (_theJson is EqualUnmodifiableMapView) return _theJson;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_theJson);
}

@override final  String? selectedWidgetId;

/// Create a copy of AppbuilderCanvasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppbuilderCanvasStateCopyWith<_AppbuilderCanvasState> get copyWith => __$AppbuilderCanvasStateCopyWithImpl<_AppbuilderCanvasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppbuilderCanvasState&&const DeepCollectionEquality().equals(other._theJson, _theJson)&&(identical(other.selectedWidgetId, selectedWidgetId) || other.selectedWidgetId == selectedWidgetId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_theJson),selectedWidgetId);

@override
String toString() {
  return 'AppbuilderCanvasState(theJson: $theJson, selectedWidgetId: $selectedWidgetId)';
}


}

/// @nodoc
abstract mixin class _$AppbuilderCanvasStateCopyWith<$Res> implements $AppbuilderCanvasStateCopyWith<$Res> {
  factory _$AppbuilderCanvasStateCopyWith(_AppbuilderCanvasState value, $Res Function(_AppbuilderCanvasState) _then) = __$AppbuilderCanvasStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> theJson, String? selectedWidgetId
});




}
/// @nodoc
class __$AppbuilderCanvasStateCopyWithImpl<$Res>
    implements _$AppbuilderCanvasStateCopyWith<$Res> {
  __$AppbuilderCanvasStateCopyWithImpl(this._self, this._then);

  final _AppbuilderCanvasState _self;
  final $Res Function(_AppbuilderCanvasState) _then;

/// Create a copy of AppbuilderCanvasState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theJson = null,Object? selectedWidgetId = freezed,}) {
  return _then(_AppbuilderCanvasState(
theJson: null == theJson ? _self._theJson : theJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,selectedWidgetId: freezed == selectedWidgetId ? _self.selectedWidgetId : selectedWidgetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
