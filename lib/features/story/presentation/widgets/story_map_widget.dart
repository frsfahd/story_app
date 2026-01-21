import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/util/map_util.dart';

class StoryMapWidget extends StatefulWidget {
  final double lat;
  final double lon;
  const StoryMapWidget({super.key, required this.lat, required this.lon});

  @override
  State<StoryMapWidget> createState() => _StoryMapWidgetState();
}

class _StoryMapWidgetState extends State<StoryMapWidget> {
  late LatLng location;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};

  void onTapGoogleMap(LatLng latLng) async {
    final (street, address) = await MapUtil.reverseGeocode(latLng);
    final marker = MapUtil.defineMarker(latLng, street, address);
    setState(() {
      markers.clear();
      markers.add(marker);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  void initState() {
    super.initState();

    location = LatLng(widget.lat, widget.lon);
    final marker = Marker(
      markerId: const MarkerId("story-location"),
      position: location,
      onTap: () {
        mapController.animateCamera(CameraUpdate.newLatLngZoom(location, 18));
      },
    );
    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: GoogleMap(
        markers: markers,

        initialCameraPosition: CameraPosition(target: location, zoom: 18),
        onMapCreated: (controller) async {
          final (street, address) = await MapUtil.reverseGeocode(location);
          final marker = MapUtil.defineMarker(location, street, address);

          setState(() {
            markers.clear();
            markers.add(marker);
            mapController = controller;
          });
        },
        onTap: (LatLng latLng) async {
          onTapGoogleMap(latLng);
        },
      ),
    );
  }
}
