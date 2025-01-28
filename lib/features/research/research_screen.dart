import 'package:flutter/material.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class ResearchScreen extends StatelessWidget {
  const ResearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/research',
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Coming soon',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              Icon(
                Icons.hourglass_empty,
                size: 100,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 20),
              Text(
                'Stay tuned!',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
