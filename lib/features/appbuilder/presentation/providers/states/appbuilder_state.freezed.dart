// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appbuilder_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppbuilderState {

 bool get isCanvasLoading; bool get showPreview; Map<String, dynamic> get theJson; String? get selectedWidgetId;// ID of currently selected widget
 Map<String, dynamic> get selectedWidgetProperties;
/// Create a copy of AppbuilderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppbuilderStateCopyWith<AppbuilderState> get copyWith => _$AppbuilderStateCopyWithImpl<AppbuilderState>(this as AppbuilderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppbuilderState&&(identical(other.isCanvasLoading, isCanvasLoading) || other.isCanvasLoading == isCanvasLoading)&&(identical(other.showPreview, showPreview) || other.showPreview == showPreview)&&const DeepCollectionEquality().equals(other.theJson, theJson)&&(identical(other.selectedWidgetId, selectedWidgetId) || other.selectedWidgetId == selectedWidgetId)&&const DeepCollectionEquality().equals(other.selectedWidgetProperties, selectedWidgetProperties));
}


@override
int get hashCode => Object.hash(runtimeType,isCanvasLoading,showPreview,const DeepCollectionEquality().hash(theJson),selectedWidgetId,const DeepCollectionEquality().hash(selectedWidgetProperties));

@override
String toString() {
  return 'AppbuilderState(isCanvasLoading: $isCanvasLoading, showPreview: $showPreview, theJson: $theJson, selectedWidgetId: $selectedWidgetId, selectedWidgetProperties: $selectedWidgetProperties)';
}


}

/// @nodoc
abstract mixin class $AppbuilderStateCopyWith<$Res>  {
  factory $AppbuilderStateCopyWith(AppbuilderState value, $Res Function(AppbuilderState) _then) = _$AppbuilderStateCopyWithImpl;
@useResult
$Res call({
 bool isCanvasLoading, bool showPreview, Map<String, dynamic> theJson, String? selectedWidgetId, Map<String, dynamic> selectedWidgetProperties
});




}
/// @nodoc
class _$AppbuilderStateCopyWithImpl<$Res>
    implements $AppbuilderStateCopyWith<$Res> {
  _$AppbuilderStateCopyWithImpl(this._self, this._then);

  final AppbuilderState _self;
  final $Res Function(AppbuilderState) _then;

/// Create a copy of AppbuilderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCanvasLoading = null,Object? showPreview = null,Object? theJson = null,Object? selectedWidgetId = freezed,Object? selectedWidgetProperties = null,}) {
  return _then(_self.copyWith(
isCanvasLoading: null == isCanvasLoading ? _self.isCanvasLoading : isCanvasLoading // ignore: cast_nullable_to_non_nullable
as bool,showPreview: null == showPreview ? _self.showPreview : showPreview // ignore: cast_nullable_to_non_nullable
as bool,theJson: null == theJson ? _self.theJson : theJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,selectedWidgetId: freezed == selectedWidgetId ? _self.selectedWidgetId : selectedWidgetId // ignore: cast_nullable_to_non_nullable
as String?,selectedWidgetProperties: null == selectedWidgetProperties ? _self.selectedWidgetProperties : selectedWidgetProperties // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppbuilderState].
extension AppbuilderStatePatterns on AppbuilderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppbuilderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppbuilderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppbuilderState value)  $default,){
final _that = this;
switch (_that) {
case _AppbuilderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppbuilderState value)?  $default,){
final _that = this;
switch (_that) {
case _AppbuilderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isCanvasLoading,  bool showPreview,  Map<String, dynamic> theJson,  String? selectedWidgetId,  Map<String, dynamic> selectedWidgetProperties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppbuilderState() when $default != null:
return $default(_that.isCanvasLoading,_that.showPreview,_that.theJson,_that.selectedWidgetId,_that.selectedWidgetProperties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isCanvasLoading,  bool showPreview,  Map<String, dynamic> theJson,  String? selectedWidgetId,  Map<String, dynamic> selectedWidgetProperties)  $default,) {final _that = this;
switch (_that) {
case _AppbuilderState():
return $default(_that.isCanvasLoading,_that.showPreview,_that.theJson,_that.selectedWidgetId,_that.selectedWidgetProperties);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isCanvasLoading,  bool showPreview,  Map<String, dynamic> theJson,  String? selectedWidgetId,  Map<String, dynamic> selectedWidgetProperties)?  $default,) {final _that = this;
switch (_that) {
case _AppbuilderState() when $default != null:
return $default(_that.isCanvasLoading,_that.showPreview,_that.theJson,_that.selectedWidgetId,_that.selectedWidgetProperties);case _:
  return null;

}
}

}

/// @nodoc


class _AppbuilderState implements AppbuilderState {
  const _AppbuilderState({this.isCanvasLoading = false, this.showPreview = false, final  Map<String, dynamic> theJson = const {}, this.selectedWidgetId, final  Map<String, dynamic> selectedWidgetProperties = const {}}): _theJson = theJson,_selectedWidgetProperties = selectedWidgetProperties;
  

@override@JsonKey() final  bool isCanvasLoading;
@override@JsonKey() final  bool showPreview;
 final  Map<String, dynamic> _theJson;
@override@JsonKey() Map<String, dynamic> get theJson {
  if (_theJson is EqualUnmodifiableMapView) return _theJson;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_theJson);
}

@override final  String? selectedWidgetId;
// ID of currently selected widget
 final  Map<String, dynamic> _selectedWidgetProperties;
// ID of currently selected widget
@override@JsonKey() Map<String, dynamic> get selectedWidgetProperties {
  if (_selectedWidgetProperties is EqualUnmodifiableMapView) return _selectedWidgetProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedWidgetProperties);
}


/// Create a copy of AppbuilderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppbuilderStateCopyWith<_AppbuilderState> get copyWith => __$AppbuilderStateCopyWithImpl<_AppbuilderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppbuilderState&&(identical(other.isCanvasLoading, isCanvasLoading) || other.isCanvasLoading == isCanvasLoading)&&(identical(other.showPreview, showPreview) || other.showPreview == showPreview)&&const DeepCollectionEquality().equals(other._theJson, _theJson)&&(identical(other.selectedWidgetId, selectedWidgetId) || other.selectedWidgetId == selectedWidgetId)&&const DeepCollectionEquality().equals(other._selectedWidgetProperties, _selectedWidgetProperties));
}


@override
int get hashCode => Object.hash(runtimeType,isCanvasLoading,showPreview,const DeepCollectionEquality().hash(_theJson),selectedWidgetId,const DeepCollectionEquality().hash(_selectedWidgetProperties));

@override
String toString() {
  return 'AppbuilderState(isCanvasLoading: $isCanvasLoading, showPreview: $showPreview, theJson: $theJson, selectedWidgetId: $selectedWidgetId, selectedWidgetProperties: $selectedWidgetProperties)';
}


}

/// @nodoc
abstract mixin class _$AppbuilderStateCopyWith<$Res> implements $AppbuilderStateCopyWith<$Res> {
  factory _$AppbuilderStateCopyWith(_AppbuilderState value, $Res Function(_AppbuilderState) _then) = __$AppbuilderStateCopyWithImpl;
@override @useResult
$Res call({
 bool isCanvasLoading, bool showPreview, Map<String, dynamic> theJson, String? selectedWidgetId, Map<String, dynamic> selectedWidgetProperties
});




}
/// @nodoc
class __$AppbuilderStateCopyWithImpl<$Res>
    implements _$AppbuilderStateCopyWith<$Res> {
  __$AppbuilderStateCopyWithImpl(this._self, this._then);

  final _AppbuilderState _self;
  final $Res Function(_AppbuilderState) _then;

/// Create a copy of AppbuilderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCanvasLoading = null,Object? showPreview = null,Object? theJson = null,Object? selectedWidgetId = freezed,Object? selectedWidgetProperties = null,}) {
  return _then(_AppbuilderState(
isCanvasLoading: null == isCanvasLoading ? _self.isCanvasLoading : isCanvasLoading // ignore: cast_nullable_to_non_nullable
as bool,showPreview: null == showPreview ? _self.showPreview : showPreview // ignore: cast_nullable_to_non_nullable
as bool,theJson: null == theJson ? _self._theJson : theJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,selectedWidgetId: freezed == selectedWidgetId ? _self.selectedWidgetId : selectedWidgetId // ignore: cast_nullable_to_non_nullable
as String?,selectedWidgetProperties: null == selectedWidgetProperties ? _self._selectedWidgetProperties : selectedWidgetProperties // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
