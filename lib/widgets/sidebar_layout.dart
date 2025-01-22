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
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Keep this as it is for preventing screen resize when keyboard appears
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return isMobile
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
                );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _getActiveIndex(),
      onTap: (index) {
        _handleNavigation(context, index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.home, color: colorScheme.secondary),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.note_sharp, color: colorScheme.secondary),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.apps, color: colorScheme.secondary),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.edit, color: colorScheme.secondary),
          label: 'Writing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.search, color: colorScheme.secondary),
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
        return 3;
      case '/projects':
        return 2;
      case '/research':
        return 4;
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
        context.go('/projects');
        break;
      case 3:
        context.go('/writing');
        break;
      case 4:
        context.go('/research');
        break;
    }
  }
}
