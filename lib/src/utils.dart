import 'dart:ui';

List<int>? convertListByOffset(Offset? offset) =>
    (offset is Offset) ? [offset.dx.toInt(), offset.dy.toInt()] : null;
