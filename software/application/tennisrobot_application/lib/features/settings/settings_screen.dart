// lib/features/settings/settings_screen.dart

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoConnect = true;
  bool _notifications = false;
  bool _darkMode = true;
  bool _hapticFeedback = true;
  String _robotName = 'TennisRobot';
  double _connectionTimeout = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'App & Robot Configuration',
                style: TextStyle(color: Color(0xFF4A5568), fontSize: 14),
              ),

              const SizedBox(height: 28),

              // Robot Section
              _SectionHeader(label: 'ROBOT'),
              const SizedBox(height: 12),

              _SettingsCard(
                children: [
                  _TextFieldTile(
                    icon: Icons.sports_tennis_rounded,
                    label: 'Robot Name',
                    value: _robotName,
                    onChanged: (v) => setState(() => _robotName = v),
                  ),
                  _Divider(),
                  _SliderTile(
                    icon: Icons.timer_rounded,
                    label: 'Connection Timeout',
                    value: _connectionTimeout,
                    min: 3,
                    max: 30,
                    unit: 's',
                    color: const Color(0xFF3B82F6),
                    onChanged: (v) => setState(() => _connectionTimeout = v),
                  ),
                  _Divider(),
                  _ToggleTile(
                    icon: Icons.bluetooth_rounded,
                    label: 'Auto Connect',
                    subtitle: 'Reconnect when robot is in range',
                    value: _autoConnect,
                    color: const Color(0xFF3B82F6),
                    onChanged: (v) => setState(() => _autoConnect = v),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // App Section
              _SectionHeader(label: 'APP'),
              const SizedBox(height: 12),

              _SettingsCard(
                children: [
                  _ToggleTile(
                    icon: Icons.dark_mode_rounded,
                    label: 'Dark Mode',
                    subtitle: 'Always on dark theme',
                    value: _darkMode,
                    color: const Color(0xFF8B5CF6),
                    onChanged: (v) => setState(() => _darkMode = v),
                  ),
                  _Divider(),
                  _ToggleTile(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    subtitle: 'Connection status alerts',
                    value: _notifications,
                    color: const Color(0xFFF59E0B),
                    onChanged: (v) => setState(() => _notifications = v),
                  ),
                  _Divider(),
                  _ToggleTile(
                    icon: Icons.vibration_rounded,
                    label: 'Haptic Feedback',
                    subtitle: 'Vibration on button press',
                    value: _hapticFeedback,
                    color: const Color(0xFF10B981),
                    onChanged: (v) => setState(() => _hapticFeedback = v),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Info Section
              _SectionHeader(label: 'INFO'),
              const SizedBox(height: 12),

              _SettingsCard(
                children: [
                  _InfoTile(
                    icon: Icons.info_outline_rounded,
                    label: 'App Version',
                    value: '1.0.0',
                  ),
                  _Divider(),
                  _InfoTile(
                    icon: Icons.phone_iphone_rounded,
                    label: 'Platform',
                    value: Theme.of(context).platform.name,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Reset Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _autoConnect = true;
                    _notifications = false;
                    _darkMode = true;
                    _hapticFeedback = true;
                    _robotName = 'TennisRobot';
                    _connectionTimeout = 8;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1629),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withOpacity(0.4),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh_rounded,
                          color: Color(0xFFEF4444), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Reset to Defaults',
                        style: TextStyle(
                          color: Color(0xFFEF4444),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF4A5568),
        fontSize: 11,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// ── Settings Card ─────────────────────────────────────────────────────────────
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1629),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2D4A)),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 56),
      color: const Color(0xFF1E2D4A),
    );
  }
}

// ── Toggle Tile ───────────────────────────────────────────────────────────────
class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final Color color;
  final void Function(bool) onChanged;

  const _ToggleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF4A5568), fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: color,
            inactiveThumbColor: const Color(0xFF2D3748),
            inactiveTrackColor: const Color(0xFF1E2D4A),
          ),
        ],
      ),
    );
  }
}

// ── Slider Tile ───────────────────────────────────────────────────────────────
class _SliderTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final double min;
  final double max;
  final String unit;
  final Color color;
  final void Function(double) onChanged;

  const _SliderTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    Text('${value.round()}$unit',
                        style: TextStyle(
                            color: color,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: color,
                    inactiveTrackColor: const Color(0xFF1E2D4A),
                    thumbColor: color,
                    overlayColor: color.withOpacity(0.2),
                    trackHeight: 3,
                  ),
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Text Field Tile ───────────────────────────────────────────────────────────
class _TextFieldTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final void Function(String) onChanged;

  const _TextFieldTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF10B981), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Color(0xFF4A5568),
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: value,
                  onChanged: onChanged,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF2D3748)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info Tile ─────────────────────────────────────────────────────────────────
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2D4A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF4A5568), size: 18),
          ),
          const SizedBox(width: 14),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value,
              style: const TextStyle(color: Color(0xFF4A5568), fontSize: 14)),
        ],
      ),
    );
  }
}