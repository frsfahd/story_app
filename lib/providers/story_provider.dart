import 'package:story_app/core/base_viewModel.dart';
import 'package:story_app/core/exception_handler.dart';
import 'package:story_app/features/story/data/story_repository.dart';
import 'package:story_app/features/story/domain/story_schema.dart';
import 'package:story_app/models/story.dart';

class StoryProvider extends BaseViewModel {
  final StoryRepository _storyRepository;
  StoryProvider(this._storyRepository);

  int? _pageItems = 1;
  int? get pageItems => _pageItems;
  int _sizeItems = 3;

  // Prevent concurrent fetches and duplicated items
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  final Set<String> _storyIds = {};

  Story? _story;
  Story? get story => _story;

  final List<Story> _listOfStory = [];
  List<Story>? get listOfStory => _listOfStory;

  String? _successMessage;
  String? get successMessage => _successMessage;

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }

  void resetStories() {
    _listOfStory.clear();
    _storyIds.clear();
    _pageItems = 1;
    _isFetching = false;
    _successMessage = null;
    clearError();
    notifyListeners();
  }

  Future<void> getAllStories() async {
    try {
      if (_pageItems == null || _isFetching) {
        return;
      }

      if (_pageItems == 1) {
        setLoading();
      }

      _isFetching = true;

      final data = await _storyRepository.getAllStories(
        page: _pageItems,
        size: _sizeItems,
      );

      // Deduplicate by story id to avoid repeated heroes
      final newStories = data.listStory
          .where((s) => _storyIds.add(s.id))
          .toList(growable: false);

      _listOfStory.addAll(newStories);
      if (data.listStory.length < _sizeItems) {
        _pageItems = null;
      } else {
        _pageItems = _pageItems! + 1;
      }
      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
      throw Exception(errorMsg);
    } finally {
      _isFetching = false;
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
