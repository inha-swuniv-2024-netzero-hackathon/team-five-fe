import 'package:flutter/material.dart';

Widget make_rating_shower(
    BuildContext context, double width, double height, int rating) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  double hPP = 1 / 844 * screenHeight;
  double wPP = 1 / 390 * screenWidth;

  return Container(
    width: width * wPP,
    height: height * hPP,
    child: Stack(children: [
      Container(
          width: width * wPP,
          height: height * hPP,
          decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(8))),
      Container(
        width: width * wPP * (rating / 100 - 1) / 4,
        height: height * hPP,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF2B544)),
      )
    ]),
  );
}
