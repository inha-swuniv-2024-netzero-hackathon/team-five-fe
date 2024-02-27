import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/guide_provider/guide_page_provider.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
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
      width: 171,
      decoration: const BoxDecoration(
        color: ColorStyles.white,
        boxShadow: Boxshadows.defaultShadow,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RestaurantPage(uuid: restaurant.uuid)));
                  },
                  child: Container(
                    width: 171,
                    height: 151,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: Boxshadows.defaultShadow,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: ColorStyles.gray,
                      image: DecorationImage(
                        image: NetworkImage(restaurant.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 171,
                height: 28,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      child: SizedBox(
                        width: 110,
                        child: Text(
                          restaurant.name,
                          style: const TextStyle(
                            color: ColorStyles.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(0, 5),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () async {
                            bool isNetwork = await context
                                .read<NetworkProvider>()
                                .checkNetwork();
                            if (!isNetwork) {
                              return;
                            }
                            if (await checkLogin(context)) {
                              if (mounted) {
                                {
                                  if (await setRestaurantBookmark(
                                          context,
                                          context.read<UserData>().token!,
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
                          icon: (context
                                      .watch<UserData>()
                                      .favRestaurantList
                                      .contains(restaurant.uuid) ==
                                  false)
                              ? Transform.translate(
                                  offset: const Offset(0, -10),
                                  child: const Icon(Icons.bookmark_border_sharp,
                                      color: Colors.black, size: 30),
                                )
                              : Transform.translate(
                                  offset: const Offset(0, -10),
                                  child: const Icon(
                                    Icons.bookmark,
                                    color: ColorStyles.red,
                                    size: 30,
                                  ),
                                )),
                    )
                  ],
                )),
            (context.watch<GuidePageProvider>().sorting ==
                        SortState.sortRating ||
                    context.watch<GuidePageProvider>().sorting ==
                        SortState.sortThumb)
                ? Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 3, right: 4),
                        child: Icon(Icons.thumb_up,
                            size: 15, color: ColorStyles.black),
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
                          const Padding(
                            padding: EdgeInsets.only(left: 3, right: 4),
                            child: Icon(Icons.location_on,
                                color: ColorStyles.black, size: 15),
                          ),
                          Text(
                            '${(checkDistance(context.watch<UserData>().latitude, context.watch<UserData>().longitude, restaurant.latitude, restaurant.longitude)).toStringAsFixed(2)}km',
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
                            child: Icon(Icons.currency_yen, size: 15),
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
                      ),
            Container(
              width: 171,
              padding: const EdgeInsets.fromLTRB(7, 4, 0, 4),
              child: Row(
                children: [
                  makeRatingShower(context, 100, 4, restaurant.rating),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 23,
                    child: Text(
                      '${restaurant.rating / 100}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: ColorStyles.yellow,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Stack(
                    children: [
                      Icon(
                        isDetail
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_left_outlined,
                        color: Colors.black,
                      ),
                      Container(
                          width: 25,
                          height: 26,
                          color: Colors.transparent,
                          child: TextButton(
                            onPressed: () {
                              if (isDetail) {
                                isDetail = false;
                              } else {
                                isDetail = true;
                              }
                            },
                            style: ButtonStyles.transparenBtuttonStyle,
                            child: Container(),
                          )),
                    ],
                  )
                ],
              ),
            ),
            isDetail
                ? Column(
                    children: [
                      detailRatingShower(context, restaurant.ratingTaste,
                          Icons.restaurant_menu),
                      detailRatingShower(
                          context, restaurant.ratingService, Icons.handshake),
                      detailRatingShower(
                          context, restaurant.ratingPrice, Icons.currency_yen)
                    ],
                  )
                : Container(),
          ]),
        ],
      ),
    );
  }

  Widget detailRatingShower(BuildContext context, int rating, IconData icon) {
    if (rating < 100) rating = 100;
    return Container(
      width: 171,
      height: 26,
      padding: const EdgeInsets.fromLTRB(7, 4, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.topLeft, children: [
            makeRatingShower(context, 100, 4, rating),
            Transform.translate(
              offset: Offset(85 * (rating / 100 - 1) / 4, -7),
              child: Container(
                width: 16,
                height: 16,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: ColorStyles.yellow),
                  ),
                ),
                child: Icon(icon, color: ColorStyles.yellow, size: 10),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: SizedBox(
              width: 23,
              child: Text(
                '${rating / 100}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: ColorStyles.yellow,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
