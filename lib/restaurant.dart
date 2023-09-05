import 'package:flutter/material.dart';

class restaurant extends StatefulWidget {
  const restaurant({super.key});

  @override
  State<restaurant> createState() => _restaurantState();
}

class _restaurantState extends State<restaurant> {
  List<Widget> restaurantPageList = [
    restaurantMenu(),
    restaurantReview(),
    restaurantReview()
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
        color: Colors.grey,
      ),
      child: restaurantPageList[pageIndex]
    );
  }
}

class restaurantMenu extends StatefulWidget {
  const restaurantMenu({super.key});

  @override
  State<restaurantMenu> createState() => _restaurantMenuState();
}

class _restaurantMenuState extends State<restaurantMenu> {
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
                  color: Color(0xCC333333)),
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
                  Container(
                      height: 550 * hPP,
                      child: SingleChildScrollView(
                          child: menuList.length != 0
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
      decoration: BoxDecoration(color: Color(0xCC333333)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  Container(
                      child: Row(
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
                                  Container(
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
                                  Container(
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                        Container(
                                          height: 12,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
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
                                      ]))
                                ]))
                      ]))
                ]),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              detail,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class restaurantReview extends StatefulWidget {
  const restaurantReview({super.key});

  @override
  State<restaurantReview> createState() => _restaurantReviewState();
}

class _restaurantReviewState extends State<restaurantReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
