import 'package:adcio_placement/src/api_request.dart';
import 'package:adcio_placement/src/api_result.dart';
import 'package:adcio_placement/src/error.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ApiClient {
  ApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? 'https://api.adcio.ai';

  final ApiRequest _request = ApiRequest(Client());
  final String _baseUrl;

  Future<AdcioSuggestionRawData> suggestion({
    required String sessionId,
    required String deviceId,
    String? customerId,
    required String placementId,
    int? placementPositionX,
    int? placementPositionY,
    bool? fromAgent,
    int? birthYear,
    String? gender,
    String? area,
  }) async {
    final url = '$_baseUrl/suggestions';

    final params = <String, dynamic>{};
    params['sessionId'] = sessionId;
    params['deviceId'] = deviceId;
    if (customerId?.isNotEmpty ?? false) {
      params['customerId'] = customerId;
    }
    params['placementId'] = placementId;
    if (fromAgent != null) {
      params['fromAgent'] = fromAgent;
    }
    if (birthYear != null) {
      params['birthYear'] = birthYear;
    }
    if (gender?.isNotEmpty ?? false) {
      params['gender'] = gender;
    }
    if (area?.isNotEmpty ?? false) {
      params['area'] = area;
    }
    if (placementPositionX != null) {
      params['placementPositionX'] = placementPositionX;
    }
    if (placementPositionY != null) {
      params['placementPositionY'] = placementPositionY;
    }

    final response = await _request(
      method: RequestMethod.post,
      url: url,
      params: params,
    );

    if ([200, 201].contains(response.statusCode)) {
      return AdcioSuggestionRawData.fromJson(response.body);
    } else if (response.statusCode == 400) {
      throw BadRequestException(
        message: response.body['message'].toString(),
      );
    } else if (response.statusCode == 404 &&
        response.body['message'] == 12001) {
      throw UnregisteredIdException();
    } else if (response.statusCode == 404 &&
        response.body['message'] == 12004) {
      throw DisabledPlacementException();
    } else {
      throw PlatformException(
        code: 'SYSTEM_ERROR',
        details: {
          'statusCode': response.statusCode,
          'body': response.body ?? '',
        },
      );
    }
  }
}
