import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/story_provider.dart';

class DetailScreen extends StatelessWidget {
  final String sid;
  const DetailScreen({super.key, required this.sid});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StoryProvider>();
    // Find the story with matching sid
    final story = provider.listOfStory?.firstWhere(
      (s) => s.id == sid,
      orElse: () => throw Exception('Story not found'),
    );

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
            Hero(
              tag: 'story-${story.id}',
              child: CachedNetworkImage(
                imageUrl: story.photoUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 100),
              ),
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
                          story.name[0].toUpperCase(),
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
                              story.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.detailDate(story.createdAt, story.createdAt),
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // if (story.lat != null && story.lon != null) ...[
                  //   const SizedBox(height: 16),
                  //   Row(
                  //     children: [
                  //       Icon(Icons.location_on, color: Colors.red[400]),
                  //       const SizedBox(width: 8),
                  //       Text(
                  //         'Location: ${story.lat?.toStringAsFixed(4)}, ${story.lon?.toStringAsFixed(4)}',
                  //         style: Theme.of(context).textTheme.labelMedium
                  //             ?.copyWith(color: Colors.grey[700]),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                  const SizedBox(height: 16),
                  Divider(color: Theme.of(context).secondaryHeaderColor),
                  const SizedBox(height: 16),
                  Text(
                    story.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),

                  // Location Info (if available)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
