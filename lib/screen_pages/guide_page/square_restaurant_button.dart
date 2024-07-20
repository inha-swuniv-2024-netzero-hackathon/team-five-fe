import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/favlist.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:proto_just_design/model/global/user.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';
import 'package:proto_just_design/screen_pages/detail_shop/shopScreen.dart';
import 'package:proto_just_design/view_model/global/userVM.dart';
import 'package:proto_just_design/view_model/guide_page/guidePage.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';

class SquareRestaurantButton extends ConsumerStatefulWidget {
  final Restaurant restaurant;
  const SquareRestaurantButton(this.restaurant, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SquareRestaurantButtonState();
}

class _SquareRestaurantButtonState
    extends ConsumerState<SquareRestaurantButton> {
  bool isDetail = false;
  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = ref.watch(userProvider);
    var userController = ref.read(userProvider.notifier);
    GuidePageVM guidePageController = ref.read(guidePageProvider.notifier);
    GuidePInfo guidePInfo = ref.watch(guidePageProvider);
    late Restaurant restaurant = widget.restaurant;
    return Container(
      height: 254,
      width: 180,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: Boxshadows.defaultShadow,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Shopscreen(restaurant)));
            },
            child: Container(
              width: 166,
              height: 166,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  boxShadow: Boxshadows.defaultShadow,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey,
                  image: DecorationImage(image: NetworkImage(restaurant.url))),
            ),
          ),
        ),
        const Gap(5),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: SizedBox(
                width: 110,
                child: Text(
                  restaurant.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              height: 23,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      blurRadius: 2,
                      offset: Offset(0, 0.40),
                      spreadRadius: 0,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star_rounded,
                      color: Colors.yellow, size: 18),
                  Text(
                    (restaurant.rating).toStringAsFixed(0),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                height: 23,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                    shadows: const [
                      BoxShadow(
                          color: Color(0x29000000),
                          blurRadius: 2,
                          offset: Offset(0, 0.40),
                          spreadRadius: 0)
                    ]),
                child: GestureDetector(
                  onTap: () {
                    ref.read(favProvider.notifier).setFav(restaurant.uuid);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3, right: 4),
                        child: Row(
                          children: [
                            Icon(Icons.favorite,
                                size: 15,
                                color: ref
                                        .watch(favProvider)
                                        .contains(restaurant.uuid)
                                    ? Colors.red
                                    : Colors.grey),
                            Text(ref
                                    .watch(favProvider)
                                    .contains(restaurant.uuid)
                                ? '${((restaurant.rating * 100 - int.parse(restaurant.uuid) * 23 + 1).toStringAsFixed(0))}'
                                : '${((restaurant.rating * 100 - int.parse(restaurant.uuid) * 23).toStringAsFixed(0))}')
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ]),
    );
  }
}
