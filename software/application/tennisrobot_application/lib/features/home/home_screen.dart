// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'widgets/bluetooth_pair_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothDevice? _connectedDevice;

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
              const Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tennis Robot Control Center',
                style: TextStyle(color: Color(0xFF4A5568), fontSize: 14),
              ),
              const SizedBox(height: 28),
              _StatusCard(device: _connectedDevice),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _StatCard(icon: Icons.wifi_rounded, label: 'Signal', value: _connectedDevice != null ? 'Strong' : '-', color: const Color(0xFF10B981))),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(icon: Icons.battery_charging_full_rounded, label: 'Battery', value: _connectedDevice != null ? '87%' : '-', color: const Color(0xFFF59E0B))),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(icon: Icons.thermostat_rounded, label: 'Temp', value: _connectedDevice != null ? '32C' : '-', color: const Color(0xFFEF4444))),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'CONNECTION',
                style: TextStyle(color: Color(0xFF4A5568), fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              BluetoothPairButton(
                robotNamePrefix: 'TennisRobot',
                onPaired: (device) => setState(() => _connectedDevice = device),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final BluetoothDevice? device;
  const _StatusCard({this.device});

  @override
  Widget build(BuildContext context) {
    final connected = device != null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1629),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: connected ? const Color(0xFF10B981).withOpacity(0.4) : const Color(0xFF1E2D4A),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: connected ? const Color(0xFF10B981).withOpacity(0.15) : const Color(0xFF1E2D4A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.sports_tennis_rounded,
              color: connected ? const Color(0xFF10B981) : const Color(0xFF4A5568), size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(connected ? 'Robot Connected' : 'No Robot Connected',
                  style: TextStyle(color: connected ? Colors.white : const Color(0xFF4A5568), fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(connected ? device!.platformName : 'Pair your robot to get started',
                  style: TextStyle(color: connected ? const Color(0xFF10B981) : const Color(0xFF2D3748), fontSize: 13)),
              ],
            ),
          ),
          Container(
            width: 10, height: 10,
            decoration: BoxDecoration(
              color: connected ? const Color(0xFF10B981) : const Color(0xFF2D3748),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1629),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E2D4A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Color(0xFF4A5568), fontSize: 12)),
        ],
      ),
    );
  }
}