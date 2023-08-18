import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

class AdcioSuggestionInfo {
  String? _sessionId;
  String? _deviceId;

  String getSessionId() {
    _sessionId ??= const Uuid().v4();
    return _sessionId!;
  }

  Future<String> getDeviceId() async {
    _deviceId ??= await _fetchDeviceId();
    return _deviceId!;
  }

  Future<String> _fetchDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.id;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor ?? '${DateTime.now()}';
    } else {
      return '${DateTime.now()}';
    }
  }
}
