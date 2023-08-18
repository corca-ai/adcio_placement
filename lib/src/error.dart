import 'package:flutter/services.dart';

class UnregisteredIdException extends PlatformException {
  UnregisteredIdException({
    super.code = 'BAD_REQUEST',
    super.message = 'placementID is not registered',
  });
}
