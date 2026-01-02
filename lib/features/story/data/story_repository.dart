import 'package:dio/dio.dart';
import 'package:story_app/core/exception_handler.dart';
import 'package:story_app/features/story/domain/detail_story_response.dart';
import 'package:story_app/features/story/domain/list_story_response.dart';
import 'package:story_app/features/story/domain/story_schema.dart';
import 'package:story_app/services/api_service.dart';

class StoryRepository {
  final ApiService _apiService;
  StoryRepository(this._apiService);

  Future<ListStoryResponse> getAllStories() async {
    try {
      final response = await _apiService.get('/stories');
      final data = response.data as Map<String, dynamic>;

      final result = ListStoryResponse.fromJson(data);
      return result;
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  Future<DetailStoryResponse> getDetailStory(String id) async {
    try {
      final response = await _apiService.get('/stories/$id');
      final data = response.data as Map<String, dynamic>;

      final result = DetailStoryResponse.fromJson(data);
      return result;
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }

  Future<void> addNewStory(StorySchema input) async {
    try {
      final formData = FormData.fromMap({
        'description': input.description,
        if (input.lat != null) 'lat': input.lat,
        if (input.lon != null) 'lon': input.lon,
        'photo': MultipartFile.fromBytes(input.photo, filename: input.filename),
      });
      await _apiService.post(
        '/stories',
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        data: formData,
      );

      return;
    } on DioException catch (e) {
      throw ExceptionHandler.handleDioException(e);
    } catch (e) {
      throw ExceptionHandler.handleGenericException(e);
    }
  }
}
