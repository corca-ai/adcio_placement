@GenerateNiceMocks([MockSpec<ApiClient>()])
import 'package:adcio_core/adcio_core.dart';
import 'package:adcio_placement/adcio_placement.dart';
import 'package:adcio_placement/src/api_client.dart';
import 'package:adcio_placement/src/error.dart';
import 'package:adcio_placement/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'adcio_placement_test.mocks.dart';
import 'suggestion_data.dart';

void main() async {
  final ApiClient mockApiClient = MockApiClient();
  const activatedPlacemntId = '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481';
  const disabledPlacemntId = '15a4b107-8c71-447b-9794-fe7d7582e43c';
  const randomUUID = '34afc940-3801-45f6-b558-2365b26c8196';
  const notUUID = 'test-uuid';

  setUp(() {
    //
    // success case (call the suggestion api)
    when(
      mockApiClient.suggestion(
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
        placementId: activatedPlacemntId,
        fromAgent: false,
      ),
    ).thenAnswer(
      (_) async => AdcioSuggestionRawData.fromJson(suggestionResponse),
    );

    //
    // error case (call the suggestion api)
    when(
      mockApiClient.suggestion(
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
        placementId: notUUID,
        fromAgent: false,
      ),
    ).thenThrow(BadRequestException(message: "placementId must be a UUID"));

    when(
      mockApiClient.suggestion(
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
        placementId: randomUUID,
        fromAgent: false,
      ),
    ).thenThrow(UnregisteredIdException());

    when(
      mockApiClient.suggestion(
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
        placementId: disabledPlacemntId,
        fromAgent: false,
      ),
    ).thenThrow(DisabledPlacementException());
  });

  test('convert from offset to List<int>', () {
    const placementPosition = Offset(20, 560);
    final result = convertListByOffset(placementPosition);

    expect(result, [20, 560]);
  });

  test(
      'When the suppression is called before using the AdcioCore.initializeApp() function',
      () {
    expect(
      () => adcioCreateSuggestion(
        placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
        apiClient: mockApiClient,
        sessionId: AdcioCore.sessionId,
        deviceId: AdcioCore.deviceId,
      ),
      throwsA(isInstanceOf<UnInitializedException>()),
    );
  });

  test(
      'When the suppression is called after using the AdcioCore.initializeApp() function',
      () async {
    await AdcioCore.initializeApp(
      clientId: 'f8f2e298-c168-4412-b82d-98fc5b4a114a',
    );

    expect(
      await adcioCreateSuggestion(
        placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
        apiClient: mockApiClient,
        sessionId: AdcioCore.sessionId,
        deviceId: AdcioCore.deviceId,
      ),
      isInstanceOf<AdcioSuggestionRawData>(),
    );
  });

  test('When the provided placementId is registered in the ADCIO service',
      () async {
    expect(
      await adcioCreateSuggestion(
        placementId: activatedPlacemntId,
        apiClient: mockApiClient,
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
      ),
      isInstanceOf<AdcioSuggestionRawData>(),
    );
  });
  test('When the placement exists in the ADCIO service but is not enabled',
      () async {
    expect(
      () => adcioCreateSuggestion(
        placementId: disabledPlacemntId,
        apiClient: mockApiClient,
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
      ),
      throwsA(isInstanceOf<UnregisteredIdException>()),
    );
  });

  test('When the provided placementId is not registered in the ADCIO service',
      () {
    expect(
      () => adcioCreateSuggestion(
        placementId: randomUUID,
        apiClient: mockApiClient,
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
      ),
      throwsA(isInstanceOf<UnregisteredIdException>()),
    );
  });

  test('When the placementId value is not a UUID', () {
    expect(
      () => adcioCreateSuggestion(
        placementId: notUUID,
        apiClient: mockApiClient,
        sessionId: 'a3e0efcc-bbed-4c73-b001-cd3d0c54e7a6',
        deviceId: '6D79D039-3FE3-4887-B0BC-FDDCBD758C99',
      ),
      throwsA(isInstanceOf<UnregisteredIdException>()),
    );
  });
}
