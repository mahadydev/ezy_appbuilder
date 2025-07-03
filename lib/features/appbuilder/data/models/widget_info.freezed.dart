// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WidgetInfo {

 String get name; IconData get icon; String get description;
/// Create a copy of WidgetInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetInfoCopyWith<WidgetInfo> get copyWith => _$WidgetInfoCopyWithImpl<WidgetInfo>(this as WidgetInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,icon,description);

@override
String toString() {
  return 'WidgetInfo(name: $name, icon: $icon, description: $description)';
}


}

/// @nodoc
abstract mixin class $WidgetInfoCopyWith<$Res>  {
  factory $WidgetInfoCopyWith(WidgetInfo value, $Res Function(WidgetInfo) _then) = _$WidgetInfoCopyWithImpl;
@useResult
$Res call({
 String name, IconData icon, String description
});




}
/// @nodoc
class _$WidgetInfoCopyWithImpl<$Res>
    implements $WidgetInfoCopyWith<$Res> {
  _$WidgetInfoCopyWithImpl(this._self, this._then);

  final WidgetInfo _self;
  final $Res Function(WidgetInfo) _then;

/// Create a copy of WidgetInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? icon = null,Object? description = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetInfo].
extension WidgetInfoPatterns on WidgetInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetInfo value)  $default,){
final _that = this;
switch (_that) {
case _WidgetInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  IconData icon,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetInfo() when $default != null:
return $default(_that.name,_that.icon,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  IconData icon,  String description)  $default,) {final _that = this;
switch (_that) {
case _WidgetInfo():
return $default(_that.name,_that.icon,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  IconData icon,  String description)?  $default,) {final _that = this;
switch (_that) {
case _WidgetInfo() when $default != null:
return $default(_that.name,_that.icon,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _WidgetInfo implements WidgetInfo {
  const _WidgetInfo({required this.name, required this.icon, required this.description});
  

@override final  String name;
@override final  IconData icon;
@override final  String description;

/// Create a copy of WidgetInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetInfoCopyWith<_WidgetInfo> get copyWith => __$WidgetInfoCopyWithImpl<_WidgetInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,icon,description);

@override
String toString() {
  return 'WidgetInfo(name: $name, icon: $icon, description: $description)';
}


}

/// @nodoc
abstract mixin class _$WidgetInfoCopyWith<$Res> implements $WidgetInfoCopyWith<$Res> {
  factory _$WidgetInfoCopyWith(_WidgetInfo value, $Res Function(_WidgetInfo) _then) = __$WidgetInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, IconData icon, String description
});




}
/// @nodoc
class __$WidgetInfoCopyWithImpl<$Res>
    implements _$WidgetInfoCopyWith<$Res> {
  __$WidgetInfoCopyWithImpl(this._self, this._then);

  final _WidgetInfo _self;
  final $Res Function(_WidgetInfo) _then;

/// Create a copy of WidgetInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? icon = null,Object? description = null,}) {
  return _then(_WidgetInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
