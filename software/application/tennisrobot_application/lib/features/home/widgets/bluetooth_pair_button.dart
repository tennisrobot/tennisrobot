import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

enum _BtState { idle, scanning, connecting, connected, error }

class BluetoothPairButton extends StatefulWidget {
  final void Function(BluetoothDevice device)? onPaired;
  final String? robotNamePrefix;

  const BluetoothPairButton({
    super.key,
    this.onPaired,
    this.robotNamePrefix,
  });

  @override
  State<BluetoothPairButton> createState() => _BluetoothPairButtonState();
}

class _BluetoothPairButtonState extends State<BluetoothPairButton>
    with SingleTickerProviderStateMixin {
  _BtState _state = _BtState.idle;
  BluetoothDevice? _foundDevice;
  String _statusText = 'Pair Robot';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isWindows) return true;

    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    return statuses.values.every((s) => s.isGranted);
  }

  Future<void> _startPairing() async {
    if (_state == _BtState.scanning || _state == _BtState.connecting) return;

    final granted = await _requestPermissions();
    if (!granted) {
      _setError('Bluetooth permission denied');
      return;
    }

    final adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      _setError('Please enable Bluetooth');
      return;
    }

    setState(() {
      _state = _BtState.scanning;
      _statusText = 'Scanning…';
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 6));

    await for (final results in FlutterBluePlus.scanResults) {
      for (final r in results) {
        final name = r.device.platformName;
        final matches = widget.robotNamePrefix == null ||
            name.startsWith(widget.robotNamePrefix!);

        if (matches && name.isNotEmpty) {
          FlutterBluePlus.stopScan();
          await _connectTo(r.device);
          return;
        }
      }
    }

    _setError('No robot found');
  }

  Future<void> _connectTo(BluetoothDevice device) async {
    setState(() {
      _state = _BtState.connecting;
      _foundDevice = device;
      _statusText = 'Connecting…';
    });

    try {
      await device.connect(timeout: const Duration(seconds: 8));
      setState(() {
        _state = _BtState.connected;
        _statusText = device.platformName.isNotEmpty
            ? 'Connected: ${device.platformName}'
            : 'Robot Connected';
      });
      widget.onPaired?.call(device);
    } catch (e) {
      _setError('Connection failed');
    }
  }

  void _setError(String message) {
    setState(() {
      _state = _BtState.error;
      _statusText = message;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _state = _BtState.idle;
          _statusText = 'Pair Robot';
        });
      }
    });
  }

  Future<void> _disconnect() async {
    await _foundDevice?.disconnect();
    setState(() {
      _state = _BtState.idle;
      _foundDevice = null;
      _statusText = 'Pair Robot';
    });
  }

  Color get _buttonColor {
    switch (_state) {
      case _BtState.connected:
        return const Color(0xFF00C896);
      case _BtState.error:
        return const Color(0xFFFF4D6D);
      case _BtState.scanning:
      case _BtState.connecting:
        return const Color(0xFF3B82F6);
      case _BtState.idle:
        return const Color(0xFF1E40AF);
    }
  }

  IconData get _icon {
    switch (_state) {
      case _BtState.connected:
        return Icons.bluetooth_connected_rounded;
      case _BtState.error:
        return Icons.bluetooth_disabled_rounded;
      case _BtState.scanning:
      case _BtState.connecting:
        return Icons.bluetooth_searching_rounded;
      case _BtState.idle:
        return Icons.bluetooth_rounded;
    }
  }

  bool get _isAnimating =>
      _state == _BtState.scanning || _state == _BtState.connecting;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (context, child) {
        return Transform.scale(
          scale: _isAnimating ? _pulseAnim.value : 1.0,
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _buttonColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _buttonColor.withOpacity(0.45),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _state == _BtState.connected ? _disconnect : _startPairing,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_icon, color: Colors.white, size: 26),
                  const SizedBox(width: 12),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      _statusText,
                      key: ValueKey(_statusText),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  if (_isAnimating) ...[
                    const SizedBox(width: 12),
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}