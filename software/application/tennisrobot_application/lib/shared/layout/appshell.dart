// lib/shared/layout/app_shell.dart

import 'package:flutter/material.dart';
import '../../features/home/home_screen.dart';
import '../../features/control/control_screen.dart';

import '../../features/settings/settings_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.sports_tennis_rounded, label: 'Control'),
    _NavItem(icon: Icons.settings_rounded, label: 'Settings'),
  ];

  final List<Widget> _screens = const [
    HomeScreen(),
    ControlScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: Row(
        children: [
          _Sidebar(
            items: _navItems,
            selectedIndex: _selectedIndex,
            onItemTap: (i) => setState(() => _selectedIndex = i),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

// ── Sidebar ──────────────────────────────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final void Function(int) onItemTap;

  const _Sidebar({
    required this.items,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1629),
        border: Border(
          right: BorderSide(color: Color(0xFF1E2D4A), width: 1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1D4ED8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.sports_tennis_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),

          const SizedBox(height: 32),

          // Nav Items
          ...List.generate(items.length, (i) {
            final selected = i == selectedIndex;
            return _SidebarIcon(
              item: items[i],
              selected: selected,
              onTap: () => onItemTap(i),
            );
          }),

          const Spacer(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarIcon({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: item.label,
      preferBelow: false,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF1D4ED8).withOpacity(0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFF3B82F6).withOpacity(0.5)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Icon(
            item.icon,
            size: 22,
            color: selected
                ? const Color(0xFF60A5FA)
                : const Color(0xFF4A5568),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}