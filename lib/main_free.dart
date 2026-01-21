import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/app_routes.dart';
import 'package:story_app/core/app_theme.dart';
import 'package:story_app/core/flavor_config.dart';
import 'package:story_app/features/auth/data/auth_repository.dart';
import 'package:story_app/features/story/data/story_repository.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/localization_provider.dart';
import 'package:story_app/providers/map_provider.dart';
import 'package:story_app/providers/story_provider.dart';
import 'package:story_app/providers/img_provider.dart';
import 'package:story_app/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: FlavorType.free,
    values: const FlavorValues(labelApp: "Free"),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        Provider(
          create: (context) => AuthRepository(context.read<ApiService>()),
        ),
        Provider(
          create: (context) => StoryRepository(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryProvider(context.read<StoryRepository>()),
        ),
        ChangeNotifierProvider(create: (_) => ImgProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: Builder(
        builder: (context) {
          final appRoutes = AppRoutes(context.read<AuthProvider>());
          final locale = context.watch<LocalizationProvider>().locale;

          return MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            routerConfig: appRoutes.router,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            title: 'Story App',
          );
        },
      ),
    );
  }
}
