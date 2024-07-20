import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/appColors.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';
import 'package:proto_just_design/screen_pages/guide_page/guidePState.dart';
import 'package:proto_just_design/screen_pages/guide_page/guide_page_map.dart';
import 'package:proto_just_design/screen_pages/guide_page/square_restaurant_button.dart';
import 'package:proto_just_design/view_model/guide_page/guidePage.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';

class GuidePage extends ConsumerStatefulWidget {
  const GuidePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuidePageState();
}

class _GuidePageState extends ConsumerState<GuidePage> {
  FocusNode focusNode = FocusNode();
  bool isFirst = true;
  ScrollController listViewController = ScrollController();
  TextEditingController findControlloer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GuidePageVM guidePController = ref.read(guidePageProvider.notifier);
    GuidePInfo guidePInfo = ref.watch(guidePageProvider);
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      child: Stack(
        children: [
          const GuidePageMap(),
          restaurantListModal(context, guidePInfo, guidePController),
          Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Gap(20),
                  search(),
                ],
              )),
        ],
      ),
    );
  }

  Widget search() {
    return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(left: 15, right: 10),
        width: 300,
        height: 36,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            shadows: Boxshadows.defaultShadow),
        child: Row(
          children: [
            SizedBox(
              width: 250,
              child: Transform.translate(
                offset: const Offset(0, -7),
                child: TextField(
                    focusNode: focusNode,
                    onTapOutside: (_) {
                      focusNode.unfocus();
                    },
                    onSubmitted: (value) {},
                    onEditingComplete: () {},
                    controller: findControlloer,
                    style: const TextStyle(decorationThickness: 0),
                    cursorHeight: 0.1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '페이지에서 원하는 가게를 찾아보세요',
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(1),
                            fontSize: 12,
                            fontWeight: FontWeight.w400))),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.search),
            )
          ],
        ));
  }

  Widget restaurantListModal(BuildContext context, GuidePInfo guidePInfo,
      GuidePageVM guidePcontroller) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      child: DraggableScrollableSheet(
        snapAnimationDuration: const Duration(milliseconds: 200),
        initialChildSize: 0.13,
        minChildSize: 0.13,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                height: screenHeight * 0.85 - 60,
                decoration: BoxDecoration(
                    boxShadow: Boxshadows.defaultShadow,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Container(
                        width: 30,
                        height: 5,
                        decoration: ShapeDecoration(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    header(context, guidePInfo, guidePcontroller),
                    body(context, screenHeight * 0.85 - 145, guidePInfo,
                        guidePcontroller)
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget header(BuildContext context, GuidePInfo guidePInfo,
      GuidePageVM guidePController) {
    return Container(
        alignment: Alignment.topCenter,
        height: 40,
        child: Row(children: [
          const Gap(25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    ref.read(guidePageProvider.notifier).getDistance();
                    ref.read(sortStateProvdier.notifier).setDistance();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: ShapeDecoration(
                        color: ref.watch(sortStateProvdier) == 0
                            ? Colors.white
                            : Colors.grey,
                        shadows: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 2,
                            offset: Offset(0, 0.40),
                            spreadRadius: 0,
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90))),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: greenAppcolor, size: 20),
                        const Gap(3),
                        const Text(
                          '거리순',
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  )),
              const Gap(20),
              GestureDetector(
                  onTap: () {
                    ref.read(guidePageProvider.notifier).getScore();
                    ref.read(sortStateProvdier.notifier).setScore();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: ShapeDecoration(
                        color: ref.watch(sortStateProvdier) == 1
                            ? Colors.white
                            : Colors.grey,
                        shadows: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 2,
                            offset: Offset(0, 0.40),
                            spreadRadius: 0,
                          )
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90))),
                    width: 100,
                    height: 30,
                    child: Row(
                      children: [
                        Icon(Icons.favorite, color: redAppcolor, size: 16),
                        const Gap(5),
                        const Text(
                          '추천순',
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ]));
  }

  Widget body(BuildContext context, double height, GuidePInfo guidePInfo,
      GuidePageVM guidePController) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: height,
        width: screenWidth,
        alignment: Alignment.center,
        child: ListView.builder(
            controller: listViewController,
            itemCount: guidePInfo.restList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == guidePInfo.restList.length) {
                return const SizedBox(height: 40);
              }
              if ((index % 2 == 0)) {
                if ((guidePInfo.restList.length % 2 == 1) &&
                    (index + 2 > guidePInfo.restList.length)) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SquareRestaurantButton(guidePInfo.restList[index]),
                      const Gap(20),
                      Container(width: 171)
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SquareRestaurantButton(guidePInfo.restList[index]),
                    const Gap(20),
                    SquareRestaurantButton(guidePInfo.restList[index + 1])
                  ],
                );
              }

              return const SizedBox(height: 10);
            }));
  }
}
