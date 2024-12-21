import 'package:flutter/material.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class HomeScreen extends StatelessWidget {
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
