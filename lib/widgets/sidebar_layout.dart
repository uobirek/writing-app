import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isMobile
          ? Column(
              children: [
                Expanded(child: child),
                _buildBottomNavigationBar(context),
              ],
            )
          : Row(
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getActiveIndex(),
      onTap: (index) {
        _handleNavigation(context, index);
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.notes_outlined),
          label: 'Notes',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined),
          label: 'Writing',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Research',
        ),
      ],
    );
  }

  int _getActiveIndex() {
    switch (activeRoute) {
      case '/notes':
        return 1;
      case '/writing':
        return 2;
      case '/research':
        return 3;
      default:
        return 0;
    }
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/notes');
        break;
      case 2:
        context.go('/writing');
        break;
      case 3:
        context.go('/research');
        break;
    }
  }
}
