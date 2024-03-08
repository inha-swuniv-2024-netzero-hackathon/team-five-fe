import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class MisiklistRemoveDialog extends StatefulWidget {
  const MisiklistRemoveDialog({super.key});

  @override
  State<MisiklistRemoveDialog> createState() => _MisiklistRemoveDialogState();
}

class _MisiklistRemoveDialogState extends State<MisiklistRemoveDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 310,
            height: 171,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.clear)),
                  ),
                ),
                Icon(Icons.error_outline, color: ColorStyles.red, size: 30),
                Gap(10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '1개 항목',
                        style: TextStyle(
                          color: Color(0xFFF25757),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '에 대해 삭제하시겠습니까?',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print('삭제');
            },
            child: Container(
              alignment: Alignment.center,
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                  color: ColorStyles.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Text(
                '삭제하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
