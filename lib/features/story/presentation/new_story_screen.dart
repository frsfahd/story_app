import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/enums.dart';
import 'package:story_app/features/story/domain/story_schema.dart';
import 'package:story_app/features/story/presentation/widgets/map_input_sheet.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/img_provider.dart';
import 'package:story_app/providers/map_provider.dart';
import 'package:story_app/providers/story_provider.dart';

class NewStoryScreen extends StatefulWidget {
  const NewStoryScreen({super.key});

  @override
  State<NewStoryScreen> createState() => _NewStoryScreenState();
}

class _NewStoryScreenState extends State<NewStoryScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late MapProvider _mapProvider;
  late VoidCallback _mapListener;
  bool _bottomSheetShown = false;

  @override
  void initState() {
    super.initState();
    context.read<ImgProvider>().resetImage();

    _mapProvider = context.read<MapProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapProvider.clearLocation();
      _addressController.text = _mapProvider.address ?? '';
    });

    _mapListener = () {
      if (!mounted) return;
      final providerAddress = _mapProvider.address ?? '';
      if (_addressController.text != providerAddress) {
        _addressController.text = providerAddress;
      }
      if (_mapProvider.latLng != null && !_bottomSheetShown) {
        _bottomSheetShown = true;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) => MapInputSheet(),
        ).then((_) {
          if (mounted) {
            _bottomSheetShown = false;
          }
        });
      }
    };

    _mapProvider.addListener(_mapListener);
  }

  @override
  void dispose() {
    _mapProvider.removeListener(_mapListener);
    _descriptionController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  Future<void> _pickImageFromCamera() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;
    final ImagePicker picker = ImagePicker();
    final provider = context.read<ImgProvider>();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();
    final provider = context.read<ImgProvider>();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<ImgProvider>().imagePath;
    return kIsWeb
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imagePath.toString(), fit: BoxFit.contain),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(File(imagePath.toString()), fit: BoxFit.contain),
          );
  }

  Future<void> _uploadStory() async {
    final imgProvider = context.read<ImgProvider>();
    final storyProvider = context.read<StoryProvider>();

    final imagePath = imgProvider.imagePath;
    final imageFile = imgProvider.imageFile;
    if (imagePath == null || imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(AppLocalizations.of(context)!.newStoryErrEmptyPic),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    }

    if (_descriptionController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(AppLocalizations.of(context)!.newStoryErrEmptyDesc),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    LatLng? location;
    if (mounted) {
      location = context.read<MapProvider>().latLng;
    }

    final newBytes = await imgProvider.compressImage(bytes);
    final StorySchema input = StorySchema(
      description: _descriptionController.text,
      photo: newBytes,
      filename: fileName,
      lat: location?.latitude,
      lon: location?.longitude,
    );

    await storyProvider.addNewStory(input);
    if (mounted) {
      _mapProvider.clearLocation();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.newStoryTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Preview Container
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: context.watch<ImgProvider>().imagePath == null
                  ? Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 80,
                        color: Colors.grey[500],
                      ),
                    )
                  : _showImage(),
            ),
            const SizedBox(height: 16),

            // Camera and Gallery Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickImageFromCamera,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.newStoryCameraButton,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.newStoryGalleryButton,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Description Text Field
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.newStoryDescLabel,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.newStoryLocationHint,
                suffixIcon:
                    context.watch<MapProvider>().state == ViewState.loading
                    ? const CircularProgressIndicator()
                    : IconButton(
                        onPressed: () async {
                          if (_addressController.text != "") {
                            await context.read<MapProvider>().setLocation(
                              _addressController.text,
                            );
                          }
                        },
                        icon: Icon(Icons.search_rounded),
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Upload Button
            ElevatedButton(
              onPressed: _uploadStory,
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: context.watch<StoryProvider>().state == ViewState.loading
                  ? const CircularProgressIndicator()
                  : Text(
                      AppLocalizations.of(context)!.newStoryButton,
                      // style: Theme.of(context).textTheme.titleMedium,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
