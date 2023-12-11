import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
