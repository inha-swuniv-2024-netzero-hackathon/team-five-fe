import 'package:flutter/material.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class DefaultSearchMap extends StatefulWidget {
  const DefaultSearchMap({super.key});

  @override
  State<DefaultSearchMap> createState() => _DefaultSearchMapState();
}

class _DefaultSearchMapState extends State<DefaultSearchMap> {
  bool searchOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController findControlloer = TextEditingController();
    return Container(
      alignment: Alignment.topCenter,
      width: screenWidth,
      height: 50,
      child: Row(children: [
        const Spacer(),
        searchOpen
            ? Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(left: 25, right: 30),
                margin: const EdgeInsets.only(left: 15),
                width: 299,
                height: 36,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  shadows: Boxshadows.defaultShadow,
                ),
                child: TextField(
                    autofocus: true,
                    onTapOutside: (event) {
                      searchOpen = false;
                      setState(() {});
                    },
                    controller: findControlloer,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '스크립트에서 원하는 맛집을 찾아보세요',
                        hintStyle: TextStyle(
                          color: ColorStyles.black,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ))),
              )
            : Container(
                width: 36,
                height: 36,
                decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                    shadows: Boxshadows.defaultShadow,
                    color: Colors.white),
                clipBehavior: Clip.antiAlias,
                child: Stack(alignment: Alignment.center, children: [
                  const Icon(
                    Icons.search_outlined,
                    size: 24,
                    color: ColorStyles.black,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      searchOpen = true;
                      setState(() {});
                    },
                    style: ButtonStyles.transparenBtuttonStyle,
                    child: Container(),
                  )
                ])),
        const SizedBox(width: 15),
        Container(
            width: 36,
            height: 36,
            decoration: const ShapeDecoration(
                shape: OvalBorder(),
                shadows: Boxshadows.defaultShadow,
                color: Colors.white),
            clipBehavior: Clip.antiAlias,
            child: Stack(alignment: Alignment.center, children: [
              const Icon(
                Icons.map_outlined,
                size: 24,
                color: ColorStyles.black,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyles.transparenBtuttonStyle,
                child: Container(),
              )
            ])),
        const SizedBox(width: 20)
      ]),
    );
  }
}

Widget makeRatingShower(
    BuildContext context, double width, double height, int rating) {
  if (rating < 100) rating = 100;
  return SizedBox(
    width: width,
    height: height,
    child: Stack(children: [
      Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: ColorStyles.ash, borderRadius: BorderRadius.circular(8))),
      Container(
        width: width * (rating / 100 - 1) / 4,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: ColorStyles.yellow),
      )
    ]),
  );
}
