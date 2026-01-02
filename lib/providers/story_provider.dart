import 'package:story_app/core/base_viewModel.dart';
import 'package:story_app/core/exception_handler.dart';
import 'package:story_app/features/story/data/story_repository.dart';
import 'package:story_app/features/story/domain/story_schema.dart';
import 'package:story_app/models/story.dart';

class StoryProvider extends BaseViewModel {
  final StoryRepository _storyRepository;
  StoryProvider(this._storyRepository);

  Story? _story;
  Story? get story => _story;

  List<Story>? _listOfStory;
  List<Story>? get listOfStory => _listOfStory;

  String? _successMessage;
  String? get successMessage => _successMessage;

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }

  Future<void> getAllStories() async {
    try {
      setLoading();

      final data = await _storyRepository.getAllStories();

      _listOfStory = data.listStory;

      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
      throw Exception(errorMsg);
    }
  }

  Future<void> getDetailStory(String id) async {
    try {
      setLoading();

      final data = await _storyRepository.getDetailStory(id);

      _story = data.story;
      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
      throw Exception(errorMsg);
    }
  }

  Future<void> addNewStory(StorySchema input) async {
    try {
      setLoading();

      await _storyRepository.addNewStory(input);

      _successMessage = 'Story uploaded successfully!';
      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
      // throw Exception(errorMsg);
    }
  }
}
