@GenerateNiceMocks([MockSpec<ApiClient>()])
import 'package:adcio_placement/adcio_placement.dart';
import 'package:adcio_placement/src/api_client.dart';
import 'package:adcio_placement/src/error.dart';
@GenerateNiceMocks([MockSpec<AdcioSuggestionInfo>()])
import 'package:adcio_placement/src/adcio_suggestion_info.dart';
import 'package:adcio_placement/src/utils.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'adcio_placement_test.mocks.dart';
import 'suggestion_data.dart';

void main() {
  final ApiClient mockApiClient = MockApiClient();
  final AdcioSuggestionInfo mockSuggestionInfo = MockAdcioSuggestionInfo();

  // add mock the sessionId and deviceId
  when(mockSuggestionInfo.getSessionId())
      .thenAnswer((_) => 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6');
  when(mockSuggestionInfo.getDeviceId()).thenAnswer(
    (_) async => '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
  );

  // success case (call the suggestion api)
  when(
    mockApiClient.suggestion(
      sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
      deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
      placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
      fromAgent: false,
    ),
  ).thenAnswer(
    (_) async => AdcioSuggestionRawData.fromJson(suggestionResponse),
  );

  // error case (call the suggestion api)
  when(
    mockApiClient.suggestion(
      sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
      deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
      placementId: 'test_UUID',
      fromAgent: false,
    ),
  ).thenThrow(UnregisteredIdException());

  test('Verifying if the sessionId remains the same during runtime', () {
    final sessionId = mockSuggestionInfo.getSessionId();

    expect(sessionId, mockSuggestionInfo.getSessionId());
  });

  test('convert from offset to List<int>', () {
    const placementPosition = Offset(20, 560);
    final result = convertListByOffset(placementPosition);

    expect(result, [20, 560]);
  });

  test('When the provided placementId is registered in the ADCIO service',
      () async {
    expect(
      await adcioSuggest(
        placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
        apiClient: mockApiClient,
        fetchInfo: mockSuggestionInfo,
      ),
      isInstanceOf<AdcioSuggestionRawData>(),
    );
  });

  /// FIXME: This test case is not working
  test('When the provided placementId is not registered in the ADCIO service',
      () async {
    expect(
      adcioSuggest(
        placementId: 'test_UUID',
        apiClient: mockApiClient,
        fetchInfo: mockSuggestionInfo,
      ),
      throwsA(isInstanceOf<UnregisteredIdException>()),
    );
  });
}
