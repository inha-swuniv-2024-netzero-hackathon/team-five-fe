import 'package:flutter/material.dart';

class Boxshadows {
  Boxshadows._();
  static const List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: Color(0x29000000),
      blurRadius: 3,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x15000000),
      blurRadius: 3,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];
}
