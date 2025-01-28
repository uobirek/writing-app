import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/l10n/app_localizations.dart';

import 'package:writing_app/widgets/settings_dialog.dart';

import 'base_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome Text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: localizations!.hiWelcomeTo,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextSpan(
                  text: ' ${localizations.fantasies}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Text(
            localizations.perfectOrganizationTool,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              context.go('/register');
            },
            child: Text(localizations.getStartedNow),
          ),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.alreadyAUser,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: Text(localizations.login),
              ),
            ],
          ),

          // Language Dropdown
          LanguageDropDown(),
        ],
      ),
    );
  }
}
