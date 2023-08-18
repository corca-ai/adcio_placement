import 'dart:ui';

import 'package:adcio_placement/src/adcio_suggestion_info.dart';
import 'package:adcio_placement/src/utils.dart';

import 'api_client.dart';
import 'api_result.dart';

AdcioSuggestionInfo suggestionInfo = AdcioSuggestionInfo();

Future<AdcioSuggestionRawData> adcioSuggest({
  required String placementId,
  String? baseUrl,
  String? age,
  String? area,
  String? customerId,
  String? gender,
  Offset? placementPosition,
  ApiClient? apiClient,
  AdcioSuggestionInfo? fetchInfo,
}) async {
  final client = apiClient ?? ApiClient(baseUrl: baseUrl);
  if (fetchInfo != null) {
    suggestionInfo = fetchInfo;
  }

  return client.suggestion(
    sessionId: suggestionInfo.getSessionId(),
    deviceId: await suggestionInfo.getDeviceId(),
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
