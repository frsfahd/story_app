import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';

class UserIconWidget extends StatelessWidget {
  const UserIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          authProvider.user?.name[0].toUpperCase() ?? "U",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      onSelected: (value) {
        if (value == 'logout') {
          _handleLogout(context);
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
