import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/localization.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/localization_provider.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(Icons.flag),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            onTap: () {
              context.read<LocalizationProvider>().setLocale(locale);
            },
          );
        }).toList(),

        onChanged: (_) {},
      ),
    );
  }
}
