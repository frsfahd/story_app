// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListStoryResponse {

 bool get error; String get message; List<Story> get listStory;
/// Create a copy of ListStoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListStoryResponseCopyWith<ListStoryResponse> get copyWith => _$ListStoryResponseCopyWithImpl<ListStoryResponse>(this as ListStoryResponse, _$identity);

  /// Serializes this ListStoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListStoryResponse&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.listStory, listStory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message,const DeepCollectionEquality().hash(listStory));

@override
String toString() {
  return 'ListStoryResponse(error: $error, message: $message, listStory: $listStory)';
}


}

/// @nodoc
abstract mixin class $ListStoryResponseCopyWith<$Res>  {
  factory $ListStoryResponseCopyWith(ListStoryResponse value, $Res Function(ListStoryResponse) _then) = _$ListStoryResponseCopyWithImpl;
@useResult
$Res call({
 bool error, String message, List<Story> listStory
});




}
/// @nodoc
class _$ListStoryResponseCopyWithImpl<$Res>
    implements $ListStoryResponseCopyWith<$Res> {
  _$ListStoryResponseCopyWithImpl(this._self, this._then);

  final ListStoryResponse _self;
  final $Res Function(ListStoryResponse) _then;

/// Create a copy of ListStoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? message = null,Object? listStory = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,listStory: null == listStory ? _self.listStory : listStory // ignore: cast_nullable_to_non_nullable
as List<Story>,
  ));
}

}


/// Adds pattern-matching-related methods to [ListStoryResponse].
extension ListStoryResponsePatterns on ListStoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListStoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListStoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListStoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _ListStoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListStoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ListStoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool error,  String message,  List<Story> listStory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListStoryResponse() when $default != null:
return $default(_that.error,_that.message,_that.listStory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool error,  String message,  List<Story> listStory)  $default,) {final _that = this;
switch (_that) {
case _ListStoryResponse():
return $default(_that.error,_that.message,_that.listStory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool error,  String message,  List<Story> listStory)?  $default,) {final _that = this;
switch (_that) {
case _ListStoryResponse() when $default != null:
return $default(_that.error,_that.message,_that.listStory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListStoryResponse implements ListStoryResponse {
  const _ListStoryResponse({required this.error, required this.message, required final  List<Story> listStory}): _listStory = listStory;
  factory _ListStoryResponse.fromJson(Map<String, dynamic> json) => _$ListStoryResponseFromJson(json);

@override final  bool error;
@override final  String message;
 final  List<Story> _listStory;
@override List<Story> get listStory {
  if (_listStory is EqualUnmodifiableListView) return _listStory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listStory);
}


/// Create a copy of ListStoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListStoryResponseCopyWith<_ListStoryResponse> get copyWith => __$ListStoryResponseCopyWithImpl<_ListStoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListStoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListStoryResponse&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._listStory, _listStory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message,const DeepCollectionEquality().hash(_listStory));

@override
String toString() {
  return 'ListStoryResponse(error: $error, message: $message, listStory: $listStory)';
}


}

/// @nodoc
abstract mixin class _$ListStoryResponseCopyWith<$Res> implements $ListStoryResponseCopyWith<$Res> {
  factory _$ListStoryResponseCopyWith(_ListStoryResponse value, $Res Function(_ListStoryResponse) _then) = __$ListStoryResponseCopyWithImpl;
@override @useResult
$Res call({
 bool error, String message, List<Story> listStory
});




}
/// @nodoc
class __$ListStoryResponseCopyWithImpl<$Res>
    implements _$ListStoryResponseCopyWith<$Res> {
  __$ListStoryResponseCopyWithImpl(this._self, this._then);

  final _ListStoryResponse _self;
  final $Res Function(_ListStoryResponse) _then;

/// Create a copy of ListStoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? message = null,Object? listStory = null,}) {
  return _then(_ListStoryResponse(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,listStory: null == listStory ? _self._listStory : listStory // ignore: cast_nullable_to_non_nullable
as List<Story>,
  ));
}


}

// dart format on
