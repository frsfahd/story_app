// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenericResponse _$GenericResponseFromJson(Map<String, dynamic> json) =>
    _GenericResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GenericResponseToJson(_GenericResponse instance) =>
    <String, dynamic>{'error': instance.error, 'message': instance.message};
