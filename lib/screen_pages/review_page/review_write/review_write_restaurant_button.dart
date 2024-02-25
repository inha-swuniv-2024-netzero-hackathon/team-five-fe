import 'package:flutter/material.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class ReviewWriteRestaurantButton extends StatefulWidget {
  const ReviewWriteRestaurantButton({super.key});

  @override
  State<ReviewWriteRestaurantButton> createState() =>
      _ReviewWriteRestaurantButtonState();
}

class _ReviewWriteRestaurantButtonState
    extends State<ReviewWriteRestaurantButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 125,
      child: Row(
        children: [
          Container(
            width: 108,
            child: Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: ShapeDecoration(
                    color: ColorStyles.red,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.70, color: Color(0xFF8E8E93)),
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  height: 77,
                  width: 77,
                  color: Colors.black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
