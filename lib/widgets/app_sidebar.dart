import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';
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
              if (_isExpanded) const SizedBox(width: 20),
              if (_isExpanded)
                Flexible(
                  child: InkWell(
                    onTap: () => {context.go('/projects')},
                    child: Text(
                      project!.title,
                      style: Theme.of(context).textTheme.labelLarge,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
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
        onTap: () => {
          showDialog<void>(
            context: context,
            builder: (context) => const SettingsDialog(),
          ),
        },
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
                  localizations!.settings,
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
}
