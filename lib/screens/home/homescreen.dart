import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Writing App!',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
