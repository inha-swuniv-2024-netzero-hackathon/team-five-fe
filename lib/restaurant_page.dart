import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Class.dart';
import 'make_rating_shower.dart';
import 'restaurant_page_detail_state.dart';

class restaurant_page extends StatefulWidget {
  final String uuid;
  const restaurant_page({Key? key, required this.uuid}) : super(key: key);
  @override
  State<restaurant_page> createState() => _restaurant_pageState();
}

class _restaurant_pageState extends State<restaurant_page> {
  late String uuid = widget.uuid;
  late RestaurantDetail? restaurant_data = null;
  bool fav = false;
  Enum restaurant_page_state = Restaurant_page_state.rating;
  Set<Marker> marker = <Marker>{};
  @override
  void initState() {
    super.initState();
    get_Restaurant_List().then((value) => get_Marker());
  }

  Future<void> get_Restaurant_List() async {
    String url =
        'https://basak.chungran.net/v1/restaurants/restaurants/${uuid}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        restaurant_data = RestaurantDetail(responseData);
      });
    }
  }

  Future<void> get_Marker() async {
    marker.add(Marker(
        markerId: MarkerId('${restaurant_data?.name_korean}'),
        infoWindow: InfoWindow(title: '${restaurant_data?.name_korean}'),
        position: LatLng(restaurant_data?.latitude ?? 35.6,
            restaurant_data?.longitude ?? 139.6)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(children: [
          SizedBox(height: 30),
          restaurant_page_header(context),
          SizedBox(height: 24),
          restaurant_page_store_detail(context),
          restaurant_page_store_info_list(context),
          SizedBox(height: 40),
          restaurant_page_states(context)
        ]),
      )),
    );
  }

  Widget restaurant_page_header(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${restaurant_data?.address_korean ?? 'None'}',
                  style: TextStyle(
                      fontSize: 25 * wPP, fontWeight: FontWeight.w700)),
              SizedBox(width: wPP * 10),
              Text('${restaurant_data?.address_native ?? 'None'}',
                  style: TextStyle(
                      color: Color(0xFF8E8E93),
                      fontSize: 15 * wPP,
                      fontWeight: FontWeight.w500)),
              favbutton(context),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              restaurant_data != null
                  ? make_rating_shower(
                      context, 115, 5, restaurant_data?.rating ?? 0)
                  : Container(),
              SizedBox(width: 11),
              Text(
                '${(restaurant_data?.rating ?? 0) / 100}',
                style: TextStyle(
                  color: Color(0xFFF2B544),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget restaurant_page_store_detail(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            Icon(Icons.timer_outlined, size: 16),
            SizedBox(width: 9),
            Text('시간 들어갈 자리',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            SizedBox(width: 9),
            Text(
              '라스트 오더',
              style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 20),
            SizedBox(width: 9),
            Text('${restaurant_data?.address_korean}',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Icon(Icons.phone_iphone_rounded, size: 20),
            SizedBox(width: 9),
            Text('${restaurant_data?.telephone_number}',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Icon(Icons.currency_yen_outlined, size: 20),
            SizedBox(width: 9),
            Text('시작 가격 - 끝 가격',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: ShapeDecoration(
                  color: Color(0xFFF25757),
                  shape: OvalBorder(),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 37),
      ]),
    );
  }

  Widget restaurant_page_store_info_list(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: 44,
          height: 21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: restaurant_page_state == Restaurant_page_state.rating
                  ? Color(0xFFF25757)
                  : Color(0xFFE4E4E6)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(0, 15, 12, 12))),
                  onPressed: () {
                    setState(() {
                      restaurant_page_state = Restaurant_page_state.rating;
                    });
                  },
                  child: Container()),
              Text(
                '평점',
                style: TextStyle(
                    color: restaurant_page_state == Restaurant_page_state.rating
                        ? Colors.white
                        : Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          clipBehavior: Clip.antiAlias,
          width: 44,
          height: 21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: restaurant_page_state == Restaurant_page_state.menu
                  ? Color(0xFFF25757)
                  : Color(0xFFE4E4E6)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '메뉴',
                style: TextStyle(
                    color: restaurant_page_state == Restaurant_page_state.menu
                        ? Colors.white
                        : Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(0, 15, 12, 12))),
                  onPressed: () {
                    setState(() {
                      restaurant_page_state = Restaurant_page_state.menu;
                    });
                  },
                  child: Container()),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          clipBehavior: Clip.antiAlias,
          width: 44,
          height: 21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: restaurant_page_state == Restaurant_page_state.review
                  ? Color(0xFFF25757)
                  : Color(0xFFE4E4E6)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '리뷰',
                style: TextStyle(
                    color: restaurant_page_state == Restaurant_page_state.review
                        ? Colors.white
                        : Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(0, 15, 12, 12))),
                  onPressed: () {
                    setState(() {
                      restaurant_page_state = Restaurant_page_state.review;
                    });
                  },
                  child: Container()),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          clipBehavior: Clip.antiAlias,
          width: 56,
          height: 21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: restaurant_page_state == Restaurant_page_state.guide
                  ? Color(0xFFF25757)
                  : Color(0xFFE4E4E6)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '가이드',
                style: TextStyle(
                    color: restaurant_page_state == Restaurant_page_state.guide
                        ? Colors.white
                        : Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(0, 15, 12, 12))),
                  onPressed: () {
                    setState(() {
                      restaurant_page_state = Restaurant_page_state.guide;
                    });
                  },
                  child: Container()),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          clipBehavior: Clip.antiAlias,
          width: 44,
          height: 21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: restaurant_page_state == Restaurant_page_state.photo
                  ? Color(0xFFF25757)
                  : Color(0xFFE4E4E6)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '사진',
                style: TextStyle(
                    color: restaurant_page_state == Restaurant_page_state.photo
                        ? Colors.white
                        : Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(0, 15, 12, 12))),
                  onPressed: () {
                    setState(() {
                      restaurant_page_state = Restaurant_page_state.photo;
                    });
                  },
                  child: Container()),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          clipBehavior: Clip.antiAlias,
          width: 44,
          height: 21,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: restaurant_page_state == Restaurant_page_state.map
                  ? Color(0xFFF25757)
                  : Color(0xFFE4E4E6)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '지도',
                style: TextStyle(
                    color: restaurant_page_state == Restaurant_page_state.map
                        ? Colors.white
                        : Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(
                          const Color.fromARGB(0, 15, 12, 12))),
                  onPressed: () {
                    setState(() {
                      restaurant_page_state = Restaurant_page_state.map;
                    });
                  },
                  child: Container()),
            ],
          ),
        )
      ],
    );
  }

  Widget restaurant_page_states(BuildContext context) {
    switch (restaurant_page_state) {
      case Restaurant_page_state.menu:
        return restaurant_page_menu_state(context);
      case Restaurant_page_state.review:
        return restaurant_page_review_state(context);
      case Restaurant_page_state.guide:
        return restaurant_page_guide_state(context);
      case Restaurant_page_state.photo:
        return restaurant_page_photo_state(context);
      case Restaurant_page_state.map:
        return restaurant_page_map_state(
            context,
            restaurant_data?.latitude ?? 35.6,
            restaurant_data?.longitude ?? 139.6,
            marker);
      default:
        return restaurant_page_rating_state(context);
    }
  }

  Widget favbutton(BuildContext context) {
    return IconButton(
        splashColor: Colors.transparent,
        onPressed: () {
          if (!fav) {
            setState(() {
              fav = true;
            });
          } else {
            setState(() {
              fav = false;
            });
          }
        },
        icon: fav
            ? Transform.translate(
                offset: Offset(0, 10),
                child: const Icon(
                  Icons.bookmark_border_sharp,
                  color: Colors.black,
                  size: 32,
                ),
              )
            : Transform.translate(
                offset: Offset(0, 10),
                child: const Icon(
                  Icons.bookmark,
                  color: Color(0xFFF25757),
                  size: 32,
                ),
              ));
  }
}

enum Restaurant_page_state { rating, menu, review, guide, photo, map }
