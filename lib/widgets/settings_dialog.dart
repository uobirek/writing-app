import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/locale_provider.dart';
import 'package:writing_app/theme_cubit.dart';
import 'package:writing_app/utils/scaffold_messenger.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return AlertDialog(
      title: Text('Settings', style: Theme.of(context).textTheme.labelLarge),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Language Dropdown
          Row(
            children: [
              Text(
                'Language',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(width: 16),
              LanguageDropDown(),
            ],
          ),
          const SizedBox(height: 20),
          // Dark Mode Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeCubit.toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // "Go to Projects" Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              context.go('/projects'); // Navigate to projects
            },
            icon: const Icon(Icons.apps),
            label: const Text('Go to Projects'),
          ),
          const SizedBox(height: 20),
          // Logout Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _logout(context); // Perform logout action
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            localizations!.cancel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      context.go('/login'); // Navigate to login screen after logging out
    } catch (err) {
      showMessage(context, 'Logout failed');
    }
  }
}

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: context.read<LocaleProvider>().locale.languageCode,
      onChanged: (newLanguageCode) {
        if (newLanguageCode != null) {
          context.read<LocaleProvider>().setLocale(Locale(newLanguageCode));
        }
      },
      items: [
        DropdownMenuItem(
          value: 'en',
          child: Text(
            'English',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        DropdownMenuItem(
          value: 'pl',
          child: Text(
            'Polski',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        DropdownMenuItem(
          value: 'es',
          child: Text(
            'Español',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
