import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_screen.dart'; // Import BaseScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome Text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hi! Welcome to',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextSpan(
                  text: ' fantasies',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Text(
            'Perfect organization tool for writing, worldbuilding, and outlining',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: const Text('Get started now'),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already a User?',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
