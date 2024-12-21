import 'package:flutter/material.dart';
import 'package:writing_app/widgets/app_sidebar.dart';

class SidebarLayout extends StatelessWidget {
  final String activeRoute;
  final Widget child;

  const SidebarLayout({
    Key? key,
    required this.activeRoute,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Ensure theme consistency
      body: Row(
        children: [
          AppSidebar(
            activeRoute:
                activeRoute, // Pass activeRoute for highlighting sidebar item
          ),
          Expanded(
            child:
                child, // Child widget is passed here, where content is displayed
          ),
        ],
      ),
    );
  }
}
