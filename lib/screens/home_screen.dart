import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/app_routes.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/story_provider.dart';
import 'package:story_app/shared/flag_icon_widget.dart';
import 'package:story_app/shared/story_card_widget.dart';
import 'package:story_app/shared/user_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStories();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void _loadStories() {
    if (mounted) {
      context.read<StoryProvider>().getAllStories();
    }
  }

  @override
  void didPush() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStories();
    });
  }

  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const FlagIconWidget(),
        title: Text(AppLocalizations.of(context)!.homeTitle),
        actions: [
          // Text(context.read<AuthProvider>().user?.name ?? ''),
          // IconButton(
          //   onPressed: () {
          //     context.read<AuthProvider>().logout();
          //   },
          //   icon: Icon(Icons.logout_rounded),
          // ),
          UserIconWidget(),
        ],
      ),
      body: Consumer<StoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.isError) {
            return Center(
              child: Text(
                'Error: ${provider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.listOfStory == null || provider.listOfStory!.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.homeErrNoStory ??
                    'No stories found',
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.listOfStory!.length,
            itemBuilder: (context, index) {
              final story = provider.listOfStory![index];
              return StoryCard(story: story);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to create story screen
          await context.pushNamed(AppRoutes.newStory);

          final storyProvider = context.read<StoryProvider>();
          if (storyProvider.errorMessage != '') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(storyProvider.errorMessage)),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            storyProvider.clearError();
          }
          if (storyProvider.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(storyProvider.successMessage!)),
                backgroundColor: Colors.green,
              ),
            );
            storyProvider.clearSuccessMessage();
          }
        },
        tooltip: 'Create New Story',
        child: const Icon(Icons.add),
      ),
    );
  }
}
