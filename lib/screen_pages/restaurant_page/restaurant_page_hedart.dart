import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/restaurant_provider/restaurant_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:provider/provider.dart';

class RestaurantPageHeader extends StatefulWidget {
  final String uuid;
  const RestaurantPageHeader({super.key, required this.uuid});

  @override
  State<RestaurantPageHeader> createState() => _RestaurantPageHeaderState();
}

class _RestaurantPageHeaderState extends State<RestaurantPageHeader> {
  bool detailRating = false;
  late String uuid = widget.uuid;
  Future setBookmark(String uuid) async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) {
      return;
    }
    if (await checkLogin(context)) {
      changeBookmark(uuid);
      final url = Uri.parse('${rootURL}v1/restaurants/$uuid/bookmark/');
      final response = (context.watch<UserDataProvider>().token == null)
          ? await http.post(url)
          : await http.post(url, headers: {
              "Authorization": 'Bearer ${context.watch<UserDataProvider>().token}'
            });

      if (response.statusCode != 200) {
        changeBookmark(uuid);
      }
    }
  }

  void changeBookmark(String uuid) {
    if (context.read<UserDataProvider>().favRestaurantList.contains(uuid) == false) {
      if (mounted) {
        context.read<UserDataProvider>().addFavRestaurant(uuid);
      }
    } else {
      if (mounted) {
        context.read<UserDataProvider>().removeFavRestaurant(uuid);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantPageProvider =
        context.watch<RestaurantProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                          restaurantPageProvider.restaurantData.nameKorean,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 130),
                      child: Text(
                          restaurantPageProvider.restaurantData.nameNative,
                          maxLines: 1,
                          style: const TextStyle(
                              color: ColorStyles.silver,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            makeRatingShower(context, 115, 5,
                                restaurantPageProvider.restaurantData.rating),
                            const SizedBox(width: 11),
                            Text(
                              '${(restaurantPageProvider.restaurantData.rating) / 100}',
                              style: const TextStyle(
                                color: ColorStyles.yellow,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    detailRating ? const SizedBox() : const SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          detailRating = !detailRating;
                          setState(() {});
                        },
                        child: Icon(
                          detailRating
                              ? Icons.keyboard_arrow_left_outlined
                              : Icons.keyboard_arrow_down_outlined,
                          color: ColorStyles.gray,
                          size: 25,
                        ))
                  ],
                ),
              ],
            ),
            const Spacer(),
            favbutton(context),
            const Gap(30),
          ],
        ),
        detailRating
            ? Column(
                children: [
                  const Gap(8),
                  detailRatingShower(
                      context,
                      restaurantPageProvider.restaurantData.ratingTaste,
                      Icons.restaurant_menu),
                  detailRatingShower(
                      context,
                      restaurantPageProvider.restaurantData.ratingService,
                      Icons.handshake),
                  detailRatingShower(
                      context,
                      restaurantPageProvider.restaurantData.ratingPrice,
                      Icons.currency_yen),
                ],
              )
            : Container()
      ],
    );
  }

  Widget favbutton(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 45,
        height: 45,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(),
          shadows: [
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
        child: context.read<UserDataProvider>().favRestaurantList.contains(uuid)
            ? const Icon(
                Icons.bookmark,
                color: ColorStyles.red,
                size: 32,
              )
            : const Icon(
                Icons.bookmark_border_sharp,
                color: ColorStyles.black,
                size: 32,
              ),
      ),
      onTap: () {
        setBookmark(uuid);
      },
    );
  }

  Widget detailRatingShower(BuildContext context, int rating, IconData icon) {
    if (rating < 100) rating = 100;
    return SizedBox(
      width: 153,
      height: 26,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.topLeft, children: [
            Transform.translate(
                offset: const Offset(0, 6),
                child: makeRatingShower(context, 115, 5, rating)),
            Transform.translate(
              offset: Offset(100 * (rating / 100 - 1) / 4, 0),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
