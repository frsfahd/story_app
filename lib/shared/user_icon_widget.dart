import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/flavor_config.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';

class UserIconWidget extends StatelessWidget {
  const UserIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return PopupMenuButton<String>(
      icon: Container(
        decoration: FlavorConfig.instance.flavor == FlavorType.premium
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.amber, width: 2),
              )
            : null,
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            authProvider.user?.name[0].toUpperCase() ?? "U",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onSelected: (value) {
        if (value == 'logout') {
          _handleLogout(context);
        }
      },
      itemBuilder: (BuildContext context) => [
        // PopupMenuItem(
        //   enabled: false,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.secondaryContainer,
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        //     child: Text(
        //       FlavorConfig.instance.values.labelApp,
        //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //         fontWeight: FontWeight.bold,
        //         color: Theme.of(context).colorScheme.onSecondaryContainer,
        //       ),
        //     ),
        //   ),
        // ),
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  FlavorConfig.instance.values.labelApp,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
              const SizedBox.square(dimension: 12),
              Text(
                authProvider.user?.name ?? 'User',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox.square(dimension: 3),
              Text(
                authProvider.user?.email ?? 'User@email.com',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: Colors.grey),
              ),

              const Divider(),
            ],
          ),
        ),

        PopupMenuItem<String>(
          value: 'logout',
          child: Text(
            AppLocalizations.of(context)!.homeLogout,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.homeLogout),
        content: Text(AppLocalizations.of(context)!.homeLogoutConfirmContent),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(AppLocalizations.of(context)!.homeLogoutCancel),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              context.read<AuthProvider>().logout();
            },
            child: Text(AppLocalizations.of(context)!.homeLogout),
          ),
        ],
      ),
    );
  }
}
