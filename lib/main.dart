import 'package:flutter/material.dart';
import 'package:writing_app/utils/router.dart';
import 'package:writing_app/utils/theme.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      title: 'Writing App',
      routerConfig: AppRouter.router, // Use the GoRouter configuration
    );
  }
}
