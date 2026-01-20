import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/map_provider.dart';
import 'package:story_app/util/map_util.dart';

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

  @override
  bool get wantKeepAlive => true;

  void onTapGoogleMap(LatLng latLng) async {
    final (street, address) = await MapUtil.reverseGeocode(latLng);
    final marker = MapUtil.defineMarker(latLng, street, address);
    if (mounted) {
      context.read<MapProvider>().address = address;
    }

    setState(() {
      markers.clear();
      markers.add(marker);
    });

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
      MapUtil.reverseGeocode(location!);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
