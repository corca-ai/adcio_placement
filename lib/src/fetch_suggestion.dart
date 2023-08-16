import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

import 'api_client.dart';
import 'api_result.dart';

String? _sessionId;
String? _deviceId;

Future<AdcioSuggestionRawData> adcioSuggest({
  required String placementId,
  String? baseUrl,
  String? age,
  String? area,
  String? customerId,
  String? gender,
  Offset? placementPosition,
}) async {
  final client = ApiClient(baseUrl: baseUrl);

  return client.suggestion(
    sessionId: getSessionId(),
    deviceId: await getDeviceId(),
    placementId: placementId,
    fromAgent: false,
    age: age,
    area: area,
    customerId: customerId,
    gender: gender,

    /// FIXME: default value인 [0,0,0,0] 사라질 예정
    placementPosition: convertListByOffset(placementPosition) ?? [0, 0, 0, 0],
  );
}

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

List<int>? convertListByOffset(Offset? offset) =>
    (offset is Offset) ? [offset.dx.toInt(), offset.dy.toInt()] : null;
