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
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStories();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (context.read<StoryProvider>().pageItems != null) {
          _loadStories();
        }
      }
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
    scrollController.dispose();
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
            controller: scrollController,
            itemCount:
                provider.listOfStory!.length +
                (provider.pageItems != null ? 1 : 0),
            itemBuilder: (context, index) {
              // display loading indicator at the end of list
              if (index == provider.listOfStory!.length &&
                  provider.pageItems != null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final story = provider.listOfStory![index];
              return StoryCard(story: story);
            },
          );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              final position = scrollController.position.minScrollExtent;
              scrollController.animateTo(
                position,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 300),
              );
            },
            heroTag: null,
            child: const Icon(Icons.arrow_upward_outlined),
          ),
          SizedBox.square(dimension: 10),
          FloatingActionButton.extended(
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
            heroTag: null,
            label: Text(AppLocalizations.of(context)!.homeNewStoryButton),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
