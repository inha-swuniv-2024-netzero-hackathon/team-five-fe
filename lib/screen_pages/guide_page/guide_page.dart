import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';
import 'package:proto_just_design/providers/guide_provider/guide_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/guide_page/guide_page_bottomsheet.dart';
import 'package:proto_just_design/screen_pages/guide_page/guide_page_map.dart';
import 'package:proto_just_design/screen_pages/guide_page/restaurant_button.dart';
import 'package:proto_just_design/view_model/guide_page/guidePage.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  bool isFirst = true;
  ScrollController listViewController = ScrollController();
  TextEditingController findControlloer = TextEditingController();

  void setRestaurantMarker() {
    for (Restaurant restaurant
        in context.read<GuidePageProvider>().guidePageRestaurants) {
      Marker marker = (Marker(
          markerId: MarkerId(restaurant.name),
          infoWindow: InfoWindow(title: restaurant.name),
          position: LatLng(restaurant.latitude, restaurant.longitude)));
      context.read<GuidePageProvider>().addMarker(marker);
    }
  }

  Future<void> _scrollListener() async {
    if ((listViewController.position.pixels ==
            listViewController.position.maxScrollExtent) &&
        (context.read<GuidePageProvider>().nextUrl != null) &&
        context.read<GuidePageProvider>().guidePageRestaurants.isNotEmpty) {
      await getRestaurantList(
          context.read<UserDataProvider>().token,
          context.read<GuidePageProvider>().nextUrl,
          context.read<GuidePageProvider>().selectArea);
    }
  }

  void makeMarker() {
    if (mounted) {
      final guidePageProvider = context.read<GuidePageProvider>();
      Marker marker = (Marker(
          markerId: MarkerId(
              '${guidePageProvider.selectArea.bigArea} ${guidePageProvider.selectArea.smallArea}'),
          infoWindow: InfoWindow(
              title:
                  '${guidePageProvider.selectArea.bigArea}${guidePageProvider.selectArea.smallArea}'),
          position: LatLng(guidePageProvider.selectArea.latitude,
              guidePageProvider.selectArea.longitude)));
      if (mounted) {
        context.read<GuidePageProvider>().addMarker(marker);
      }
    }
  }

  Future<void> getinitdata() async {
    if (isFirst) {
      isFirst = false;
      if (context.read<GuidePageProvider>().guidePageRestaurants.isEmpty) {
        getRestaurantList(
          context.read<UserDataProvider>().token,
          context.read<GuidePageProvider>().nextUrl,
          context.read<GuidePageProvider>().selectArea,
        ).then((value) {
          setRestaurantMarker();
          makeMarker();
        });
      }
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    listViewController.addListener(() {
      _scrollListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    final guidePageProvider = context.watch<GuidePageProvider>();
    return FutureBuilder(
      future: getinitdata(),
      builder: (context, snapshot) {
        return Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          child: Stack(
            children: [
              const GuidePageMap(),
              restaurantListModal(context, guidePageProvider),
              Column(
                children: [
                  const Gap(30),
                  upperButtons(context, guidePageProvider)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget upperButtons(
      BuildContext context, GuidePageProvider guidePageProvider) {
    return Container(
      alignment: Alignment.topCenter,
      height: 50,
      child: Row(children: [
        const Spacer(),
        (guidePageProvider.searchOpen || guidePageProvider.withMap)
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
                    autofocus: guidePageProvider.searchOpen,
                    onTapOutside: (event) {
                      guidePageProvider.setSearch();
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
                      guidePageProvider.setSearch();
                      guidePageProvider.setWithmap();
                    },
                    style: ButtonStyles.transparenBtuttonStyle,
                    child: Container(),
                  )
                ])),
        const Gap(15),
        (guidePageProvider.withMap == false)
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
                        guidePageProvider.setWithmap();
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
                      guidePageProvider.setWithmap();
                    },
                    style: ButtonStyles.transparenBtuttonStyle,
                    child: Container(),
                  )
                ])),
        const Gap(20)
      ]),
    );
  }

  Widget restaurantListModal(
      BuildContext context, GuidePageProvider guidePageProvider) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      child: DraggableScrollableSheet(
        snapAnimationDuration: const Duration(milliseconds: 200),
        initialChildSize: guidePageProvider.withMap ? 0.85 : 1,
        minChildSize: guidePageProvider.withMap ? 0.06 : 1,
        maxChildSize: guidePageProvider.withMap ? 0.85 : 1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: guidePageProvider.withMap ? scrollController : null,
              child: Container(
                height: guidePageProvider.withMap
                    ? screenHeight * 0.85 - 58
                    : screenHeight * 0.9,
                decoration: BoxDecoration(
                    boxShadow: Boxshadows.defaultShadow,
                    border: Border.all(color: ColorStyles.ash),
                    borderRadius: guidePageProvider.withMap
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))
                        : null,
                    color: ColorStyles.white),
                child: Column(
                  children: [
                    guidePageProvider.withMap
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
                    header(context, guidePageProvider),
                    body(
                        context,
                        guidePageProvider.withMap
                            ? screenHeight * 0.85 - 210
                            : screenHeight * 0.9 - 162,
                        guidePageProvider)
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget header(BuildContext context, GuidePageProvider guidePageProvider) {
    return Container(
        alignment: Alignment.topCenter,
        height: 110,
        child: Row(children: [
          const Gap(25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  final check = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeArea()));
                  if (check == true) {
                    if (mounted) {
                      getRestaurantList(
                          context.read<UserDataProvider>().token,
                          guidePageProvider.nextUrl,
                          guidePageProvider.selectArea);
                    }
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 30, color: ColorStyles.red),
                    Row(
                      children: [
                        Text(guidePageProvider.selectArea.bigArea,
                            style: const TextStyle(
                              color: ColorStyles.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            )),
                        const Gap(8),
                        Text(guidePageProvider.selectArea.smallArea,
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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const GuidePageBottomSheet();
                    },
                  );
                },
                child: Row(
                  children: [
                    const Gap(10),
                    Row(
                      children: [
                        guidePageProvider.sorting.icon,
                        const Gap(3),
                        Text(
                          guidePageProvider.sorting.name,
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
        ]));
  }

  Widget body(BuildContext context, double height,
      GuidePageProvider guidePageProvider) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: height,
        width: screenWidth,
        alignment: Alignment.center,
        child: ListView.builder(
            controller: listViewController,
            itemCount: guidePageProvider.guidePageRestaurants.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == guidePageProvider.guidePageRestaurants.length) {
                return const SizedBox(height: 40);
              }
              if ((index % 2 == 0)) {
                if ((guidePageProvider.guidePageRestaurants.length % 2 == 1) &&
                    (index + 2 >
                        guidePageProvider.guidePageRestaurants.length)) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantButton(
                          restaurant:
                              guidePageProvider.guidePageRestaurants[index]),
                      const Gap(20),
                      Container(width: 171)
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RestaurantButton(
                        restaurant:
                            guidePageProvider.guidePageRestaurants[index]),
                    const Gap(20),
                    RestaurantButton(
                        restaurant:
                            guidePageProvider.guidePageRestaurants[index + 1])
                  ],
                );
              }

              return const SizedBox(height: 10);
            }));
  }
}

class GuideP extends ConsumerStatefulWidget {
  const GuideP({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuidePState();
}

class _GuidePState extends ConsumerState<GuideP> {
  bool isFirst = true;
  ScrollController listViewController = ScrollController();
  TextEditingController findControlloer = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(guidePageProvider.notifier).setInfo(ref.read(provider), value, area);
  }

  void setRestaurantMarker() {
    for (Restaurant restaurant
        in context.read<GuidePageProvider>().guidePageRestaurants) {
      Marker marker = (Marker(
          markerId: MarkerId(restaurant.name),
          infoWindow: InfoWindow(title: restaurant.name),
          position: LatLng(restaurant.latitude, restaurant.longitude)));
      context.read<GuidePageProvider>().addMarker(marker);
    }
  }

  @override
  Widget build(BuildContext context) {
    GuidePageVM guidePController = ref.read(guidePageProvider.notifier);
    GuidePInfo guidePInfo = ref.watch(guidePageProvider);
    return Container();
  }
}
