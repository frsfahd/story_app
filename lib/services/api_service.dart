import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../core/constants.dart';
import '../core/exception_handler.dart';

class ApiService {
  late final Dio _dio;
  final Logger _logger = Logger();

  ApiService() {
    _dio = Dio();
    _initializeDio();
  }

  void _initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('Request: ${options.method} ${options.path}');
          _logger.d('Headers: ${options.headers}');
          if (options.data != null) {
            _logger.d('Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
            'Response: ${response.statusCode} ${response.requestOptions.path}',
          );
          _logger.d('Data: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          _logger.e('Error: ${error.message}');
          _logger.e('Response: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }

  // Generic request methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  // Add authorization header
  void setAuthorizationHeader(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Remove authorization header
  void removeAuthorizationHeader() {
    _dio.options.headers.remove('Authorization');
  }

  // void setMultipartForm() {
  //   _dio.options.headers.remove('Content-Type');
  //   _dio.options.headers['Content-Type'] = 'multipart/form-data';
  // }

  // void setApplicationJson() {
  //   _dio.options.headers.remove('Content-Type');
  //   _dio.options.headers['Content-Type'] = 'application/json';
  // }
}
