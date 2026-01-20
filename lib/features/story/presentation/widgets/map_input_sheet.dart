import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/map_provider.dart';

class MapInputSheet extends StatefulWidget {
  const MapInputSheet({super.key});

  @override
  State<MapInputSheet> createState() => _MapInputSheetState();
}

class _MapInputSheetState extends State<MapInputSheet>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _addressController = TextEditingController();

  late LatLng? location;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  geo.Placemark? placemark;

  @override
  bool get wantKeepAlive => true;

  bool get _geocodingSupported {
    // Geocoding plugin supports mobile (Android/iOS) and possibly macOS.
    // Avoid calling on web or Linux/Windows where implementation may be missing.
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  Future<void> _setMarkerWithReverseGeocode(LatLng latLng) async {
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

        setState(() {
          placemark = place;
        });
        defineMarker(latLng, street, address);
        return;
      } catch (_) {}
    }

    final coordLabel = '${latLng.latitude}, ${latLng.longitude}';
    defineMarker(latLng, coordLabel, coordLabel);
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("story-location"),
      position: latLng,
      // infoWindow: InfoWindow(title: street, snippet: address),
    );
    if (mounted) {
      context.read<MapProvider>().address = address;
    }

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onTapGoogleMap(LatLng latLng) async {
    await _setMarkerWithReverseGeocode(latLng);
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
  }

  @override
  void initState() {
    super.initState();

    final provider = context.read<MapProvider>();
    location = provider.latLng;

    if (location != null) {
      final marker = Marker(
        markerId: const MarkerId("story-location"),
        position: location!,
        onTap: () {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(location!, 18),
          );
        },
      );
      markers.add(marker);
      // Pre-load the address on initialization
      _setMarkerWithReverseGeocode(location!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.mapInputSheetTitle),
            const SizedBox(height: 16),
            Consumer<MapProvider>(
              builder: (context, provider, _) {
                return Text(provider.address ?? "address not found");
              },
            ),
            const SizedBox(height: 16),
            if (location != null)
              SizedBox(
                width: double.infinity,
                height: 250,
                child: GoogleMap(
                  key: const ValueKey('story-location-map'),
                  markers: markers,

                  initialCameraPosition: CameraPosition(
                    target: location!,
                    zoom: 18,
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  onTap: (LatLng latLng) async {
                    onTapGoogleMap(latLng);
                  },
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<MapProvider>().clearLocation();
                    context.pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.mapInputSheetCancelBtn,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final provider = context.read<MapProvider>();
                    if (provider.address != "" || provider.address != null) {
                      await provider.setLocation(provider.address!);
                    }
                    context.pop();
                  },
                  child: Text(AppLocalizations.of(context)!.mapInputSheetOkBtn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
