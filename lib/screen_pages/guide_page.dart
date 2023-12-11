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
