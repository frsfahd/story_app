import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtil {
  static bool get _geocodingSupported {
    // Geocoding plugin supports mobile (Android/iOS) and possibly macOS.
    // Avoid calling on web or Linux/Windows where implementation may be missing.
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  static Future<(String, String)> reverseGeocode(LatLng latLng) async {
    if (_geocodingSupported) {
      try {
        final info = await geo.placemarkFromCoordinates(
          latLng.latitude,
          latLng.longitude,
        );
        final place = info.isNotEmpty ? info[0] : null;

        final street =
            place?.street ?? '${latLng.latitude}, ${latLng.longitude}';
        final address = place != null
            ? '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}'
            : '${latLng.latitude}, ${latLng.longitude}';

        return (street, address);
      } catch (_) {}
    }

    final coordLabel = '${latLng.latitude}, ${latLng.longitude}';
    return (coordLabel, coordLabel);
  }

  static Marker defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("story-location"),
      position: latLng,
      infoWindow: InfoWindow(title: street, snippet: address),
    );

    return marker;
  }
}
