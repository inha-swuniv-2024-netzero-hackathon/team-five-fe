import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/detail_misiklog_class.dart';
import 'package:proto_just_design/class/misiklog_class.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/detail_misiklist_provider.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/detail_misiklist_page/misiklist_detail_page_bottomsheet.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MisiklogDetailPage extends StatefulWidget {
  final Misiklog misiklog;
  const MisiklogDetailPage({Key? key, required this.misiklog})
      : super(key: key);

  @override
  State<MisiklogDetailPage> createState() => _MisiklogDetailPageState();
}

class _MisiklogDetailPageState extends State<MisiklogDetailPage> {
  late Misiklog misiklog = widget.misiklog;
  String? token;
  MisiklogDetail? misiklogdata;

  Future<void> getMisiklogPageData() async {
    // final url = Uri.parse('${rootURL}v1/misiklogu/${misiklog.uuid}');
    final url = Uri.parse(
        '${rootURL}v1/misiklogu/7776a142-359f-4cc3-bb7a-41d10f889117');
    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      misiklogdata = MisiklogDetail(responseData);
      context
          .read<MisiklistDetailProvider>()
          .setdetailList(misiklogdata!.restaurantList);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> setLike() async {
    final url = Uri.parse(
        '${rootURL}v1/misiklogu/7776a142-359f-4cc3-bb7a-41d10f889117/like/');
    // final url = Uri.parse(
    //     '${rootURL}v1/misiklogu/${misiklog.uuid}/like/');
    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      context.read<MisiklistDetailProvider>().setLike();
    }
  }

  Future<void> setdislike() async {
    final url = Uri.parse(
        '${rootURL}v1/misiklogu/7776a142-359f-4cc3-bb7a-41d10f889117/dislike/');
    // final url = Uri.parse(
    //     '${rootURL}v1/misiklogu/${misiklog.uuid}/dislike/');
    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      context.read<MisiklistDetailProvider>().setDislike();
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
    super.initState();
    setToken();
    getMisiklogPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: misiklogdata == null
            ? Container()
            : Column(
                children: [
                  misiklogDetailPageHeader(context),
                  const Gap(25),
                  misiklogDetailPageBody(context),
                  // misiklogDetailPageLowerButtons(context)
                ],
              ),
      ),
      bottomNavigationBar: misiklogDetailPageBottomNavbar(context),
    );
  }

  Widget misiklogDetailPageHeader(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 14, right: 22, top: 11, bottom: 11),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: NetworkImage(misiklogdata!.thumbnail),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                children: [
                  const Gap(30),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorStyles.black.withOpacity(0.5)),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(misiklogdata!.thumbnail),
                                  fit: BoxFit.cover),
                              shape: const OvalBorder(),
                            ),
                          ),
                          const Gap(5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (misiklogdata?.isPrivate == true
                                    ? '익명'
                                    : misiklogdata!.username!),
                                style: const TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Gap(5),
                              Container(
                                alignment: Alignment.center,
                                width: 36,
                                height: 15,
                                decoration: ShapeDecoration(
                                  color: ColorStyles.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                ),
                                child: const Text(
                                  '등급 1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      width: 62,
                      height: 26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorStyles.black.withOpacity(0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star,
                              color: ColorStyles.yellow, size: 20),
                          const Gap(1),
                          Text(
                            (misiklogdata!.totalRating! / 100)
                                .toStringAsFixed(2),
                            style: const TextStyle(color: ColorStyles.yellow),
                          )
                        ],
                      ),
                    ),
                  ]),
                  const Gap(90),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 270,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '큰 제목',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorStyles.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '글들\n a\n b\n c',
                            maxLines: context
                                    .read<MisiklistDetailProvider>()
                                    .isDetailText
                                ? 5
                                : 1,
                            style: const TextStyle(
                              color: ColorStyles.white,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<MisiklistDetailProvider>().setDetailText();
                        setState(() {});
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            width: 42,
                            height: 22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                color: ColorStyles.black.withOpacity(0.5)),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded,
                              color: ColorStyles.white, size: 30)
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget misiklogDetailPageBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const SortBottomSheet();
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x29000000),
                      blurRadius: 3,
                      offset: Offset(0, 0.50))
                ],
                borderRadius: BorderRadius.circular(90),
                color: ColorStyles.white),
            width: 95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.watch<MisiklistProvider>().detailIcon,
                const Gap(5),
                Text(context.watch<MisiklistProvider>().detailSorting)
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width - 30,
            height: context.read<MisiklistDetailProvider>().detailList.length *
                    120 +
                10,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  context.read<MisiklistDetailProvider>().detailList.length,
              itemBuilder: (context, index) {
                return misiklogRestaurantButton(context,
                    context.read<MisiklistDetailProvider>().detailList[index]);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget misiklogRestaurantButton(BuildContext context, Restaurant restaurant) {
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width - 50,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorStyles.white,
        boxShadow: const [
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
      child: Row(
        children: [
          Container(
              width: 85,
              height: 85,
              decoration: ShapeDecoration(
                  color: ColorStyles.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  image: DecorationImage(
                    image: NetworkImage(restaurant.thumbnail),
                    fit: BoxFit.cover,
                  ))),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: ColorStyles.black,
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const Gap(3),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 145,
                child: Row(
                  children: [
                    Container(
                      height: 23,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                          color: ColorStyles.white,
                          borderRadius: BorderRadius.circular(90),
                          boxShadow: const [
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
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 15,
                            color: ColorStyles.black,
                          ),
                          Gap(2),
                          Text('0.1km')
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        final check = await checkLogin(context);
                        if (check) {
                          setRestaurantBookmark(
                              context, token!, restaurant.uuid);
                        }
                        print('bookmark');
                      },
                      child: const Icon(Icons.bookmark,
                          size: 25, color: ColorStyles.gray),
                    )
                  ],
                ),
              ),
              const Gap(5),
              Container(
                width: 183,
                height: 24,
                decoration: BoxDecoration(
                    color: ColorStyles.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: const [
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
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          makeRatingShower(context, 115, 4, restaurant.rating),
                          Transform.translate(
                            offset: Offset(
                                100 * (restaurant.rating / 100 - 1) / 4, -5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: ColorStyles.yellow),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.star,
                                    color: ColorStyles.yellow, size: 15)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(restaurant.rating.toStringAsFixed(2))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget misiklogDetailPageLowerButtons(BuildContext context) {
    final misiklogList = context.watch<MisiklistProvider>().misiklogs;
    final preMisiklogData = misiklogList.indexOf(misiklog) > 0
        ? misiklogList[misiklogList.indexOf(misiklog) - 1]
        : null;

    final postMisiklogData =
        misiklogList.indexOf(misiklog) < misiklogList.length - 1
            ? misiklogList[misiklogList.indexOf(misiklog) + 1]
            : null;
    return Column(
      children: [
        const Divider(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '비슷한 맛집로그 보기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (preMisiklogData == null)
                      ? const SizedBox(width: 171, height: 226)
                      : Stack(
                          children: [
                            misiklogButton(context, preMisiklogData),
                            Container(
                              width: 171,
                              height: 131,
                              color: Colors.transparent,
                              child: Expanded(
                                child: TextButton(
                                    style: ButtonStyles.transparenBtuttonStyle,
                                    onPressed: () {
                                      misiklog = preMisiklogData;
                                      setState(() {});
                                    },
                                    child: Container()),
                              ),
                            )
                          ],
                        ),
                  const Gap(20),
                  (postMisiklogData == null)
                      ? const SizedBox(width: 171, height: 226)
                      : Stack(
                          children: [
                            misiklogButton(context, postMisiklogData),
                            Container(
                              width: 171,
                              height: 131,
                              color: Colors.transparent,
                              child: Expanded(
                                child: TextButton(
                                    style: ButtonStyles.transparenBtuttonStyle,
                                    onPressed: () {
                                      misiklog = postMisiklogData;
                                      setState(() {});
                                    },
                                    child: Container()),
                              ),
                            )
                          ],
                        )
                ],
              )
            ],
          ),
        ),
        const Gap(40)
      ],
    );
  }

  Widget misiklogDetailPageBottomNavbar(BuildContext context) {
    return Container(
        height: 60,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: ColorStyles.white, boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, -2),
          )
        ]),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final check = await checkLogin(context);
                  if (check) {
                    if (mounted) {
                      context.read<MisiklistDetailProvider>().setLike();
                    }
                    setState(() {});
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      (context.watch<MisiklistDetailProvider>().isGood == true)
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      color: (context.watch<MisiklistDetailProvider>().isGood ==
                              true)
                          ? ColorStyles.red
                          : ColorStyles.black,
                    ),
                    const Gap(3),
                    Text(
                      '추천',
                      style: TextStyle(
                          color: (context
                                      .watch<MisiklistDetailProvider>()
                                      .isGood ==
                                  true)
                              ? ColorStyles.red
                              : ColorStyles.black),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final check = await checkLogin(context);
                  if (check) {
                    context.read<MisiklistDetailProvider>().setDislike();
                    setState(() {});
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      (context.watch<MisiklistDetailProvider>().isGood == true)
                          ? Icons.thumb_down
                          : Icons.thumb_down_outlined,
                      color: (context.watch<MisiklistDetailProvider>().isGood ==
                              false)
                          ? ColorStyles.red
                          : ColorStyles.black,
                    ),
                    const Gap(3),
                    Text(
                      '비추천',
                      style: TextStyle(
                          color: (context
                                      .watch<MisiklistDetailProvider>()
                                      .isGood ==
                                  false)
                              ? ColorStyles.red
                              : ColorStyles.black),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.comment_outlined,
                    color: ColorStyles.black,
                  ),
                  const Gap(3),
                  Text(
                    '댓글',
                    style: TextStyle(color: ColorStyles.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final check = await checkLogin(context);
                  if (check) {
                    setMisiklogBookmark(context, misiklogdata!.uuid);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: (context
                              .watch<MisiklistProvider>()
                              .favMisiklogList
                              .contains(misiklog.uuid))
                          ? ColorStyles.red
                          : ColorStyles.silver,
                    ),
                    const Gap(3),
                    Text(
                      '찜',
                      style: TextStyle(
                          color: (context
                                  .watch<MisiklistProvider>()
                                  .favMisiklogList
                                  .contains(misiklog.uuid))
                              ? ColorStyles.red
                              : ColorStyles.black),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
