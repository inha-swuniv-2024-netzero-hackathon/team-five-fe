import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/detail_misiklist_provider.dart';
import 'package:proto_just_design/providers/guide_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class DetailMisiklistRestaurantButton extends StatefulWidget {
  final MisiklistRestaurant restaurant;
  const DetailMisiklistRestaurantButton({super.key, required this.restaurant});

  @override
  State<DetailMisiklistRestaurantButton> createState() =>
      _DetailMisiklistRestaurantButtonState();
}

class _DetailMisiklistRestaurantButtonState
    extends State<DetailMisiklistRestaurantButton> {
  @override
  void initState() {
    print(context.read<UserData>().latitude);
    print(widget.restaurant.latitude);
    print(context.read<UserData>().longitude);
    print(widget.restaurant.longitude);
    super.initState();
  }

  bool isLong = false;
  @override
  Widget build(BuildContext context) {
    MisiklistRestaurant restaurant = widget.restaurant;
    String? token = context.read<UserData>().token;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        isLong
            ? Container(
                height: 210,
                width: MediaQuery.sizeOf(context).width - 50,
                margin: const EdgeInsets.only(bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: ColorStyles.gray),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(105),
                    Text(
                        maxLines: 4,
                        restaurant.memo,
                        style: const TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left)
                  ],
                ),
              )
            : Container(),
        Container(
          height: 105,
          width: MediaQuery.sizeOf(context).width - 50,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 7,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorStyles.white,
            boxShadow: const [
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
            ],
          ),
          child: Row(
            children: [
              Container(
                  width: 85,
                  height: 85,
                  decoration: ShapeDecoration(
                      color: ColorStyles.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      image: DecorationImage(
                        image: NetworkImage(restaurant.thumbnail),
                        fit: BoxFit.cover,
                      ))),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          (restaurant.name)
                              .substring(0, min(restaurant.name.length, 12)),
                          style: const TextStyle(
                            color: ColorStyles.black,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                        ),
                        const Gap(8),
                        Text(
                          (restaurant.name)
                              .substring(0, min(restaurant.name.length, 0)),
                          style: const TextStyle(
                              color: Color(0xFF8E8E93),
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x29000000),
                                blurRadius: 2,
                                offset: Offset(0, 0.40),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              if (await checkLogin(context)) {
                                if (mounted) {
                                  if (await setRestaurantBookmark(
                                          context, token!, restaurant.uuid) !=
                                      200) {
                                    if (mounted) {
                                      changeRestaurantBookmark(
                                          context, restaurant.uuid);
                                    }
                                  }
                                }
                              }
                            },
                            child: (context
                                    .watch<GuidePageProvider>()
                                    .favRestaurantList
                                    .contains(restaurant.uuid))
                                ? const Icon(Icons.bookmark,
                                    size: 22, color: ColorStyles.red)
                                : const Icon(Icons.bookmark,
                                    size: 22, color: ColorStyles.ash),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              color: ColorStyles.white,
                              borderRadius: BorderRadius.circular(90),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x29000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 0.40),
                                  spreadRadius: 0,
                                )
                              ]),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: ColorStyles.yellow),
                              const Gap(3),
                              Text(
                                  (restaurant.rating ~/ 100).toStringAsFixed(2))
                            ],
                          ),
                        ),
                        const Gap(10),
                        Container(
                          height: 23,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              color: ColorStyles.white,
                              borderRadius: BorderRadius.circular(90),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x29000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 0.40),
                                  spreadRadius: 0,
                                )
                              ]),
                          child:
                              context.watch<MisiklistDetailProvider>().sort ==
                                      SortState.sortDistance
                                  ? Row(
                                      children: [
                                        SortState.sortDistance.icon,
                                        const Gap(3),
                                        Text(
                                            '${(checkDistance(context.read<UserData>().latitude, context.read<UserData>().longitude, restaurant.latitude!, restaurant.longitude!)).toStringAsFixed(2)}km')
                                      ],
                                    )
                                  : Row(children: [
                                      SortState.sortThumb.icon,
                                      const Gap(3),
                                      Text(
                                          '${(widget.restaurant.rating / 100).toDouble()}')
                                    ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  isLong = !isLong;
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: const Icon(Icons.keyboard_arrow_down_outlined,
                      color: ColorStyles.gray, size: 30),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
