import 'package:flutter/material.dart';
import 'package:writing_app/utils/theme.dart';

class AppSidebar extends StatefulWidget {
  final String activeSection;
  final Function(String) onSectionTap;

  const AppSidebar({
    Key? key,
    required this.activeSection,
    required this.onSectionTap,
  }) : super(key: key);

  @override
  _AppSidebarState createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _isExpanded = true;
  String _hoveredSection = ''; // Tracks the currently hovered section

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onHover(String section) {
    setState(() {
      _hoveredSection = section;
    });
  }

  void _onExitHover() {
    setState(() {
      _hoveredSection = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isExpanded ? 250 : 100, // Adjust width based on state
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 30,
            spreadRadius: 6,
            offset: Offset(0, 20),
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
            isActive: widget.activeSection == 'Home',
            onTap: () => widget.onSectionTap('Home'),
          ),
          _buildSidebarItem(
            icon: Icons.notes_outlined,
            label: 'Notes',
            isActive: widget.activeSection == 'Notes',
            onTap: () => widget.onSectionTap('Notes'),
          ),
          _buildSidebarItem(
            icon: Icons.edit_outlined,
            label: 'Writing',
            isActive: widget.activeSection == 'Writing',
            onTap: () => widget.onSectionTap('Writing'),
          ),
          _buildSidebarItem(
            icon: Icons.search,
            label: 'Research',
            isActive: widget.activeSection == 'Research',
            onTap: () => widget.onSectionTap('Research'),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final isHovered = _hoveredSection == label;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover(label),
      onExit: (_) => _onExitHover(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(
                milliseconds: 0), // Smooth transition for hover effects
            height: 45,
            width: _isExpanded ? 200 : 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isActive
                  ? Theme.of(context)
                      .colorScheme
                      .secondary
                      .withValues(alpha: 0.3)
                  : isHovered
                      ? Theme.of(context)
                          .colorScheme
                          .secondary
                          .withValues(alpha: 0.2)
                      : Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.3),
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
}
