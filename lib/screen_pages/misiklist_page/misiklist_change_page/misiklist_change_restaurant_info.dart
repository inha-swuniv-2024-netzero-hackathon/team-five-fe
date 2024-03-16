import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class MisiklistChangeRestaurantInfo extends StatefulWidget {
  const MisiklistChangeRestaurantInfo({super.key});

  @override
  State<MisiklistChangeRestaurantInfo> createState() =>
      _MisiklistChangeRestaurantInfoState();
}

class _MisiklistChangeRestaurantInfoState
    extends State<MisiklistChangeRestaurantInfo> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 160),
            width: 300,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear))
                  ],
                ),
                const Icon(Icons.insert_comment_outlined, size: 30),
                const Text(
                  '가게에 대해 설명해주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 300,
                height: 40,
                decoration: const BoxDecoration(
                    color: ColorStyles.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: const Text('완 료',
                    style: TextStyle(
                        color: ColorStyles.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ))
        ],
      ),
    );
  }
}
