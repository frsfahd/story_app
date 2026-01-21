import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryImgWidget extends StatelessWidget {
  final String id;
  final String photoUrl;
  const StoryImgWidget({super.key, required this.id, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: CachedNetworkImage(
        imageUrl: photoUrl,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, size: 100),
      ),
    );
  }
}
