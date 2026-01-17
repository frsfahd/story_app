import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_response.g.dart';
part 'generic_response.freezed.dart';

@freezed
abstract class GenericResponse with _$GenericResponse {
  const factory GenericResponse({
    required bool error,
    required String message,
  }) = _GenericResponse;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
}
