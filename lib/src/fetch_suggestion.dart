import 'dart:ui';

import 'package:adcio_placement/src/adcio_suggestion_info.dart';
import 'package:adcio_placement/src/utils.dart';

import 'api_client.dart';
import 'api_result.dart';

AdcioSuggestionInfo adcioInfo = AdcioSuggestionInfo();

String getSessionId([AdcioSuggestionInfo? otherInfo]) =>
    (otherInfo == null) ? adcioInfo.getSessionId() : otherInfo.getSessionId();

Future<String> getDeviceId([AdcioSuggestionInfo? info]) =>
    (info == null) ? adcioInfo.getDeviceId() : info.getDeviceId();

Future<AdcioSuggestionRawData> adcioSuggest({
  required String placementId,
  String? baseUrl,
  String? age,
  String? area,
  String? customerId,
  String? gender,
  Offset? placementPosition,
  ApiClient? apiClient,
  AdcioSuggestionInfo? otherInfo,
}) async {
  final client = apiClient ?? ApiClient(baseUrl: baseUrl);
  final info = otherInfo ?? adcioInfo;

  return client.suggestion(
    sessionId: getSessionId(info),
    deviceId: await getDeviceId(info),
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
