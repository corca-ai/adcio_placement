// Mocks generated by Mockito 5.4.2 from annotations
// in adcio_placement/test/adcio_placement_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:adcio_placement/src/api_client.dart' as _i3;
import 'package:adcio_placement/src/api_result.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAdcioSuggestionRawData_0 extends _i1.SmartFake
    implements _i2.AdcioSuggestionRawData {
  _FakeAdcioSuggestionRawData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiClient extends _i1.Mock implements _i3.ApiClient {
  @override
  _i4.Future<_i2.AdcioSuggestionRawData> suggestion({
    required String? sessionId,
    required String? deviceId,
    String? customerId,
    required String? placementId,
    int? placementPosX,
    int? placementPosY,
    required bool? fromAgent,
    String? age,
    String? gender,
    String? area,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #suggestion,
          [],
          {
            #sessionId: sessionId,
            #deviceId: deviceId,
            #customerId: customerId,
            #placementId: placementId,
            #placementPosX: placementPosX,
            #placementPosY: placementPosY,
            #fromAgent: fromAgent,
            #age: age,
            #gender: gender,
            #area: area,
          },
        ),
        returnValue: _i4.Future<_i2.AdcioSuggestionRawData>.value(
            _FakeAdcioSuggestionRawData_0(
          this,
          Invocation.method(
            #suggestion,
            [],
            {
              #sessionId: sessionId,
              #deviceId: deviceId,
              #customerId: customerId,
              #placementId: placementId,
              #placementPosX: placementPosX,
              #placementPosY: placementPosY,
              #fromAgent: fromAgent,
              #age: age,
              #gender: gender,
              #area: area,
            },
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.AdcioSuggestionRawData>.value(
            _FakeAdcioSuggestionRawData_0(
          this,
          Invocation.method(
            #suggestion,
            [],
            {
              #sessionId: sessionId,
              #deviceId: deviceId,
              #customerId: customerId,
              #placementId: placementId,
              #placementPosX: placementPosX,
              #placementPosY: placementPosY,
              #fromAgent: fromAgent,
              #age: age,
              #gender: gender,
              #area: area,
            },
          ),
        )),
      ) as _i4.Future<_i2.AdcioSuggestionRawData>);
}
