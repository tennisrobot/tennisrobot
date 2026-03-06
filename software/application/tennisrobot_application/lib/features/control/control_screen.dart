import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  double _speed = 50;
  double _angle = 0;
  bool _isRunning = false;
  String _selectedMode = 'Manual';

  final List<String> _modes = ['Manual', 'Auto', 'Training', 'Tournament'];

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
                'Control',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Robot Movement & Mode',
                style: TextStyle(color: Color(0xFF4A5568), fontSize: 14),
              ),

              const SizedBox(height: 28),

              // Mode Selector
              const Text(
                'MODE',
                style: TextStyle(
                  color: Color(0xFF4A5568),
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _modes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final selected = _modes[i] == _selectedMode;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedMode = _modes[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFF0F1629),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF1E2D4A),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _modes[i],
                            style: TextStyle(
                              color: selected ? Colors.white : const Color(0xFF4A5568),
                              fontSize: 14,
                              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // D-Pad
              const Text(
                'DIRECTION',
                style: TextStyle(
                  color: Color(0xFF4A5568),
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Center(child: _DPad()),

              const SizedBox(height: 28),

              // Speed Slider
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1629),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E2D4A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Speed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${_speed.round()} %',
                          style: const TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF1D4ED8),
                        inactiveTrackColor: const Color(0xFF1E2D4A),
                        thumbColor: const Color(0xFF3B82F6),
                        overlayColor: const Color(0xFF3B82F6).withOpacity(0.2),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: _speed,
                        min: 0,
                        max: 100,
                        onChanged: (v) => setState(() => _speed = v),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Angle Slider
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1629),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E2D4A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Angle',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${_angle.round()}°',
                          style: const TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF7C3AED),
                        inactiveTrackColor: const Color(0xFF1E2D4A),
                        thumbColor: const Color(0xFF8B5CF6),
                        overlayColor: const Color(0xFF8B5CF6).withOpacity(0.2),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: _angle,
                        min: -90,
                        max: 90,
                        onChanged: (v) => setState(() => _angle = v),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Start / Stop Button
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => setState(() => _isRunning = !_isRunning),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: _isRunning
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF1D4ED8),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: (_isRunning
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF1D4ED8))
                              .withOpacity(0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _isRunning ? 'Stop Robot' : 'Start Robot',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
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

// ── D-Pad Widget ──────────────────────────────────────────────────────────────
class _DPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFF0F1629),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF1E2D4A)),
            ),
          ),
          // Up
          Positioned(
            top: 8,
            child: _DPadButton(icon: Icons.keyboard_arrow_up_rounded, onTap: () {}),
          ),
          // Down
          Positioned(
            bottom: 8,
            child: _DPadButton(icon: Icons.keyboard_arrow_down_rounded, onTap: () {}),
          ),
          // Left
          Positioned(
            left: 8,
            child: _DPadButton(icon: Icons.keyboard_arrow_left_rounded, onTap: () {}),
          ),
          // Right
          Positioned(
            right: 8,
            child: _DPadButton(icon: Icons.keyboard_arrow_right_rounded, onTap: () {}),
          ),
          // Center dot
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2D4A),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2D3748)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DPadButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _DPadButton({required this.icon, required this.onTap});

  @override
  State<_DPadButton> createState() => _DPadButtonState();
}

class _DPadButtonState extends State<_DPadButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _pressed
              ? const Color(0xFF1D4ED8)
              : const Color(0xFF151E33),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _pressed
                ? const Color(0xFF3B82F6)
                : const Color(0xFF1E2D4A),
          ),
        ),
        child: Icon(
          widget.icon,
          color: _pressed ? Colors.white : const Color(0xFF4A5568),
          size: 24,
        ),
      ),
    );
  }
}