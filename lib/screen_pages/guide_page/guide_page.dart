import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/guide_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/guide_page/change_area.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/screen_pages/restaurant_page/restaurant_page.dart';
import 'package:provider/provider.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  ScrollController listViewController = ScrollController();
  bool searchOpen = false;
  TextEditingController findControlloer = TextEditingController();
  String? token;
  String? next;

  bool withMap = false;
  List<String> restaurantStarDetail = [];
  LocationList area = LocationList.area1;
  int areaNum = 1;
  List<Restaurant> restaurantList = [];
  Set<Marker> markers = <Marker>{};

  makeMarker() {
    if (mounted) {
      final focusArea = context.read<GuidePageProvider>().focusArea;

      markers.add(Marker(
          markerId: MarkerId('${focusArea.bigArea} ${focusArea.smallArea}'),
          infoWindow:
              InfoWindow(title: '${focusArea.bigArea}${focusArea.smallArea}'),
          position: LatLng(focusArea.latitude, focusArea.longitude)));

      setState(() {});
    }
  }

  Future<void> getRestaurantList() async {
    final url = Uri.parse(next ??
        '${rootURL}v1/restaurants/restaurants/?area__id=$areaNum&ordering=restaurant_info__rating&page=1');
    next = null;
    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      print('suc');
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      final resposeRestaurantList = responseData['results'];
      next = responseData['next'];
      print(next);
      for (var restaurantData in resposeRestaurantList) {
        Restaurant restaurant = Restaurant(restaurantData);
        restaurantList.add(restaurant);
        if (restaurant.isBookmarked == true) {
          if (mounted) {
            context.read<GuidePageProvider>().addFavRestaurant(restaurant.uuid);
          }
        }
      }
      if (mounted) {
        context.read<GuidePageProvider>().changeData(restaurantList);
        setState(() {});
      }
    } else if (response.statusCode == 401) {
      if (mounted) {
        // if (!context.read<UserData>().isLogin) {}
      }
    }
    print(restaurantList.length);
  }

  void setRestaurantMarker() {
    for (Restaurant restaurant in restaurantList) {
      markers.add(Marker(
          markerId: MarkerId(restaurant.name),
          infoWindow: InfoWindow(title: restaurant.name),
          position: LatLng(restaurant.latitude, restaurant.longitude)));
    }
  }

  void sortByRating() {
    restaurantList.sort((preRestaurant, postRestaurant) =>
        postRestaurant.rating.compareTo(preRestaurant.rating));
    if (mounted) {
      setState(() {});
      print('별점 정렬');
    }
  }

  void sortByDistance() {
    final userData = context.read<UserData>();
    restaurantList.sort((preRestaurant, postRestaurant) => checkDistance(
            userData.latitude,
            userData.longitude,
            preRestaurant.latitude,
            preRestaurant.longitude)
        .compareTo(checkDistance(userData.latitude, userData.longitude,
            postRestaurant.latitude, postRestaurant.longitude)));
    if (mounted) {
      setState(() {});
      print('거리 정렬');
    }
  }

  void sortByReviews() {
    restaurantList.sort((preRestaurant, postRestaurant) =>
        postRestaurant.ratingCount.compareTo(preRestaurant.ratingCount));
    if (mounted) {
      setState(() {});
      print('리뷰수 정렬');
    }
  }

  void setToken() {
    final getToken = context.read<UserData>().token;
    if (getToken != null) {
      token = getToken;
    }
  }

  Future<void> _scrollListener() async {
    // print(restaurantList.length);
    if ((listViewController.position.pixels ==
            listViewController.position.maxScrollExtent) &&
        (next != null)) {
      await getRestaurantList();
      if (mounted) {
        setState(() {});
      }
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    setToken();
    makeMarker();
    areaNum = context.read<GuidePageProvider>().focusArea.areaNum;
    listViewController.addListener(() {
      _scrollListener();
    });

    if (context.read<GuidePageProvider>().guidePageRestaurants.isEmpty) {
      getRestaurantList().then((value) => setRestaurantMarker());
    } else {
      restaurantList = context.read<GuidePageProvider>().guidePageRestaurants;
      setRestaurantMarker();
      if (mounted) {
        setState(() {});
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      child: Stack(
        children: [
          backgroundMap(context),
          restaurantListModal(context),
          Column(
            children: [const Gap(30), upperButtons(context)],
          ),
        ],
      ),
    );
  }

  Widget backgroundMap(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final guidePageData = context.read<GuidePageProvider>();
    return SizedBox(
        height: screenHeight * 0.85,
        child: GoogleMap(
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: markers,
            initialCameraPosition: CameraPosition(
                target: LatLng(guidePageData.focusArea.latitude,
                    guidePageData.focusArea.longitude),
                zoom: 16),
            //스크롤 우선권 부여 코드
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
            mapType: MapType.normal));
  }

  Widget upperButtons(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 50,
      child: Row(children: [
        const Spacer(),
        (searchOpen || withMap)
            ? Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(left: 25, right: 30),
                margin: const EdgeInsets.only(left: 15),
                width: 299,
                height: 36,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                    shadows: Boxshadows.defaultShadow),
                child: TextField(
                    autofocus: searchOpen,
                    onTapOutside: (event) {
                      searchOpen = false;
                      setState(() {});
                    },
                    controller: findControlloer,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '페이지에서 원하는 맛집을 찾아보세요',
                        hintStyle: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400))))
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
        const Gap(15),
        (withMap == false)
            ? Container(
                width: 36,
                height: 36,
                decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                    shadows: Boxshadows.defaultShadow,
                    color: Colors.white),
                clipBehavior: Clip.antiAlias,
                child: Stack(alignment: Alignment.center, children: [
                  const Icon(Icons.map_outlined,
                      size: 24, color: ColorStyles.black),
                  ElevatedButton(
                      onPressed: () {
                        withMap = true;
                        setState(() {});
                      },
                      style: ButtonStyles.transparenBtuttonStyle,
                      child: Container())
                ]))
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
                    Icons.keyboard_arrow_left_outlined,
                    size: 24,
                    color: ColorStyles.black,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      withMap = false;
                      setState(() {});
                    },
                    style: ButtonStyles.transparenBtuttonStyle,
                    child: Container(),
                  )
                ])),
        const Gap(20)
      ]),
    );
  }

  Widget restaurantListModal(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      child: DraggableScrollableSheet(
        snapAnimationDuration: const Duration(milliseconds: 200),
        initialChildSize: withMap ? 0.85 : 1,
        minChildSize: withMap ? 0.05 : 1,
        maxChildSize: withMap ? 0.85 : 1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: withMap ? scrollController : null,
              child: Container(
                height: withMap ? screenHeight * 0.85 - 58 : screenHeight * 0.9,
                decoration: BoxDecoration(
                    boxShadow: Boxshadows.defaultShadow,
                    border: Border.all(color: ColorStyles.ash),
                    borderRadius: withMap
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))
                        : null,
                    color: ColorStyles.white),
                child: Column(
                  children: [
                    withMap
                        ? Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Container(
                              width: 30,
                              height: 5,
                              decoration: ShapeDecoration(
                                color: ColorStyles.gray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          )
                        : const Gap(50),
                    guidePageHeader(context), //110
                    guidePageBody(
                        context,
                        withMap
                            ? screenHeight * 0.85 - 210
                            : screenHeight * 0.9 - 162)
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget guidePageHeader(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        height: 110,
        child: Column(
          children: [
            Row(children: [
              const Gap(25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangeArea()));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 30, color: ColorStyles.red),
                        Row(
                          children: [
                            Text(
                                context
                                    .watch<GuidePageProvider>()
                                    .focusArea
                                    .bigArea,
                                style: const TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                )),
                            const Gap(8),
                            Text(
                                context
                                    .watch<GuidePageProvider>()
                                    .focusArea
                                    .smallArea,
                                style: const TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (context.read<GuidePageProvider>().sorting ==
                          RestaurantSortStandard.sortRating) {
                        sortByDistance();
                        context.read<GuidePageProvider>().changeSortingStandard(
                            RestaurantSortStandard.sortDistance);
                      } else if (context.read<GuidePageProvider>().sorting ==
                          RestaurantSortStandard.sortDistance) {
                        sortByReviews();
                        context.read<GuidePageProvider>().changeSortingStandard(
                            RestaurantSortStandard.sortReview);
                      } else {
                        sortByRating();
                        context.read<GuidePageProvider>().changeSortingStandard(
                            RestaurantSortStandard.sortRating);
                      }
                    },
                    child: Row(
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            Icon(context.read<GuidePageProvider>().sorting.icon),
                            const Gap(3),
                            Text(
                              context.read<GuidePageProvider>().sorting.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorStyles.black,
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Icon(Icons.expand_more,
                                color: ColorStyles.gray, size: 22)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ],
        ));
  }

  Widget guidePageBody(BuildContext context, double height) {
    final screenWidth = MediaQuery.of(context).size.width;
    int len = restaurantList.length;
    return Container(
        height: height,
        width: screenWidth,
        alignment: Alignment.center,
        child: ListView.builder(
            controller: listViewController,
            itemCount: len + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == len) {
                return const SizedBox(height: 40);
              }
              if ((index % 2 == 0)) {
                if ((len % 2 == 1) && (index + 2 > len)) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      restaurantButton(context, restaurantList[index]),
                      const Gap(20),
                      Container(width: 171)
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    restaurantButton(context, restaurantList[index]),
                    const Gap(20),
                    restaurantButton(context, restaurantList[index + 1])
                  ],
                );
              }

              return const SizedBox(height: 10);
            }));
  }

  Widget restaurantButton(BuildContext context, Restaurant restaurant) {
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
                Container(
                  width: 171,
                  height: 151,
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
                TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RestaurantPage(uuid: restaurant.uuid)));
                  },
                  style: ButtonStyles.transparenBtuttonStyle,
                  child: const SizedBox(
                    width: 171,
                    height: 138,
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
                            final check = await checkLogin(context);
                            if (check) {
                              setRestaurantBookmark(
                                  context, token!, restaurant.uuid);
                            }
                          },
                          icon: (context
                                      .watch<GuidePageProvider>()
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
            Row(
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
                    fontWeight: FontWeight.w400,
                  ),
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
                        restaurantStarDetail.contains(restaurant.uuid) == true
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
                              if (restaurantStarDetail
                                  .contains(restaurant.uuid)) {
                                restaurantStarDetail.remove(restaurant.uuid);
                                setState(() {});
                              } else {
                                restaurantStarDetail.add(restaurant.uuid);
                                setState(() {});
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
            restaurantStarDetail.contains(restaurant.uuid)
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
