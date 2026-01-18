import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/providers/story_provider.dart';

class DetailScreen extends StatefulWidget {
  final String sid;
  const DetailScreen({super.key, required this.sid});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late LatLng location;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  late Story? story;
  geo.Placemark? placemark;

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
      infoWindow: InfoWindow(title: street, snippet: address),
    );

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
  void initState() {
    super.initState();

    final provider = context.read<StoryProvider>();
    // Find the story with matching sid
    story = provider.listOfStory?.firstWhere(
      (s) => s.id == widget.sid,
      orElse: () => throw Exception('Story not found'),
    );

    if (story!.lat != null && story!.lon != null) {
      location = LatLng(story!.lat!, story!.lon!);
      final marker = Marker(
        markerId: const MarkerId("story-location"),
        position: location,
        onTap: () {
          mapController.animateCamera(CameraUpdate.newLatLngZoom(location, 18));
        },
      );
      markers.add(marker);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (story == null) {
      return const Center(child: Text('Story not found'));
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.detailTitle)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Story Image
            CachedNetworkImage(
              imageUrl: story!.photoUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 100),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author Name
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          story!.name[0].toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story!.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.detailDate(story!.createdAt, story!.createdAt),
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Theme.of(context).secondaryHeaderColor),
                  const SizedBox(height: 16),
                  Text(
                    story!.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),

                  // Location Info (if available)
                  if (story!.lat != null && story!.lon != null) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: GoogleMap(
                        markers: markers,

                        initialCameraPosition: CameraPosition(
                          target: location,
                          zoom: 18,
                        ),
                        onMapCreated: (controller) async {
                          await _setMarkerWithReverseGeocode(location);

                          setState(() {
                            mapController = controller;
                          });
                        },
                        onTap: (LatLng latLng) async {
                          onTapGoogleMap(latLng);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
