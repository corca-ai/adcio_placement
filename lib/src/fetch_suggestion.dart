import 'dart:ui';

import 'package:adcio_analytics/adcio_analytics.dart';
import 'package:adcio_core/adcio_core.dart';

import 'api_client.dart';
import 'api_result.dart';

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
  String? deviceId,
  String? sessionId,
}) async {
  final client = apiClient ?? ApiClient(baseUrl: baseUrl);

  AdcioAnalytics.clearImpressionHistory();

  return client.suggestion(
    sessionId: sessionId ?? AdcioCore.sessionId,
    deviceId: deviceId ?? AdcioCore.deviceId,
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
