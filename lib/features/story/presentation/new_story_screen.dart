import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/enums.dart';
import 'package:story_app/features/story/domain/story_schema.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/img_provider.dart';
import 'package:story_app/providers/story_provider.dart';

class NewStoryScreen extends StatefulWidget {
  const NewStoryScreen({super.key});

  @override
  State<NewStoryScreen> createState() => _NewStoryScreenState();
}

class _NewStoryScreenState extends State<NewStoryScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<ImgProvider>().resetImage();
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
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

    final newBytes = await imgProvider.compressImage(bytes);
    final StorySchema input = StorySchema(
      description: _descriptionController.text,
      photo: newBytes,
      filename: fileName,
    );

    await storyProvider.addNewStory(input);
    if (mounted) context.pop();
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
