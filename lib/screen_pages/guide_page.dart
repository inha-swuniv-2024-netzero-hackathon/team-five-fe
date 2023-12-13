import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/Class.dart';
import 'package:proto_just_design/restaurant.dart';
import 'package:proto_just_design/review.dart';

import '../restaurant_page.dart';

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
    String url =
        'https://basak.chungran.net/v1/restaurants/restaurants/?area__id=4&ordering=restaurant_info__rating&page=1';
    final response = await http.get(Uri.parse(url));
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
                            if ((index % 2 == 0) &&
                                (index + 2 <= restaurantList.length)) {
                              Restaurant left_restaurant_data =
                                  Restaurant(restaurantList[index]);
                              Restaurant right_restaurant_data =
                                  Restaurant(restaurantList[index + 1]);
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  restaurantButton(
                                      context, left_restaurant_data),
                                  SizedBox(width: wPP * 18),
                                  restaurantButton(
                                      context, right_restaurant_data)
                                ],
                              );
                            } else {
                              return SizedBox(height: 10);
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

  Widget restaurantButton(BuildContext context, Restaurant restaurant) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Container(
      width: 171 * wPP,
      height: restaurantStarDetail.contains(restaurant.uuid) == false
          ? hPP * 262
          : hPP * 332,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15)),
          color: Colors.blue[50]),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(children: [
            Stack(
              children: [
                Container(
                  width: wPP * 171,
                  height: hPP * 171,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(restaurant.thumbnail),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                restaurant_page(uuid: restaurant.uuid)));
                  },
                  child: Container(
                    width: wPP * 171,
                    height: hPP * 171,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                ),
              ],
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
                          restaurant.name_korean,
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
                            if (favList.contains(restaurant.uuid) == false) {
                              setState(() {
                                favList.add(restaurant.uuid);
                              });
                            } else {
                              setState(() {
                                favList.remove(restaurant.uuid);
                              });
                            }
                          },
                          icon: (favList.contains(restaurant.uuid) == false)
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
                  '${restaurant.daytime_price}',
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
                      width: 100 * wPP * (restaurant.rating / 100 - 1) / 4,
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
                        '${restaurant.rating / 100}',
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
                                if (restaurantStarDetail
                                    .contains(restaurant.uuid)) {
                                  setState(() {
                                    restaurantStarDetail
                                        .remove(restaurant.uuid);
                                  });
                                } else {
                                  setState(() {
                                    restaurantStarDetail.add(restaurant.uuid);
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Transform.translate(
                                  offset: Offset(-13 * wPP, hPP * 2),
                                  child: Icon(
                                    restaurantStarDetail
                                                .contains(restaurant.uuid) ==
                                            true
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
            restaurantStarDetail.contains(restaurant.uuid)
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
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  Container(
                                    width: 100 *
                                        wPP *
                                        (restaurant.rating_taste / 100 - 1) /
                                        4,
                                    height: 4 * hPP,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFFF2B544)),
                                  ),
                                  Transform.translate(
                                    offset: Offset(
                                        100 *
                                            wPP *
                                            (restaurant.rating_taste / 100 -
                                                1) /
                                            4,
                                        -7 * hPP),
                                    child: Container(
                                      width: 16 * wPP,
                                      height: 16 * wPP,
                                      decoration: const ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFF2B544)),
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
                              padding: EdgeInsets.only(
                                  left: wPP * 10, right: wPP * 5),
                              child: Container(
                                width: wPP * 23,
                                child: Text(
                                  '${restaurant.rating_taste / 100}',
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
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  Container(
                                    width: 100 *
                                        wPP *
                                        (restaurant.rating_service / 100 - 1) /
                                        4,
                                    height: 4 * hPP,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFFF2B544)),
                                  ),
                                  Transform.translate(
                                    offset: Offset(
                                        100 *
                                            wPP *
                                            (restaurant.rating_service / 100 -
                                                1) /
                                            4,
                                        -7 * hPP),
                                    child: Container(
                                      width: 16 * wPP,
                                      height: 16 * wPP,
                                      decoration: const ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFF2B544)),
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
                              padding: EdgeInsets.only(
                                  left: wPP * 10, right: wPP * 5),
                              child: Container(
                                width: wPP * 23,
                                child: Text(
                                  '${restaurant.rating_service / 100}',
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
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  Container(
                                    width: 100 *
                                        wPP *
                                        (restaurant.rating_price / 100 - 1) /
                                        4,
                                    height: 4 * hPP,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFFF2B544)),
                                  ),
                                  Transform.translate(
                                    offset: Offset(
                                        100 *
                                            wPP *
                                            (restaurant.rating_price / 100 -
                                                1) /
                                            4,
                                        -7 * hPP),
                                    child: Container(
                                      width: 16 * wPP,
                                      height: 16 * wPP,
                                      decoration: const ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFF2B544)),
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
                              padding: EdgeInsets.only(
                                  left: wPP * 10, right: wPP * 5),
                              child: SizedBox(
                                width: wPP * 23,
                                child: Text(
                                  '${restaurant.rating_price / 100}',
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
                : Container(),
          ]),
        ],
      ),
    );
  }
}
