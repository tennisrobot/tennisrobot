import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class RobotBluetoothService {
  BluetoothDevice? connectedDevice;

  Future<BluetoothDevice?> connectToRobot(String namePrefix) async {
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 6));

    await for (final results in FlutterBluePlus.scanResults) {
      for (final r in results) {
        if (r.device.platformName.startsWith(namePrefix)) {
          FlutterBluePlus.stopScan();
          await r.device.connect();
          connectedDevice = r.device;
          return r.device;
        }
      }
    }
    return null;
  }

  Future<void> disconnect() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
  }

  Future<void> sendCommand(String command) async {
    if (connectedDevice == null) return;

    final services = await connectedDevice!.discoverServices();
    for (final service in services) {
      for (final char in service.characteristics) {
        if (char.properties.write) {
          await char.write(command.codeUnits);
          return;
        }
      }
    }
  }
}