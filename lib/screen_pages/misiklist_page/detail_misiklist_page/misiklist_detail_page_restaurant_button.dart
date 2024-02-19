import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/guide_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
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
  Widget build(BuildContext context) {
    MisiklistRestaurant restaurant = widget.restaurant;
    String? token = context.read<UserData>().token;
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width - 50,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              Row(
                children: [
                  Text(
                    (restaurant.name)
                        .substring(0, min(restaurant.name.length, 16)),
                    style: const TextStyle(
                      color: ColorStyles.black,
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    (restaurant.name)
                        .substring(0, min(restaurant.name.length, 1)),
                    style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const Gap(3),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 145,
                child: Row(
                  children: [
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
                          ]),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 15,
                            color: ColorStyles.black,
                          ),
                          Gap(2),
                          Text('0.1km')
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
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
                              size: 25, color: ColorStyles.red)
                          : const Icon(Icons.bookmark,
                              size: 25, color: ColorStyles.gray),
                    )
                  ],
                ),
              ),
              const Gap(5),
              Container(
                width: 183,
                height: 24,
                decoration: BoxDecoration(
                    color: ColorStyles.white,
                    borderRadius: BorderRadius.circular(90),
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
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          makeRatingShower(context, 115, 4, restaurant.rating),
                          Transform.translate(
                            offset: Offset(
                                100 * (restaurant.rating / 100 - 1) / 4, -5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: ColorStyles.yellow),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.star,
                                    color: ColorStyles.yellow, size: 15)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(restaurant.rating.toStringAsFixed(2))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
