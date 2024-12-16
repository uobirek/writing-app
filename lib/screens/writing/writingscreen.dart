import 'package:flutter/material.dart';
import 'package:writing_app/utils/theme.dart';
import 'package:writing_app/widgets/sidebar.dart';

class WritingScreen extends StatelessWidget {
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
