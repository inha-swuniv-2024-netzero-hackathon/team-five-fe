import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_restaurant_class.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/restaurant_provider/restaurant_page_provider.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page_hedart.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page_states/restaurant_page_map.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page_states/restaurant_page_menu.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page_states/restaurant_page_photo.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page_states/restaurant_page_review.dart';
import 'package:proto_just_design/screen_pages/review_page/review_write/review_write_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:proto_just_design/main.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatefulWidget {
  final String uuid;
  const RestaurantPage({Key? key, required this.uuid}) : super(key: key);
  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late String uuid = widget.uuid;
  String lastOrder = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> getRestaurantData() async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) return;

    String url = '${rootURL}v1/restaurants/$uuid';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      RestaurantDetail restaurant = RestaurantDetail(responseData);
      context.read<RestaurantPageProvider>().setRestaurant(restaurant);
    }
    setMarker();
    checkDay();
  }

  void setMarker() {
    RestaurantDetail restaurantData =
        context.read<RestaurantPageProvider>().restaurantData;
    final latitude = restaurantData.latitude!;
    final longitude = restaurantData.longitude!;
    context.read<RestaurantPageProvider>().addMarker(Marker(
        markerId: MarkerId(restaurantData.nameKorean),
        infoWindow: InfoWindow(title: restaurantData.nameKorean),
        position: LatLng(latitude, longitude)));
  }

  void checkDay() {
    String opening = '';

    int now = DateTime.now().weekday - 1;
    now = 1;
    List<String> weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    String day = weekdays[now];
    opening = '';
    //     '${restaurantData!.openingHour[day]['open']} ~ ${restaurantData!.openingHour[day]['close']}';
    // lastOrder = '${restaurantData!.openingHour[day]['last_order']}';
    context.read<RestaurantPageProvider>().setOpening(opening);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<RestaurantPageProvider>().cleardata();
      },
      child: FutureBuilder(
        future: getRestaurantData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          RestaurantPageProvider restaurantPageProvider =
              context.watch<RestaurantPageProvider>();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return Scaffold(
              floatingActionButton: restaurantPageProvider.state ==
                      RestaurantPageDetailState.review
                  ? SizedBox(
                      width: 70,
                      height: 70,
                      child: FloatingActionButton(
                        onPressed: () async {
                          await checkLogin(context).then((value) {
                            if (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewWritingPage(
                                      restaurantName: restaurantPageProvider
                                          .restaurantData.nameKorean,
                                      uuid: uuid,
                                    ),
                                  ));
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90)),
                        backgroundColor: ColorStyles.red,
                        child: const Icon(Icons.create_outlined,
                            color: Colors.white, size: 40),
                      ),
                    )
                  : Container(),
              body: SingleChildScrollView(
                  child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(children: [
                  const SizedBox(height: 30),
                  RestaurantPageHeader(uuid: uuid),
                  const SizedBox(height: 24),
                  infoDetail(context),
                  restaurantPageStoreInfoList(context),
                  const SizedBox(height: 20),
                  restaurantPagestates(context)
                ]),
              )),
            );
          }
        },
      ),
    );
  }

  Widget infoDetail(BuildContext context) {
    RestaurantPageProvider restaurantPageProvider =
        context.watch<RestaurantPageProvider>();
    return Column(children: [
      Row(
        children: [
          const Icon(Icons.timer_outlined, size: 16),
          const SizedBox(width: 9),
          Text(restaurantPageProvider.opening,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(width: 9),
          Text(
            'L.O $lastOrder',
            style: const TextStyle(
                color: ColorStyles.silver,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
      const SizedBox(height: 14),
      Row(
        children: [
          const Icon(Icons.location_on_outlined, size: 20),
          const SizedBox(width: 9),
          SizedBox(
            width: 220,
            child: Text(restaurantPageProvider.restaurantData.addressNative,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      const SizedBox(height: 14),
      Row(
        children: [
          const Icon(Icons.phone_callback_outlined, size: 20),
          const Gap(9),
          Text(restaurantPageProvider.restaurantData.telephoneNumber,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
      const SizedBox(height: 14),
      const Row(
        children: [
          Icon(Icons.currency_yen_outlined, size: 20),
          Gap(9),
          Text('시작 가격 - 끝 가격',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
      // const SizedBox(height: 10),
      // Align(
      //   alignment: Alignment.centerLeft,
      //   child: Stack(
      //     children: [
      //       Container(
      //         width: 25,
      //         height: 25,
      //         decoration: ShapeDecoration(
      //           color: Colorstyles().redColor,
      //           shape: const OvalBorder(),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      const SizedBox(height: 37),
    ]);
  }

  Widget restaurantPageStoreInfoList(BuildContext context) {
    return Row(
      children: [
        listButton(context, '메뉴', RestaurantPageDetailState.menu),
        const SizedBox(width: 10),
        listButton(context, '리뷰', RestaurantPageDetailState.review),
        const SizedBox(width: 10),
        listButton(context, '사진', RestaurantPageDetailState.photo),
        const SizedBox(width: 10),
        listButton(context, '지도', RestaurantPageDetailState.map)
      ],
    );
  }

  Widget restaurantPagestates(BuildContext context) {
    RestaurantPageProvider restaurantPageProvider =
        context.watch<RestaurantPageProvider>();
    switch (restaurantPageProvider.state) {
      case RestaurantPageDetailState.menu:
        return const RestaurantPageMenu();
      case RestaurantPageDetailState.review:
        return RestaurantPageReview(uuid: uuid);
      case RestaurantPageDetailState.photo:
        return RestaurantPagePhoto(uuid: uuid);
      case RestaurantPageDetailState.map:
        return const RestaurantPageMap();
      default:
        return const RestaurantPageMenu();
    }
  }

  Widget listButton(
      BuildContext context, String text, RestaurantPageDetailState state) {
    RestaurantPageProvider restaurantPageProvider =
        context.watch<RestaurantPageProvider>();
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 44,
      height: 21,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Colors.white,
          boxShadow: Boxshadows.defaultShadow),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: restaurantPageProvider.state == state
                    ? ColorStyles.red
                    : ColorStyles.black,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
              style: ButtonStyles.transparenBtuttonStyle,
              onPressed: () {
                restaurantPageProvider.changeState(state);
              },
              child: Container()),
        ],
      ),
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
