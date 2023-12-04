import 'package:flutter/services.dart';

class UnregisteredIdException extends PlatformException {
  UnregisteredIdException({
    super.code = 'PLACEMENT_NOT_FOUND',
    super.message = 'placementID is not registered',
  });
}

class DisabledPlacementException extends PlatformException {
  DisabledPlacementException({
    super.code = 'PLACEMENT_NOT_ACTIVATED',
    super.message = 'The placement is not active',
  });
}

class BadRequestException extends PlatformException {
  BadRequestException({
    super.code = 'BAD_REQUEST',
    required super.message,
  });
}
