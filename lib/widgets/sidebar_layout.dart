import 'package:flutter/material.dart';
import 'package:writing_app/widgets/app_sidebar.dart';

class SidebarLayout extends StatelessWidget {
  final String activeRoute;
  final Widget child;

  const SidebarLayout({
    super.key,
    required this.activeRoute,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          AppSidebar(
            activeRoute: activeRoute,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
