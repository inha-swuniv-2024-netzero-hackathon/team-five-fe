//restaurant 온보딩? 인가 그럼
import 'package:flutter/material.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class RestaurantOnboarding extends StatefulWidget {
  const RestaurantOnboarding({super.key});

  @override
  State<RestaurantOnboarding> createState() => _RestaurantOnboardingState();
}

class _RestaurantOnboardingState extends State<RestaurantOnboarding> {
  List<Widget> restaurantPageList = [
    const RestaurantMenu(),
    const RestaurantReview(),
    const RestaurantReview()
  ];
  @override
  Widget build(BuildContext context) {
    return _buildCarousel(context);
  }

  Widget _buildCarousel(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        itemCount: 3,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (BuildContext context, int pageIndex) {
          return _buildCarouselItem(context, pageIndex);
        },
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int pageIndex) {
    return Container(
        decoration: const BoxDecoration(
          color: ColorStyles.gray,
        ),
        child: restaurantPageList[pageIndex]);
  }
}

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({super.key});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  List menuList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(height: hPP * 63),
            Container(
              width: wPP * 360,
              height: hPP * 622,
              alignment: Alignment.topCenter,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: ColorStyles.black),
              child: Column(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.only(left: wPP * 15, top: 20, bottom: 20),
                      child: const Row(children: [
                        Text('메뉴',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 1))
                      ])),
                  SizedBox(
                      height: 550 * hPP,
                      child: SingleChildScrollView(
                          child: menuList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: menuList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildMenuWidget(
                                        context,
                                        menuList[index].menu,
                                        menuList[index].detail,
                                        menuList[index].cost);
                                  })
                              : Container()))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuWidget(
      BuildContext context, String menu, String detail, int cost) {
    return Container(
      width: 360,
      height: 89,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: Color(0xCC333333)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    menu,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3.50, vertical: 4),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const ShapeDecoration(
                                        shape: OvalBorder(
                                          side: BorderSide(
                                              width: 0.40,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                Container(
                                  height: 12,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                ),
                                Text('$cost',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ))
                              ])
                            ]))
                  ])
                ]),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              detail,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantReview extends StatefulWidget {
  const RestaurantReview({super.key});

  @override
  State<RestaurantReview> createState() => _RestaurantReviewState();
}

class _RestaurantReviewState extends State<RestaurantReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
