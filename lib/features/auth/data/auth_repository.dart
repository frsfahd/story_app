import 'package:dio/dio.dart';
import 'package:story_app/core/exception_handler.dart';
import 'package:story_app/features/auth/domain/login_response.dart';
import 'package:story_app/features/auth/domain/login_schema.dart';
import 'package:story_app/features/auth/domain/register_schema.dart';
import 'package:story_app/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<LoginResponse> login(LoginSchema input) async {
    try {
      final response = await _apiService.post(
        '/login',
        data: {'email': input.email, 'password': input.password},
      );
      final data = response.data as Map<String, dynamic>;

      final result = LoginResponse.fromJson(data);
      return result;
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  Future<void> register(RegisterSchema input) async {
    try {
      await _apiService.post(
        '/register',
        data: {
          'name': input.name,
          'email': input.email,
          'password': input.password,
        },
      );

      return;
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  void setAuthorizationHeader(String token) =>
      _apiService.setAuthorizationHeader(token);

  void removeAuthorizationHeader() => _apiService.removeAuthorizationHeader();
}
