import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/core/base_viewModel.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/core/exception_handler.dart';

class MapProvider extends BaseViewModel {
  String? _address;
  set address(String value) {
    _address = value;
    notifyListeners();
  }

  String? get address => _address;

  LatLng? _latLng;
  LatLng? get latLng => _latLng;

  void clearLocation() {
    _latLng = null;
    _address = null;
    notifyListeners();
  }

  Future<void> setLocation(String address) async {
    try {
      _address = address;
      setLoading();
      final locations = await geo.locationFromAddress(address);
      final location = locations[0];

      _latLng = LatLng(location.latitude, location.longitude);
      setSuccess();
    } catch (e) {
      final errorMsg = ExceptionHandler.getErrorMessage(e);
      setError(errorMsg);
    }
  }
}
