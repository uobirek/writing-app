import 'package:flutter/material.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/',
      child: Center(
        child: Text(
          'Welcome to the Writing App!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
