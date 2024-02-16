import 'package:flutter/material.dart';

class ButtonStyles {
  ButtonStyles._();
  static const ButtonStyle transparenBtuttonStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      shadowColor: MaterialStatePropertyAll(Colors.transparent),
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      surfaceTintColor: MaterialStatePropertyAll(Colors.transparent));
}
