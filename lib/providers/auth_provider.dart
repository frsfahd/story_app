import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/core/base_viewModel.dart';
import 'package:story_app/core/constants.dart';
import 'package:story_app/core/exception_handler.dart';
import 'package:story_app/features/auth/domain/login_schema.dart';
import 'package:story_app/features/auth/domain/register_schema.dart';
import 'package:story_app/features/auth/data/auth_repository.dart';
import 'package:story_app/models/user.dart';

class AuthProvider extends BaseViewModel {
  final AuthRepository _authRepository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthProvider(this._authRepository);

  User? _user;
  User? get user => _user;

  Future<void> login(LoginSchema input) async {
    try {
      setLoading();

      final data = await _authRepository.login(input);

      // save token and set to global request header
      final token = data.loginResult!.token;
      await _secureStorage.write(
        key: AppConstants.accessTokenKey,
        value: token,
      );
      _authRepository.setAuthorizationHeader(token);

      // save user data
      final preferences = await SharedPreferences.getInstance();
      _user = User(
        userId: data.loginResult!.userId,
        name: data.loginResult!.name,
        email: input.email,
      );
      await preferences.setString(AppConstants.userDataKey, _user!.toRawJson());

      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
      throw Exception(errorMsg);
    }
  }

  Future<void> register(RegisterSchema input) async {
    try {
      setLoading();

      await _authRepository.register(input);

      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
      throw Exception(errorMsg);
    }
  }

  Future<void> logout() async {
    try {
      setLoading();

      // remove token from secureStorage and HTTP Header
      await _secureStorage.delete(key: AppConstants.accessTokenKey);
      _authRepository.removeAuthorizationHeader();

      // remove user data from sharedPreferences
      _user = null;
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(AppConstants.userDataKey);

      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: AppConstants.accessTokenKey);
    if (token != null && token.isNotEmpty) {
      _authRepository.setAuthorizationHeader(token);
      try {
        final preferences = await SharedPreferences.getInstance();
        final userData = preferences.getString(AppConstants.userDataKey);
        _user = userData != null ? User.fromRawJson(userData) : null;
      } catch (_) {
        _user = null;
      }
    } else {
      _user = null;
    }
    return _user != null;
  }
}
