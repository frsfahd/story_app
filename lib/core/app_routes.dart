import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/features/auth/presentation/login_screen.dart';
import 'package:story_app/features/auth/presentation/register_screen.dart';
import 'package:story_app/features/story/presentation/detail_screen.dart';
import 'package:story_app/features/story/presentation/new_story_screen.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/screens/home_screen.dart';
import 'package:story_app/screens/splash_screen.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

class AppRoutes {
  final AuthProvider _authProvider;

  AppRoutes(this._authProvider);

  static const String splash = "splash";
  final String _splashRoute = "/splash";

  static const String registration = "registration";
  final String _registrationRoute = "/register";

  static const String login = "login";
  final String _loginRoute = "/login";

  static const String home = "home";
  final String _homeRoute = "/";

  static const String storyDetails = "storyDetails";
  final String _storyDetailsRoute = "stories/:sid";
  // static const String story = "/stories";

  static const String newStory = "newStory";
  final String _newStoryRoute = "/new-story";

  late final List<String> _protectedRoutes = [
    _homeRoute,
    _storyDetailsRoute,
    _newStoryRoute,
  ];
  late final List<String> _authRoutes = [_loginRoute, _registrationRoute];

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _authProvider,
    initialLocation: _splashRoute,
    observers: [routeObserver],
    redirect: (context, state) async {
      final isLoggedIn = await _authProvider.isAuthenticated();

      // If not logged in and trying to access protected routes
      if (!isLoggedIn && _protectedRoutes.contains(state.matchedLocation)) {
        return _loginRoute;
      }

      // If logged in and on auth pages, go to home
      if (isLoggedIn && _authRoutes.contains(state.matchedLocation)) {
        return _homeRoute;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: _splashRoute,
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: _registrationRoute,
        name: registration,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: _loginRoute,
        name: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: _homeRoute,
        name: home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: _storyDetailsRoute,
            name: storyDetails,
            builder: (context, state) =>
                DetailScreen(sid: state.pathParameters['sid']!),
          ),
        ],
      ),
      GoRoute(
        path: _newStoryRoute,
        name: newStory,
        builder: (context, state) => const NewStoryScreen(),
      ),
      // GoRoute(
      //   path: story,
      //   name: "story",
      //   builder: (context, state) => const Placeholder(),
      // ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found: ${state.uri.path}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.goNamed(home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
