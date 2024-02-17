import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklog_class.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/detail_misiklist_page/misiklist_detail_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

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
        SizedBox(width: 15),
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

Widget misiklogButton(BuildContext context, Misiklog misiklog) {
  return Container(
    width: 171,
    height: 241,
    decoration: const BoxDecoration(
        boxShadow: Boxshadows.defaultShadow,
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 171,
            height: 131,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.grey,
              image: DecorationImage(
                  image: NetworkImage(misiklog.thumbnail), fit: BoxFit.fill),
            ),
            child: TextButton(
                style: ButtonStyles.transparenBtuttonStyle,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MisiklogDetailPage(misiklog: misiklog),
                      ));
                },
                child: Container()),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 7),
          width: 171,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 9),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 29,
                      height: 29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(misiklog.thumbnail),
                          fit: BoxFit.fill,
                        ),
                      )),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(misiklog.username),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(0, -6),
                    child: IconButton(
                        onPressed: () async {
                          if (await checkLogin(context)) {
                            setMisiklogBookmark(context, misiklog.uuid);
                          }
                        }, //
                        icon: Icon(
                          Icons.bookmark,
                          color: context
                                  .watch<MisiklistProvider>()
                                  .favMisiklogList
                                  .contains(misiklog.uuid)
                              ? ColorStyles.red
                              : Colors.grey,
                          size: 24,
                        )),
                  )
                ],
              ),
              Text(misiklog.title, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 5),
              const Text('글이 올 자리',
                  style: TextStyle(fontSize: 13, color: Color(0xff8E8E93))),
            ],
          ),
        )
      ],
    ),
  );
}
