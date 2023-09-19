import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class guidePage extends StatefulWidget {
  const guidePage({super.key});

  @override
  State<guidePage> createState() => _guidePageState();
}

class _guidePageState extends State<guidePage> {
  bool fav = true;
  List<String> restaurantStarDetail = [];
  String area1 = '지역1';
  String area2 = '지역2';
  List<dynamic> restaurantList = [];
  List<String> favList = [];

  Future<void> get_Restaurant_List() async {
    final response = await http.get(
        Uri.parse('https://basak.chungran.net/v1/restaurants/restaurants/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        restaurantList = responseData['results'];
      });
    }
  }

  @override
  void initState() {
    get_Restaurant_List();
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
        alignment: Alignment.topCenter,
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            SizedBox(height: hPP * 30),
            Container(
                alignment: Alignment.topCenter,
                height: hPP * 57,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(children: [
                    Padding(
                        padding: EdgeInsets.only(left: wPP * 27),
                        child: Row(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: wPP * 30,
                                    color: const Color(0xFFF25757)),
                                Text(area1,
                                    style: TextStyle(
                                      fontSize: 25 * wPP,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(width: wPP * 8),
                                Text(area2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20 * wPP,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 1))
                              ])
                        ]))
                  ]),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: wPP * 27),
                    child: Row(
                      children: [
                        Container(
                            width: wPP * 36,
                            height: hPP * 36,
                            decoration: const ShapeDecoration(
                                shape: OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                      color: Color(0x29000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0),
                                  BoxShadow(
                                      color: Color(0x15000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0)
                                ]),
                            clipBehavior: Clip.antiAlias,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                child: Transform.translate(
                                  offset: Offset(-8, 0),
                                  child: Icon(
                                    Icons.search,
                                    size: wPP * 24,
                                    color: Colors.black,
                                  ),
                                ))),
                        SizedBox(width: wPP * 15),
                        Container(
                          width: wPP * 36,
                          height: hPP * 36,
                          decoration: const ShapeDecoration(
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                    color: Color(0x29000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0),
                                BoxShadow(
                                    color: Color(0x15000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0)
                              ]),
                          clipBehavior: Clip.antiAlias,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: Transform.translate(
                              offset: Offset(-8, 0),
                              child: Icon(
                                Icons.map_outlined,
                                size: wPP * 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ])),
            Container(
              padding: EdgeInsets.only(left: wPP * 15),
              height: hPP * 660,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: hPP * 660,
                      width: screenWidth - 15 * wPP,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                          itemCount: restaurantList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index % 2 == 0) {
                              String image1;
                              String image2;
                              if (restaurantList[index]["thumbnail"] == null) {
                                image1 =
                                    "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_okonomiyaki.jpg";
                              } else {
                                image1 = restaurantList[index]["thumbnail"];
                              }
                              if (restaurantList[index]["thumbnail"] == null) {
                                image2 =
                                    "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_okonomiyaki.jpg";
                              } else {
                                image2 = restaurantList[index]["thumbnail"];
                              }
                              return Container(
                                width: screenWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    restaurantButton(
                                        context,
                                        restaurantList[index]["name_korean"],
                                        image1,
                                        restaurantList[index]["restaurant_info"]
                                            ["rating_taste"],
                                        restaurantList[index]["restaurant_info"]
                                            ["rating_price"],
                                        restaurantList[index]["restaurant_info"]
                                            ["rating_service"],
                                        restaurantList[index]["uuid"]),
                                    SizedBox(width: wPP * 18),
                                    restaurantButton(
                                        context,
                                        restaurantList[index + 1]
                                            ["name_korean"],
                                        image2,
                                        restaurantList[index + 1]
                                            ["restaurant_info"]["rating_taste"],
                                        restaurantList[index + 1]
                                            ["restaurant_info"]["rating_price"],
                                        restaurantList[index + 1]
                                                ["restaurant_info"]
                                            ["rating_service"],
                                        restaurantList[index + 1]["uuid"])
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox(height: 1);
                            }
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget restaurantButton(BuildContext context, String name, String image,
      int ratingTaste, int ratingPrice, int ratingService, String uuid) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    double star = (ratingPrice + ratingService + ratingTaste) / 300;
    return Container(
      width: 171 * wPP,
      height:
          restaurantStarDetail.contains(uuid) == false ? hPP * 262 : hPP * 332,
      decoration: const BoxDecoration(color: Colors.white),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Container(
          width: wPP * 171,
          height: hPP * 171,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
            width: wPP * 171,
            height: hPP * 28,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: wPP * 5, top: hPP * 5, bottom: hPP * 5),
                  child: Container(
                    width: wPP * 110,
                    child: Text(
                      name,
                      style: const TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1),
                      maxLines: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: Offset(0, hPP * 5),
                  child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        if (favList.contains(uuid) == false) {
                          setState(() {
                            favList.add(uuid);
                          });
                        } else {
                          setState(() {
                            favList.remove(uuid);
                          });
                        }
                      },
                      icon: (favList.contains(uuid) == false)
                          ? Transform.translate(
                              offset: Offset(0, -hPP * 10),
                              child: const Icon(
                                Icons.bookmark_border_sharp,
                                color: Colors.black,
                                size: 30,
                              ),
                            )
                          : Transform.translate(
                              offset: Offset(0, -hPP * 10),
                              child: const Icon(
                                Icons.bookmark,
                                color: Color(0xFFF25757),
                                size: 30,
                              ),
                            )),
                )
              ],
            )),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: wPP * 3, right: wPP * 4),
              child: const Icon(Icons.currency_yen, size: 15),
            ),
            Text(
              'cost?',
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            )
          ],
        ),
        Container(
          width: wPP * 171,
          padding: EdgeInsets.fromLTRB(hPP * 7, hPP * 4, 0, hPP * 4),
          child: Row(
            children: [
              Stack(children: [
                Container(
                    width: 100 * wPP,
                    height: 4 * hPP,
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(8))),
                Container(
                  width: 100 * wPP * (star - 1) / 4,
                  height: 4 * hPP,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF2B544)),
                )
              ]),
              Padding(
                padding: EdgeInsets.only(
                  left: wPP * 10,
                ),
                child: Container(
                  width: wPP * 23,
                  child: Text(
                    '$star',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFFF2B544),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                      width: wPP * 25,
                      height: hPP * 28,
                      child: Transform.translate(
                        offset: Offset(5, -5),
                        child: ElevatedButton(
                          onPressed: () {
                            if (restaurantStarDetail.contains(uuid)) {
                              setState(() {
                                restaurantStarDetail.remove(uuid);
                              });
                            } else {
                              setState(() {
                                restaurantStarDetail.add(uuid);
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Transform.translate(
                              offset: Offset(-13 * wPP, hPP * 2),
                              child: Icon(
                                restaurantStarDetail.contains(uuid) == true
                                    ? Icons.keyboard_arrow_down_outlined
                                    : Icons.keyboard_arrow_left_outlined,
                                color: const Color(0xFFE4E4E6),
                              )),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
        restaurantStarDetail.contains(uuid)
            ? Column(
                children: [
                  Container(
                    width: wPP * 171,
                    height: hPP * 26,
                    padding: EdgeInsets.fromLTRB(hPP * 7, hPP * 4, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            //alignment: Alignment.bo,
                            children: [
                              Container(
                                  width: 100 * wPP,
                                  height: 4 * hPP,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(8))),
                              Container(
                                width: 100 * wPP * (ratingTaste / 100 - 1) / 4,
                                height: 4 * hPP,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFF2B544)),
                              ),
                              Transform.translate(
                                offset: Offset(
                                    100 * wPP * (ratingTaste / 100 - 1) / 4,
                                    -7 * hPP),
                                child: Container(
                                  width: 16 * wPP,
                                  height: 16 * wPP,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFF2B544)),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.restaurant_menu,
                                    color: Color(0xFFF2B544),
                                    size: 10,
                                  ),
                                ),
                              )
                            ]),
                        Padding(
                          padding:
                              EdgeInsets.only(left: wPP * 10, right: wPP * 5),
                          child: Container(
                            width: wPP * 23,
                            child: Text(
                              '${ratingTaste / 100}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFFF2B544),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: wPP * 171,
                    height: hPP * 26,
                    padding: EdgeInsets.fromLTRB(hPP * 7, hPP * 4, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            //alignment: Alignment.bo,
                            children: [
                              Container(
                                  width: 100 * wPP,
                                  height: 4 * hPP,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(8))),
                              Container(
                                width:
                                    100 * wPP * (ratingService / 100 - 1) / 4,
                                height: 4 * hPP,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFF2B544)),
                              ),
                              Transform.translate(
                                offset: Offset(
                                    100 * wPP * (ratingService / 100 - 1) / 4,
                                    -7 * hPP),
                                child: Container(
                                  width: 16 * wPP,
                                  height: 16 * wPP,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFF2B544)),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.handshake_outlined,
                                    color: Color(0xFFF2B544),
                                    size: 10,
                                  ),
                                ),
                              )
                            ]),
                        Padding(
                          padding:
                              EdgeInsets.only(left: wPP * 10, right: wPP * 5),
                          child: Container(
                            width: wPP * 23,
                            child: Text(
                              '${ratingService / 100}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFFF2B544),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: wPP * 171,
                    height: hPP * 26,
                    padding: EdgeInsets.fromLTRB(hPP * 7, hPP * 4, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            //alignment: Alignment.bo,
                            children: [
                              Container(
                                  width: 100 * wPP,
                                  height: 4 * hPP,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(8))),
                              Container(
                                width: 100 * wPP * (ratingPrice / 100 - 1) / 4,
                                height: 4 * hPP,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFF2B544)),
                              ),
                              Transform.translate(
                                offset: Offset(
                                    100 * wPP * (ratingPrice / 100 - 1) / 4,
                                    -7 * hPP),
                                child: Container(
                                  width: 16 * wPP,
                                  height: 16 * wPP,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFF2B544)),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.currency_yen_outlined,
                                    color: Color(0xFFF2B544),
                                    size: 10,
                                  ),
                                ),
                              )
                            ]),
                        Padding(
                          padding:
                              EdgeInsets.only(left: wPP * 10, right: wPP * 5),
                          child: SizedBox(
                            width: wPP * 23,
                            child: Text(
                              '${ratingPrice / 100}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFFF2B544),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Container()
      ]),
    );
  }
}

class scriptPage extends StatefulWidget {
  const scriptPage({super.key});

  @override
  State<scriptPage> createState() => _scriptPageState();
}

class _scriptPageState extends State<scriptPage> {
  List favListingList = [];
  List restaurantListingList = [];
  Future<void> get_Restaurant_Listing_List() async {
    final response = await http
        .get(Uri.parse('https://basak.chungran.net/v1/restaurants/listings/'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        restaurantListingList = responseData;
      });
      print(restaurantListingList);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    // get_Restaurant_Listing_List();
  }

  TextEditingController findControlloer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        child: Column(
          children: [
            SizedBox(height: 64 * hPP),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 25 * wPP, right: 30 * wPP),
                      margin: EdgeInsets.only(left: wPP * 15),
                      width: 299 * wPP,
                      height: 36 * hPP,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        shadows: const [
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
                      child: TextField(
                          controller: findControlloer,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '스크립트에서 원하는 맛집을 찾아보세요',
                              hintStyle: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ))),
                    ),
                  ],
                ),
                SizedBox(width: wPP * 20),
                Container(
                  width: wPP * 36,
                  height: hPP * 36,
                  decoration:
                      const ShapeDecoration(shape: OvalBorder(), shadows: [
                    BoxShadow(
                        color: Color(0x29000000),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                        spreadRadius: 0),
                    BoxShadow(
                        color: Color(0x15000000),
                        blurRadius: 3,
                        offset: Offset(0, 0),
                        spreadRadius: 0)
                  ]),
                  clipBehavior: Clip.antiAlias,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Transform.translate(
                      offset: Offset(-8, 0),
                      child: Icon(
                        Icons.map_outlined,
                        size: wPP * 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: hPP * 35),
            Container(
              height: hPP * 500,
              width: screenWidth - wPP * 30,
              child: ListView.builder(
                itemCount: restaurantListingList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index % 2 == 0) {
                    return (Row(
                      children: [
                        makeRestaurantListingButton(
                            context,
                            restaurantListingList[index]["created_by"]
                                ["username"],
                            restaurantListingList[index]["title"],
                            restaurantListingList[index]["restaurant_list"]),
                        makeRestaurantListingButton(
                            context,
                            restaurantListingList[index + 1]["created_by"],
                            restaurantListingList[index + 1]["title"],
                            restaurantListingList[index + 1]["restaurant_list"])
                      ],
                    ));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makeRestaurantListingButton(BuildContext context, String creater,
      String title, List restaurant_list) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    double starAverage = 3.0;
    double starSum = 0;
    double starCount = 0;
    if (restaurant_list.isNotEmpty) {
      for (int i = 0; i < restaurant_list.length; i++) {
        starSum +=
            restaurant_list[i]["restaurant"]["restaurant_info"]["rating"];
      }
      starAverage = starSum / starCount;
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: wPP * 171,
          height: hPP * 261,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
        ),
        Container(
          padding: EdgeInsets.only(left: wPP * 7),
          width: wPP * 171,
          height: hPP * 139,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: hPP * 9),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 29 * wPP,
                      height: 29 * wPP,
                      decoration: ShapeDecoration(
                          color: Colors.grey, shape: CircleBorder())),
                  SizedBox(width: wPP * 8),
                  Padding(
                    padding: EdgeInsets.only(top: hPP * 8),
                    child: Text(creater),
                  ),
                  Spacer(),
                  Transform.translate(
                    offset: Offset(0, -12),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark,
                          color: Colors.grey,
                          size: wPP * 24,
                        )),
                  )
                ],
              ),
              Text(title, style: TextStyle(fontSize: 15)),
              SizedBox(height: hPP * 10),
              const Text('타츠노야',
                  style: TextStyle(fontSize: 13, color: Color(0xff8E8E93))),
              const SizedBox(height: 8),
              Row(
                children: [
                  Stack(children: [
                    Container(
                        width: 115 * wPP,
                        height: 4 * hPP,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8))),
                    Container(
                      width: 115 * wPP * (4 - 1) / 4,
                      height: 4 * hPP,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF2B544)),
                    )
                  ]),
                  SizedBox(width: wPP * 11),
                  Text(
                    '${starAverage}',
                    style: TextStyle(color: Color(0xFFF2B544), fontSize: 11),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class reviewPage extends StatefulWidget {
  const reviewPage({super.key});

  @override
  State<reviewPage> createState() => _reviewPageState();
}

class _reviewPageState extends State<reviewPage> {
  double averageStarVariable = -0.2;
  double averageStar = 3.4;
  int reviewNum = 5380;
  String area = '오사카 다이쇼';
  int mostReviewAreaNum = 92;

  late DateTime time;
  @override
  void initState() {
    time = DateTime.now();
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
        padding: EdgeInsets.only(left: wPP * 15, right: wPP * 15),
        child: Column(children: [
          SizedBox(height: 25),
          Row(
            children: [
              Text('맛집은 리뷰로 기억된다',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Icon(Icons.history_edu_outlined),
              Spacer(),
              Container(
                  width: wPP * 36,
                  height: hPP * 36,
                  decoration:
                      const ShapeDecoration(shape: OvalBorder(), shadows: [
                    BoxShadow(
                        color: Color(0x29000000),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                        spreadRadius: 0),
                    BoxShadow(
                        color: Color(0x15000000),
                        blurRadius: 3,
                        offset: Offset(0, 0),
                        spreadRadius: 0)
                  ]),
                  clipBehavior: Clip.antiAlias,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Transform.translate(
                        offset: Offset(-8, 0),
                        child: Icon(
                          Icons.search,
                          size: wPP * 24,
                          color: Colors.black,
                        ),
                      ))),
              SizedBox(width: wPP * 15),
              Container(
                  width: wPP * 36,
                  height: hPP * 36,
                  decoration:
                      const ShapeDecoration(shape: OvalBorder(), shadows: [
                    BoxShadow(
                        color: Color(0x29000000),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                        spreadRadius: 0),
                    BoxShadow(
                        color: Color(0x15000000),
                        blurRadius: 3,
                        offset: Offset(0, 0),
                        spreadRadius: 0)
                  ]),
                  clipBehavior: Clip.antiAlias,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Transform.translate(
                        offset: Offset(-8, 0),
                        child: Icon(
                          Icons.map_outlined,
                          size: wPP * 24,
                          color: Colors.black,
                        ),
                      )))
            ],
          ),
          SizedBox(height: hPP * 23),
          Row(
            children: [
              Container(
                width: 175 * wPP,
                height: 192 * hPP,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: const [
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: hPP * 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '평균 별점 ',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${averageStarVariable.abs()}',
                          style: const TextStyle(
                              color: Color(0xFF1877F2), fontSize: 15),
                        ),
                        Transform.rotate(
                          angle: 3.14159,
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: ShapeDecoration(
                              color: Color(0xFF1877F2),
                              shape: StarBorder.polygon(sides: 3),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: hPP * 18),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -1.5708,
                          child: Stack(
                            children: [
                              Container(
                                width: hPP * 120,
                                height: hPP * 120,
                                decoration:
                                    const ShapeDecoration(shape: OvalBorder()),
                                clipBehavior: Clip.antiAlias,
                                child: const CircularProgressIndicator(
                                    value: 1,
                                    color: Color(0xFFE4E4E6),
                                    strokeWidth: 15),
                              ),
                              Container(
                                width: hPP * 120,
                                height: hPP * 120,
                                decoration:
                                    ShapeDecoration(shape: const OvalBorder()),
                                clipBehavior: Clip.antiAlias,
                                child: CircularProgressIndicator(
                                    value: averageStar / 5,
                                    color: const Color(0xFFF2B544),
                                    strokeWidth: 15),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 25 * wPP,
                              height: 25 * wPP,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF2B544),
                                shape: StarBorder(
                                  points: 5,
                                  innerRadiusRatio: 0.38,
                                ),
                              ),
                            ),
                            Text(
                              '$averageStar',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Container(
                    width: 175 * wPP,
                    height: 69 * hPP,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: const [
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '오늘 작성된 리뷰수',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: hPP * 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$reviewNum 명',
                              style: const TextStyle(
                                color: Color(0xFFF25757),
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: 11,
                              height: 11,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF25757),
                                shape: StarBorder.polygon(sides: 3),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: hPP * 12),
                  Container(
                    width: 175 * wPP,
                    height: 111,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '가장 많이 작성된 지역',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: hPP * 12,
                        ),
                        Text(
                          area,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: hPP * 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$mostReviewAreaNum 개',
                              style: const TextStyle(
                                color: Color(0xFFF25757),
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: 11,
                              height: 11,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF25757),
                                shape: StarBorder.polygon(sides: 3),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: hPP * 5),
          Row(
            children: [
              Spacer(),
              Text(
                '${time.month}월 ${time.day}일 ${time.hour}:${time.minute}',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: wPP * 5),
              IconButton(
                  onPressed: () {
                    setState(() {
                      time = DateTime.now();
                    });
                  },
                  icon: Icon(Icons.refresh, size: 20))
            ],
          ),
          Row(
            children: [
              Text('초고의 별점 식당만 모았어요',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Icon(Icons.military_tech_outlined, size: 20)
            ],
          ),
          SizedBox(height: hPP * 18),
          Row(
            children: [
              Container(
                width: wPP * 80,
                height: hPP * 80,
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Color(0xFFF2B544)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hotel_class,
                        color: Colors.white, size: 24 * wPP),
                    Text(
                      '4+',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: wPP * 80,
                height: hPP * 80,
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Color(0xFFF2B544)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu,
                        color: Colors.white, size: 24 * wPP),
                    Text(
                      'Best',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: wPP * 80,
                height: hPP * 80,
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Color(0xFFF2B544)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.handshake, color: Colors.white, size: 24 * wPP),
                    Text(
                      'TOP 50',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: wPP * 80,
                height: hPP * 80,
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Color(0xFFF2B544)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.currency_yen,
                        color: Colors.white, size: 24 * wPP),
                    Text(
                      'Best',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: hPP * 30),
          Row(
            children: [
              Text('오늘의 한줄평'),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.help_outline,
                    color: Colors.grey,
                    size: 20,
                  ))
            ],
          ),
          SizedBox(height: hPP * 5),
          Container(
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(90)),
            height: hPP * 50,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: wPP * 15, right: wPP * 12),
                  child: Container(
                    width: wPP * 34,
                    height: hPP * 34,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(), color: Colors.grey),
                  ),
                ),
                Column(
                  children: [
                    Stack(children: [
                      Container(
                          width: 100 * wPP,
                          height: 4 * hPP,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(8))),
                      Container(
                        width: 100 * wPP * (100 / 115 - 1) / 4,
                        height: 4 * hPP,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF2B544)),
                      ),
                      Container(
                        width: 16 * wPP,
                        height: 16 * wPP,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFF2B544)),
                          ),
                        ),
                        child: const Icon(
                          Icons.restaurant_menu,
                          color: Color(0xFFF2B544),
                          size: 10,
                        ),
                      )
                    ])
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                      size: 30,
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  padding: EdgeInsets.only(top: hPP * 5),
                  alignment: Alignment.topLeft,
                  height: hPP * 150,
                  decoration: const BoxDecoration(color: Color(0xCCF25757)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5 * wPP),
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.output,
                                  color: Colors.white,
                                  size: 17,
                                ),
                                Text(
                                  '로그아웃',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                        SizedBox(width: wPP * 55),
                        Text('마이페이지',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Icon(Icons.settings, color: Colors.white))
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: hPP * 100),
                padding: EdgeInsets.fromLTRB(17, 15, 16, 15),
                width: 360 * wPP,
                height: 94 * hPP,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                child: Row(children: [
                  Container(
                    width: 65 * hPP,
                    height: 65 * hPP,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/65x65"),
                        fit: BoxFit.cover,
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                  SizedBox(width: wPP * 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('돈까츠러버',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              )),
                          Icon(Icons.add_box_outlined, size: 15 * wPP),
                          SizedBox(width: wPP * 1),
                          Text('@jw28p ')
                        ],
                      ),
                      SizedBox(height: hPP * 10),
                      Row(
                        children: [
                          Container(
                            width: 80 * wPP,
                            height: 26 * hPP,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: ShapeDecoration(
                              color: Color(0x33F2B544),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Color(0xFFF2B544)),
                                Text(
                                  '3.58',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: wPP * 10),
                          Container(
                            width: 110 * wPP,
                            height: 26 * hPP,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: ShapeDecoration(
                              color: Color(0x33F25757),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.interests, color: Color(0xCCF25757)),
                                Text(
                                  '미식가A',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ]),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class selectScreen extends StatefulWidget {
  const selectScreen({super.key});

  @override
  State<selectScreen> createState() => _selectScreenState();
}

class _selectScreenState extends State<selectScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    guidePage(),
    scriptPage(),
    reviewPage(),
    myPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: '가이드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: '스크립트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speaker_notes_outlined),
            label: '리뷰',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review_outlined),
            label: '마이',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFF25757),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        onTap: _onItemTapped,
      ),
    );
  }
}
