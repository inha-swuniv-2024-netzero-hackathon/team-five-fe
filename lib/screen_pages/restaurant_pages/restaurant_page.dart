import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_restaurant_class.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/screen_pages/review_page/review_write_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:proto_just_design/providers/custom_provider.dart';
import 'package:proto_just_design/main.dart';
import 'package:provider/provider.dart';
import 'restaurant_page_detail_state.dart';

enum RestaurantPageDetailState { menu, review, photo, map }

class RestaurantPage extends StatefulWidget {
  final String uuid;
  const RestaurantPage({Key? key, required this.uuid}) : super(key: key);
  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  String? token;
  late String uuid = widget.uuid;
  RestaurantDetail? restaurantData;
  Enum restaurantPageState = RestaurantPageDetailState.menu;
  Set<Marker> markers = <Marker>{};
  List<dynamic> restaurantreviews = [];
  List<String> restaurantPhotos = [];
  int photoCount = 1;
  String opening = '';
  String lastOrder = '';
  bool detailRating = false;

  @override
  void initState() {
    super.initState();
    token = context.read<UserData>().userToken;
    getRestaurantData().then((value) => setRestaurantData());
  }

  void setRestaurantData() {
    setMarker();
    checkDay();
  }

  Future<void> getRestaurantData() async {
    String url = '${rootURL}v1/restaurants/restaurants/$uuid';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      restaurantData = RestaurantDetail(responseData);
      if (mounted) {
        setState(() {});
      }
    }
  }

  getRestaurantReview() async {
    if (restaurantreviews.isEmpty) {
      String url = '${rootURL}v1/restaurants/restaurants/$uuid/reviews/';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic>? responseData =
            json.decode(utf8.decode(response.bodyBytes));
        if (responseData != null) {
          restaurantreviews = responseData;
          if (mounted) {
            setState(() {});
          }
        }
      }
    }
  }

  getRestaurantPhoto() async {
    if (restaurantreviews.isEmpty) {
      String url = '${rootURL}v1/restaurants/restaurants/$uuid/image/';
      final response = await http.get(Uri.parse(url)
          .replace(queryParameters: <String, dynamic>{'page': '$photoCount'}));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> photolist = responseData['results'];
        restaurantPhotos = photolist
            .where((map) => map.containsKey('photo_file'))
            .map((map) => map['photo_file'])
            .cast<String>()
            .toList();
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  void setMarker() {
    if (mounted) {
      final latitude = restaurantData!.latitude!;
      final longitude = restaurantData!.longitude!;
      markers.add(Marker(
          markerId: MarkerId('${restaurantData?.nameKorean}'),
          infoWindow: InfoWindow(title: '${restaurantData?.nameKorean}'),
          position: LatLng(latitude, longitude)));
      setState(() {});
    }
  }

  Future setBookmark(String uuid) async {
    if (await checkLogin(context)) {
      changeBookmark(uuid);
      final url =
          Uri.parse('${rootURL}v1/restaurants/restaurants/$uuid/bookmark/');
      final response = (token == null)
          ? await http.post(url)
          : await http.post(url, headers: {"Authorization": 'Bearer $token'});

      if (response.statusCode != 200) {
        changeBookmark(uuid);
      } else {}
    }
  }

  void changeBookmark(String uuid) {
    if (context.read<GuidePageData>().favRestaurantList.contains(uuid) ==
        false) {
      if (mounted) {
        context.read<GuidePageData>().addFavRestaurant(uuid);
        setState(() {});
      }
    } else {
      if (mounted) {
        context.read<GuidePageData>().removeFavRestaurant(uuid);
        setState(() {});
      }
    }
  }

  void checkDay() {
    int now = DateTime.now().weekday;
    List<String> weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    String day = weekdays[now];
    opening =
        '${restaurantData!.openingHour[day]['open']} ~ ${restaurantData!.openingHour[day]['close']}';
    lastOrder = '${restaurantData!.openingHour[day]['last_order']}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: restaurantPageState ==
              RestaurantPageDetailState.review
          ? SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () async {
                  if (await checkLogin(context)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewWritingPage(
                            restaurantName: restaurantData?.nameKorean ?? '',
                            uuid: uuid,
                          ),
                        ));
                  }
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
          restaurantPageHeader(context),
          const SizedBox(height: 24),
          restaurantPageStoreDetail(context),
          restaurantPageStoreInfoList(context),
          const SizedBox(height: 20),
          restaurantPagestates(context)
        ]),
      )),
    );
  }

  Widget restaurantPageHeader(BuildContext context) {
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
                      child: Text(restaurantData?.nameKorean ?? 'None',
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 130),
                      child: Text(restaurantData?.nameNative ?? 'None',
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
                            restaurantData != null
                                ? makeRatingShower(context, 115, 5,
                                    restaurantData?.rating ?? 0)
                                : Container(),
                            const SizedBox(width: 11),
                            Text(
                              '${(restaurantData?.rating ?? 0) / 100}',
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
                  detailRatingShower(context, restaurantData!.ratingTaste,
                      Icons.restaurant_menu),
                  detailRatingShower(
                      context, restaurantData!.ratingService, Icons.handshake),
                  detailRatingShower(
                      context, restaurantData!.ratingPrice, Icons.currency_yen),
                ],
              )
            : Container()
      ],
    );
  }

  Widget restaurantPageStoreDetail(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          const Icon(Icons.timer_outlined, size: 16),
          const SizedBox(width: 9),
          Text(opening,
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
            child: Text('${restaurantData?.addressNative}',
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
          Text('${restaurantData?.telephoneNumber}',
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
        listButton(context, '리뷰', RestaurantPageDetailState.review,
            onPressed: () async {
          await getRestaurantReview();
        }),
        const SizedBox(width: 10),
        listButton(context, '사진', RestaurantPageDetailState.photo,
            onPressed: () async {
          await getRestaurantPhoto();
        }),
        const SizedBox(width: 10),
        listButton(context, '지도', RestaurantPageDetailState.map)
      ],
    );
  }

  Widget restaurantPagestates(BuildContext context) {
    switch (restaurantPageState) {
      case RestaurantPageDetailState.menu:
        return restaurantPageMenuState(context);
      case RestaurantPageDetailState.review:
        return restaurantPageReviewState(
          context,
          restaurantreviews,
        );
      case RestaurantPageDetailState.photo:
        return restaurantPagePhotoState(context, restaurantPhotos);
      case RestaurantPageDetailState.map:
        return restaurantPageMapState(
            context,
            restaurantData?.latitude ??
                context.read<GuidePageData>().focusArea.latitude,
            restaurantData?.longitude ??
                context.read<GuidePageData>().focusArea.longitude,
            markers);
      default:
        return restaurantPageMenuState(context);
    }
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
        child: context.read<GuidePageData>().favRestaurantList.contains(uuid)
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
      onTap: () {},
    );
  }

  Widget listButton(
      BuildContext context, String text, RestaurantPageDetailState state,
      {VoidCallback? onPressed}) {
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
                color: restaurantPageState == state
                    ? ColorStyles.red
                    : ColorStyles.black,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
              style: ButtonStyles.transparenBtuttonStyle,
              onPressed: () {
                onPressed?.call();
                restaurantPageState = state;
                setState(() {});
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
