import 'dart:convert';
import 'dart:developer';

import 'package:adcio_placement/src/api_result.dart';
import 'package:adcio_placement/src/error.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ApiClient {
  ApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? 'https://api.adcio.ai';

  final _ApiRequest _request = _ApiRequest(Client());
  final String _baseUrl;

  Future<AdcioSuggestionRawData> suggestion({
    required String sessionId,
    required String deviceId,
    String? customerId,
    required String placementId,
    int? placementPosX,
    int? placementPosY,
    required bool fromAgent,
    String? age,
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
    params['fromAgent'] = fromAgent;
    if (age?.isNotEmpty ?? false) {
      params['age'] = age;
    }
    if (gender?.isNotEmpty ?? false) {
      params['gender'] = gender;
    }
    if (area?.isNotEmpty ?? false) {
      params['area'] = area;
    }
    if (placementPosX != null) {
      params['placementPosX'] = placementPosX;
    }
    if (placementPosY != null) {
      params['placementPosY'] = placementPosY;
    }

    final response = await _request(
      method: _RequestMethod.post,
      url: url,
      params: params,
    );

    if ([200, 201].contains(response.statusCode)) {
      return AdcioSuggestionRawData.fromJson(response.body);
    } else if (response.statusCode == 400) {
      throw UnregisteredIdException();
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

enum _RequestMethod { get, post }

class _ApiRequest {
  _ApiRequest(Client client) : _client = client;

  final Client _client;

  Future<_ApiResponse> call({
    required _RequestMethod method,
    Map<String, String>? headers,
    required String url,
    Map<String, dynamic>? params,
  }) async {
    log('[req] $method $url (${params ?? ''})');
    final httpResponse = await _requestHttp(method, headers, url, params);
    final response = _ApiResponse.fromHttpResponse(httpResponse);
    log('[res] $method $url ${response.statusCode} ${response.body}');
    return response;
  }

  Future<Response> _requestHttp(
    _RequestMethod method,
    Map<String, String>? headers,
    String url,
    Map<String, dynamic>? params,
  ) {
    Future<Response> result;
    switch (method) {
      case _RequestMethod.get:
        if (params?.isNotEmpty ?? false) {
          url += '?${_queryParameters(params!)}';
        }
        result = _client.get(
          Uri.parse(url),
          headers: headers,
        );
        break;
      case _RequestMethod.post:
        result = _client.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(params),
        );

        break;
    }

    return result;
  }

  String _queryParameters(Map<String, dynamic> params) {
    return params.entries.map((json) {
      if (json.value is! Iterable) {
        return '${json.key}=${json.value}';
      }

      return (json.value as Iterable)
          .map((value) => '${json.key}=$value')
          .join('&');
    }).join('&');
  }
}

class _ApiResponse {
  _ApiResponse({required this.statusCode});

  int statusCode;
  dynamic body;

  factory _ApiResponse.fromHttpResponse(Response res) {
    final response = _ApiResponse(statusCode: res.statusCode);

    if (res.body.isNotEmpty) {
      final decodeData = utf8.decode(res.bodyBytes);
      response.body = jsonDecode(decodeData);
    }
    return response;
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'body': body,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
