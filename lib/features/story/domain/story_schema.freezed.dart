// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorySchema {

 String get description; List<int> get photo; String get filename; double? get lat; double? get lon;
/// Create a copy of StorySchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorySchemaCopyWith<StorySchema> get copyWith => _$StorySchemaCopyWithImpl<StorySchema>(this as StorySchema, _$identity);

  /// Serializes this StorySchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorySchema&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.photo, photo)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,const DeepCollectionEquality().hash(photo),filename,lat,lon);

@override
String toString() {
  return 'StorySchema(description: $description, photo: $photo, filename: $filename, lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class $StorySchemaCopyWith<$Res>  {
  factory $StorySchemaCopyWith(StorySchema value, $Res Function(StorySchema) _then) = _$StorySchemaCopyWithImpl;
@useResult
$Res call({
 String description, List<int> photo, String filename, double? lat, double? lon
});




}
/// @nodoc
class _$StorySchemaCopyWithImpl<$Res>
    implements $StorySchemaCopyWith<$Res> {
  _$StorySchemaCopyWithImpl(this._self, this._then);

  final StorySchema _self;
  final $Res Function(StorySchema) _then;

/// Create a copy of StorySchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? photo = null,Object? filename = null,Object? lat = freezed,Object? lon = freezed,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as List<int>,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [StorySchema].
extension StorySchemaPatterns on StorySchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorySchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorySchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorySchema value)  $default,){
final _that = this;
switch (_that) {
case _StorySchema():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorySchema value)?  $default,){
final _that = this;
switch (_that) {
case _StorySchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  List<int> photo,  String filename,  double? lat,  double? lon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorySchema() when $default != null:
return $default(_that.description,_that.photo,_that.filename,_that.lat,_that.lon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  List<int> photo,  String filename,  double? lat,  double? lon)  $default,) {final _that = this;
switch (_that) {
case _StorySchema():
return $default(_that.description,_that.photo,_that.filename,_that.lat,_that.lon);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  List<int> photo,  String filename,  double? lat,  double? lon)?  $default,) {final _that = this;
switch (_that) {
case _StorySchema() when $default != null:
return $default(_that.description,_that.photo,_that.filename,_that.lat,_that.lon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorySchema implements StorySchema {
  const _StorySchema({required this.description, required final  List<int> photo, required this.filename, this.lat, this.lon}): _photo = photo;
  factory _StorySchema.fromJson(Map<String, dynamic> json) => _$StorySchemaFromJson(json);

@override final  String description;
 final  List<int> _photo;
@override List<int> get photo {
  if (_photo is EqualUnmodifiableListView) return _photo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photo);
}

@override final  String filename;
@override final  double? lat;
@override final  double? lon;

/// Create a copy of StorySchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorySchemaCopyWith<_StorySchema> get copyWith => __$StorySchemaCopyWithImpl<_StorySchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorySchemaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorySchema&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._photo, _photo)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,const DeepCollectionEquality().hash(_photo),filename,lat,lon);

@override
String toString() {
  return 'StorySchema(description: $description, photo: $photo, filename: $filename, lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class _$StorySchemaCopyWith<$Res> implements $StorySchemaCopyWith<$Res> {
  factory _$StorySchemaCopyWith(_StorySchema value, $Res Function(_StorySchema) _then) = __$StorySchemaCopyWithImpl;
@override @useResult
$Res call({
 String description, List<int> photo, String filename, double? lat, double? lon
});




}
/// @nodoc
class __$StorySchemaCopyWithImpl<$Res>
    implements _$StorySchemaCopyWith<$Res> {
  __$StorySchemaCopyWithImpl(this._self, this._then);

  final _StorySchema _self;
  final $Res Function(_StorySchema) _then;

/// Create a copy of StorySchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? photo = null,Object? filename = null,Object? lat = freezed,Object? lon = freezed,}) {
  return _then(_StorySchema(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self._photo : photo // ignore: cast_nullable_to_non_nullable
as List<int>,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
