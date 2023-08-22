import 'dart:ui';

import 'package:adcio_analytics/adcio_analytics.dart';
import 'package:adcio_placement/src/adcio_suggestion_info.dart';

import 'api_client.dart';
import 'api_result.dart';

AdcioSuggestionInfo adcioInfo = AdcioSuggestionInfo();

String getSessionId([AdcioSuggestionInfo? otherInfo]) =>
    (otherInfo == null) ? adcioInfo.getSessionId() : otherInfo.getSessionId();

Future<String> getDeviceId([AdcioSuggestionInfo? info]) =>
    (info == null) ? adcioInfo.getDeviceId() : info.getDeviceId();

/// ADCIO suggest placement service.
///
/// `placementId` is required.
///
/// You enter the registered [placementId] on the ADCIO Admin Page.
///
/// example code:
/// ```dart
/// adcioSuggest(
///   placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
/// ).then((value) {
///   rawData = value;
///   setState(() {});
/// });
/// ```
///
/// Additionally, if there are user details such as customerId (similar to userId),
/// age, gender, and information related to the space like area, as well as placementPosition,
/// the accuracy of recommendation predictions can be further enhanced.
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

  AdcioAnalytics.clearImpressionHistory();

  return client.suggestion(
    sessionId: getSessionId(info),
    deviceId: await getDeviceId(info),
    placementId: placementId,
    fromAgent: false,
    age: age,
    area: area,
    customerId: customerId,
    gender: gender,
    placementPosX: placementPosition?.dx.toInt(),
    placementPosY: placementPosition?.dy.toInt(),
  );
}
