import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/widgets/app_sidebar.dart';
import 'package:writing_app/widgets/settings_dialog.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({
    super.key,
    required this.activeRoute,
    required this.child,
  });
  final String activeRoute;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _getActiveIndex(),
      onTap: (index) {
        _handleNavigation(context, index);
      },
      selectedItemColor: colorScheme.secondary,
      unselectedItemColor: colorScheme.secondary,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.home, color: colorScheme.onSecondary),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.note_sharp, color: colorScheme.onSecondary),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.settings, color: colorScheme.onSecondary),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.edit, color: colorScheme.onSecondary),
          label: 'Writing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined, color: colorScheme.secondary),
          activeIcon: Icon(Icons.search, color: colorScheme.onSecondary),
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
      case '/settings':
        return 2;
      default:
        return 0;
    }
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/notes');
      case 2:
        showDialog<void>(
          context: context,
          builder: (context) => const SettingsDialog(),
        );
      case 3:
        context.go('/writing');
      case 4:
        context.go('/research');
    }
  }
}
