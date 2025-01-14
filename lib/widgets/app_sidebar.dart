import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppSidebar extends StatefulWidget {
  final String activeRoute;

  const AppSidebar({
    super.key,
    required this.activeRoute,
  });

  @override
  _AppSidebarState createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _isExpanded = true;
  String _hoveredRoute = ''; // Tracks the currently hovered route

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onHover(String route) {
    setState(() {
      _hoveredRoute = route;
    });
  }

  void _onExitHover() {
    setState(() {
      _hoveredRoute = '';
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      context.go('/login'); // Navigate to the login screen after logging out
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isExpanded ? 250 : 100, // Adjust width based on state
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 30,
            spreadRadius: 6,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isExpanded) const Icon(Icons.circle_outlined, size: 25),
              if (_isExpanded) const SizedBox(width: 20),
              if (_isExpanded)
                Text("Projekt RL",
                    style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  _isExpanded
                      ? Icons.keyboard_double_arrow_left_rounded
                      : Icons.keyboard_double_arrow_right_rounded,
                  size: 25,
                ),
                onPressed: _toggleSidebar,
              ),
            ],
          ),
          const SizedBox(height: 150),
          _buildSidebarItem(
            icon: Icons.home_outlined,
            label: 'Home',
            route: '/',
            isActive: widget.activeRoute == '/',
          ),
          _buildSidebarItem(
            icon: Icons.notes_outlined,
            label: 'Notes',
            route: '/notes',
            isActive: widget.activeRoute == '/notes',
          ),
          _buildSidebarItem(
            icon: Icons.edit_outlined,
            label: 'Writing',
            route: '/writing',
            isActive: widget.activeRoute == '/writing',
          ),
          _buildSidebarItem(
            icon: Icons.search,
            label: 'Research',
            route: '/research',
            isActive: widget.activeRoute == '/research',
          ),
          const Spacer(), // Push logout button to the bottom
          _buildLogoutItem(),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
  }) {
    final isHovered = _hoveredRoute == route;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover(route),
      onExit: (_) => _onExitHover(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          onTap: () {
            context.go(route); // Navigate using GoRouter
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 45,
            width: _isExpanded ? 200 : 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isActive
                  ? Theme.of(context).colorScheme.secondary.withAlpha(50)
                  : isHovered
                      ? Theme.of(context).colorScheme.secondary.withAlpha(30)
                      : Theme.of(context).colorScheme.primary.withAlpha(50),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Icon(icon,
                    color: isActive
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.onPrimary),
                if (_isExpanded) const SizedBox(width: 12),
                if (_isExpanded)
                  Text(label,
                      style: !isActive
                          ? Theme.of(context).textTheme.labelMedium
                          : Theme.of(context).textTheme.labelMedium?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onSecondary)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutItem() {
    final isHovered = _hoveredRoute == 'logout';
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover('logout'),
      onExit: (_) => _onExitHover(),
      child: GestureDetector(
        onTap: _logout, // Call the logout method
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 45,
          width: _isExpanded ? 200 : 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isHovered
                ? Theme.of(context).colorScheme.error.withAlpha(30)
                : Theme.of(context).colorScheme.error.withAlpha(50),
          ),
          child: Row(
            children: [
              const SizedBox(width: 15),
              Icon(Icons.logout, color: Theme.of(context).colorScheme.onError),
              if (_isExpanded) const SizedBox(width: 12),
              if (_isExpanded)
                Text('Logout',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onError)),
            ],
          ),
        ),
      ),
    );
  }
}
