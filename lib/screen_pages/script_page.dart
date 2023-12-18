import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Class.dart';

class scriptPage extends StatefulWidget {
  const scriptPage({super.key});

  @override
  State<scriptPage> createState() => _scriptPageState();
}

class _scriptPageState extends State<scriptPage> {
  List favListingList = [];
  List restaurant_listing_list = [];

  Future<void> get_Restaurant_Listing_List() async {
    final response = await http
        .get(Uri.parse('https://basak.chungran.net/v1/restaurants/listings/'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        restaurant_listing_list = responseData;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    get_Restaurant_Listing_List();
  }

  TextEditingController findControlloer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          child: Column(
            children: [
              SizedBox(height: 44 * hPP),
              script_page_header(context),
              SizedBox(height: hPP * 35),
              Container(
                height: hPP * 700,
                width: screenWidth - wPP * 30,
                child: ListView.builder(
                  itemCount: restaurant_listing_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    if ((index % 2 == 0) &&
                        (index + 2 <= restaurant_listing_list.length)) {
                      return (Row(
                        children: [
                          makeRestaurantListingButton(context,
                              Restaurant_list(restaurant_listing_list[index])),
                          Spacer(),
                          makeRestaurantListingButton(
                              context,
                              Restaurant_list(
                                  restaurant_listing_list[index + 1]))
                        ],
                      ));
                    } else {
                      return Container(
                        height: 10,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget script_page_header(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Row(
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
          decoration: const ShapeDecoration(shape: OvalBorder(), shadows: [
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
                backgroundColor: MaterialStateProperty.all(Colors.white)),
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
    );
  }

  Widget makeRestaurantListingButton(
      BuildContext context, Restaurant_list restaurant_list) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;

    return Container(
      width: wPP * 171,
      height: hPP * 261,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: wPP * 171,
              height: hPP * 131,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(restaurant_list.thumbnail),
                  fit: BoxFit.fill,
                ),
              ),
            ),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(restaurant_list.thumbnail),
                            fit: BoxFit.fill,
                          ),
                        )),
                    SizedBox(width: wPP * 8),
                    Padding(
                      padding: EdgeInsets.only(top: hPP * 8),
                      child: Text(restaurant_list.username),
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
                Text(restaurant_list.title, style: TextStyle(fontSize: 15)),
                SizedBox(height: hPP * 10),
                const Text('글이 올 자리',
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
                      '${restaurant_list.avg_rate / 100}',
                      style: TextStyle(color: Color(0xFFF2B544), fontSize: 11),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
