import 'package:flutter/services.dart';

class VPNService {
  static const MethodChannel _channel = MethodChannel('com.example.blp_vpn/vpn');

  Future<void> connect(String config, String username, String password) async {
    try {
      await _channel.invokeMethod('connect', {
        'config': config,
        'username': username,
        'password': password,
      });
    } on PlatformException catch (e) {
      print("Failed to connect: '${e.message}'.");
    }
  }

  Future<void> disconnect() async {
    try {
      await _channel.invokeMethod('disconnect');
    } on PlatformException catch (e) {
      print("Failed to disconnect: '${e.message}'.");
    }
  }
}
