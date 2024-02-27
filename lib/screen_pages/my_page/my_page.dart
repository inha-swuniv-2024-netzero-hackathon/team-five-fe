import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/class/restaurant_review_class.dart';
import 'package:proto_just_design/providers/misiklist_provider/misiklist_page_provider.dart';
import 'package:proto_just_design/providers/my_page_provider.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/select_screen/Select_screen.dart';
import 'package:proto_just_design/screen_pages/login_page/login_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/main.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List myReview = [];
  List myMisiklist = [];
  String? token;

  logout() async {
    await storage.delete(key: 'token');
    if (mounted) {
      clearFavData();
    }
    if ((mounted
            ? await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ))
            : true) ==
        false) {
      if (mounted) {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectScreen()));
      }
    }
  }

  clearFavData() {
    context.read<MisiklistProvider>().clearFavMisiklist();
    context.read<UserData>().clearFavRestaurant();
  }

  getReviewData() async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) {
      return;
    }
    final url = Uri.parse('${rootURL}v1/reviews/my/');
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      final reviews = responseData['results'];
      myReview.addAll(reviews);
      if (mounted) {
        context.read<MyPageProvider>().changeMyReviewData(myReview);
        setState(() {});
      }
    }
  }

  getMisiklists() async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) {
      return;
    }
    final url = Uri.parse('${rootURL}v1/misiklist/my/');
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      final misiklists = responseData;
      for (final misiklist in misiklists) {
        myMisiklist.add(Misiklist(misiklist));
      }
    }
  }

  void setToken() {
    final getToken = context.read<UserData>().token;
    if (getToken != null) {
      token = getToken;
    }
  }

  @override
  void initState() {
    setToken();
    if (context.read<MyPageProvider>().myPageReviews.isEmpty) {
      getReviewData();
    } else {
      if (mounted) {
        myReview = context.read<MyPageProvider>().myPageReviews;
        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [myPageHeader(context), myPageBody(context)]),
      ),
    );
  }

  Widget myPageHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      color: ColorStyles.red,
      child: Column(
        children: [
          Stack(
            children: [
              Row(children: [
                TextButton(
                    style: ButtonStyles.transparenBtuttonStyle,
                    onPressed: () {
                      context.read<UserData>().logOut();
                      logout();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.output, color: Colors.white, size: 17),
                        Text('로그아웃', style: TextStyle(color: Colors.white))
                      ],
                    )),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.settings, color: Colors.white))
              ]),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15),
                      Text('마이페이지',
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  )
                ],
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(15),
            width: 360,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadows: Boxshadows.defaultShadow,
            ),
            child: Column(
              children: [
                Row(children: [
                  context.watch<UserData>().userProfile != null
                      ? Container(
                          width: 65,
                          height: 65,
                          decoration: const ShapeDecoration(
                              shape: OvalBorder(), color: ColorStyles.silver),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: ColorStyles.ash,
                          ),
                        )
                      : Container(
                          width: 65,
                          height: 65,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${context.watch<UserData>().userProfile}'),
                              fit: BoxFit.cover,
                            ),
                            shape: const OvalBorder(),
                          ),
                        ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${context.read<UserData>().userName}',
                              style: const TextStyle(
                                color: ColorStyles.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(width: 8),
                          const Icon(Icons.people_outline_outlined, size: 20),
                          const SizedBox(width: 3),
                          const Text(
                            'number',
                            style: TextStyle(
                              color: ColorStyles.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '맛있는 돈까츠를 찾으러 다니는 남자',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorStyles.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      style: ButtonStyles.transparenBtuttonStyle,
                      onPressed: () {
                        //edit
                      },
                      icon: const Icon(Icons.border_color_outlined,
                          size: 25, color: ColorStyles.silver))
                ]),
                const SizedBox(height: 20),
                Container(
                  width: 360,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: ColorStyles.ash,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: TextButton(
                                  style: ButtonStyles.transparenBtuttonStyle,
                                  onPressed: () {},
                                  child: Container())),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark,
                              size: 20, color: ColorStyles.red),
                          SizedBox(width: 2),
                          Text(
                            '찜 목록',
                            style: TextStyle(
                                color: ColorStyles.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 160,
                      height: 67,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                          color: const Color(0x33F2B544),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '별점',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorStyles.yellow,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(Icons.star, color: ColorStyles.yellow),
                              SizedBox(width: 10),
                              Text(
                                '3.58',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 160,
                      height: 67,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color: const Color(0x33F25757),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '등급',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorStyles.red,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(Icons.school, color: ColorStyles.red),
                              SizedBox(width: 10),
                              Text(
                                '美각 박사',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget myPageBody(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Row(
            children: [
              Icon(Icons.drive_file_rename_outline_outlined, size: 20),
              SizedBox(width: 5),
              Text(
                '내 리뷰',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorStyles.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 350,
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myReview.length + 1,
              itemBuilder: (context, index) {
                if (index == myReview.length) {
                  return const SizedBox(width: 30);
                }
                final review = RestaurantReview(myReview[index]);
                return myPageReviewWidget(context, review);
              },
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(Icons.drive_file_rename_outline_outlined, size: 20),
              SizedBox(width: 5),
              Text(
                '내 리스트',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorStyles.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 350,
            height: 171,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myReview.length + 1,
              itemBuilder: (context, index) {
                if (index == myReview.length) {
                  return const SizedBox(width: 30);
                }
                final review = RestaurantReview(myReview[index]);
                return myPageReviewWidget(context, review);
              },
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget myPageReviewWidget(BuildContext context, RestaurantReview review) {
    return Container(
      width: 170,
      height: 220,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: Boxshadows.defaultShadow,
          color: Colors.white),
      child: Column(children: [
        Row(
          children: [
            Text(
              review.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorStyles.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              review.updatedAt.substring(0, 10),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorStyles.silver,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        (review.reviewPhotos != [])
            ? SizedBox(
                width: 140,
                height: 37,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: review.reviewPhotos.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: 37,
                        height: 37,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: ColorStyles.silver,
                            image: DecorationImage(
                                image: NetworkImage(
                                    review.reviewPhotos[index]['photo_file']),
                                fit: BoxFit.cover)));
                  },
                ),
              )
            : Container(),
        SizedBox(
          width: 149,
          child: Text(
            review.content,
            maxLines: 8,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: ColorStyles.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1),
          ),
        )
      ]),
    );
  }
}
