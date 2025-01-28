import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/locale_provider.dart';
import 'package:writing_app/theme_cubit.dart';
import 'package:writing_app/utils/scaffold_messenger.dart';
import 'package:writing_app/widgets/settings_dialog.dart';

class AppSidebar extends StatefulWidget {
  const AppSidebar({
    super.key,
    required this.activeRoute,
  });
  final String activeRoute;

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
    } catch (err) {
      showMessage(context, 'Logout failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final project = context.read<ProjectCubit>().selectedProject;
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
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isExpanded) const Icon(Icons.circle_outlined, size: 25),
              if (_isExpanded) const SizedBox(width: 20),
              if (_isExpanded)
                InkWell(
                  onTap: () => {context.go('/projects')},
                  child: Text(
                    project!.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
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
            label: localizations!.sidebarHome,
            route: '/',
            isActive: widget.activeRoute == '/',
          ),
          _buildSidebarItem(
            icon: Icons.note_outlined,
            label: localizations.sidebarNotes,
            route: '/notes',
            isActive: widget.activeRoute == '/notes',
          ),
          _buildSidebarItem(
            icon: Icons.edit_outlined,
            label: localizations.sidebarWriting,
            route: '/writing',
            isActive: widget.activeRoute == '/writing',
          ),
          _buildSidebarItem(
            icon: Icons.search,
            label: localizations.sidebarResearch,
            route: '/research',
            isActive: widget.activeRoute == '/research',
          ),
          const Spacer(), // Push logout button to the bottom
          _buildSettingsItem(),
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
                Icon(
                  icon,
                  color: isActive
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                if (_isExpanded) const SizedBox(width: 12),
                if (_isExpanded)
                  Text(
                    label,
                    style: !isActive
                        ? Theme.of(context).textTheme.labelMedium
                        : Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem() {
    final localizations = AppLocalizations.of(context);

    final isHovered = _hoveredRoute == 'settings';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover('settings'),
      onExit: (_) => _onExitHover(),
      child: GestureDetector(
        onTap: () => _showSettingsDialog(context), // Opens the settings modal
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 45,
          width: _isExpanded ? 200 : 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isHovered
                ? Theme.of(context).colorScheme.primary.withAlpha(30)
                : Theme.of(context).colorScheme.primary.withAlpha(50),
          ),
          child: Row(
            children: [
              const SizedBox(width: 15),
              Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              if (_isExpanded) const SizedBox(width: 12),
              if (_isExpanded)
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text('Settings', style: Theme.of(context).textTheme.labelLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Language Dropdown
              Row(
                children: [
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(width: 16),
                  LanguageDropDown(),
                ],
              ),
              const SizedBox(height: 20),
              // Dark Mode Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      themeCubit.toggleTheme();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // "Go to Projects" Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  context.go('/projects'); // Navigate to projects
                },
                icon: const Icon(Icons.apps),
                label: const Text('Go to Projects'),
              ),
              const SizedBox(height: 20),
              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  _logout(); // Perform logout action
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(localizations!.cancel),
            ),
          ],
        );
      },
    );
  }
}
