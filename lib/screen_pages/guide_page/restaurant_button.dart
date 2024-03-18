import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/guide_provider/guide_page_provider.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class RestaurantButton extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantButton({super.key, required this.restaurant});

  @override
  State<RestaurantButton> createState() => _RestaurantButtonState();
}

class _RestaurantButtonState extends State<RestaurantButton> {
  bool isDetail = false;
  @override
  Widget build(BuildContext context) {
    late Restaurant restaurant = widget.restaurant;
    return Container(
      height: 254,
      width: 180,
      decoration: const BoxDecoration(
        color: ColorStyles.white,
        boxShadow: Boxshadows.defaultShadow,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
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
                      builder: (context) =>
                          RestaurantPage(uuid: restaurant.uuid)));
            },
            child: Container(
              width: 166,
              height: 166,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                boxShadow: Boxshadows.defaultShadow,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: ColorStyles.gray,
                image: DecorationImage(
                  image: NetworkImage(restaurant.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
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
                    color: ColorStyles.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                  color: ColorStyles.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                        color: Color(0x29000000),
                        blurRadius: 2,
                        offset: Offset(0, 0.40),
                        spreadRadius: 0),
                  ]),
              child: GestureDetector(
                  onTap: () async {
                    bool isNetwork =
                        await context.read<NetworkProvider>().checkNetwork();
                    if (!isNetwork) return;
                    if (await checkLogin(context)) {
                      if (mounted) {
                        {
                          if (await setRestaurantBookmark(
                                  context,
                                  context.read<UserDataProvider>().token!,
                                  restaurant.uuid) !=
                              200) {
                            if (mounted) {
                              changeRestaurantBookmark(
                                  context, restaurant.uuid);
                            }
                          }
                        }
                      }
                    }
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: (context
                                .watch<UserDataProvider>()
                                .favRestaurantList
                                .contains(restaurant.uuid) ==
                            false)
                        ? ColorStyles.gray
                        : ColorStyles.red,
                    size: 18,
                  )),
            ),
            const Gap(10),
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                  color: ColorStyles.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                        color: Color(0x29000000),
                        blurRadius: 2,
                        offset: Offset(0, 0.40),
                        spreadRadius: 0),
                  ]),
              child: GestureDetector(
                onTap: () async {
                  bool isNetwork =
                      await context.read<NetworkProvider>().checkNetwork();
                  if (!isNetwork) return;
                  if (await checkLogin(context)) {
                    print('추가필요');
                  }
                },
                child: const Icon(Icons.add, color: ColorStyles.gray, size: 18),
              ),
            )
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
                  color: ColorStyles.white,
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
                      color: ColorStyles.yellow, size: 18),
                  Text(
                    (restaurant.rating / 100).toStringAsFixed(2),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: ColorStyles.black,
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
                    color: ColorStyles.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                    shadows: const [
                      BoxShadow(
                          color: Color(0x29000000),
                          blurRadius: 2,
                          offset: Offset(0, 0.40),
                          spreadRadius: 0)
                    ]),
                child: (context.watch<GuidePageProvider>().sorting ==
                            SortState.sortRating ||
                        context.watch<GuidePageProvider>().sorting ==
                            SortState.sortThumb)
                    ? Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 3, right: 4),
                            child: Icon(Icons.thumb_up,
                                size: 15, color: ColorStyles.red),
                          ),
                          Text(
                            '${restaurant.reviewCount}',
                            style: const TextStyle(
                                color: ColorStyles.black,
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    : context.read<GuidePageProvider>().sorting ==
                            SortState.sortDistance
                        ? Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: ColorStyles.green, size: 15),
                              Text(
                                '${(checkDistance(context.watch<UserDataProvider>().latitude, context.watch<UserDataProvider>().longitude, restaurant.latitude, restaurant.longitude)).toStringAsFixed(2)}km',
                                style: const TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 3, right: 4),
                                child: Icon(Icons.currency_yen,
                                    size: 15, color: ColorStyles.red),
                              ),
                              Text(
                                (DateTime.now().hour >= 14)
                                    ? '${restaurant.daytimePrice}'
                                    : '${restaurant.eveningPrice}',
                                style: const TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
          ],
        ),
      ]),
    );
  }
}
