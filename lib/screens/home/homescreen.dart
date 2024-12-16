import 'package:flutter/material.dart';
import 'package:writing_app/utils/theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Writing App!',
        style: AppTextStyles.dashboardTitle,
      ),
    );
  }
}
