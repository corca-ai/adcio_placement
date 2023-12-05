import 'dart:ui';

import 'package:adcio_placement/src/gender.dart';

List<int>? convertListByOffset(Offset? offset) =>
    (offset is Offset) ? [offset.dx.toInt(), offset.dy.toInt()] : null;

Gender? convertGender(String? gender) {
  gender = gender?.toLowerCase();

  switch (gender) {
    case 'female':
    case 'f':
    case 'woman':
    case 'lady':
      return Gender.female;
    case 'male':
    case 'm':
    case 'man':
      return Gender.male;
    default:
      return null;
  }
}
