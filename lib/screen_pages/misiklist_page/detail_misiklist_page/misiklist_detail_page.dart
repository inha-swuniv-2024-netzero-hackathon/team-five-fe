import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/detail_misiklist_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/detail_misiklist_page/misiklist_detail_page_bottomsheet.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/detail_misiklist_page/misiklist_detail_page_restaurant_button.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MisiklistDetailPage extends StatefulWidget {
  final Misiklist misiklist;
  const MisiklistDetailPage({Key? key, required this.misiklist})
      : super(key: key);

  @override
  State<MisiklistDetailPage> createState() => _MisiklistDetailPageState();
}

class _MisiklistDetailPageState extends State<MisiklistDetailPage> {
  Future<void> getMisiklistPageData(String? token, String uuid) async {
    final url = Uri.parse('${rootURL}v1/misiklist/$uuid');
    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      MisikListDetail misiklistdata = MisikListDetail(responseData);
      if (mounted) {
        context.read<MisiklistDetailProvider>().setMisikList(misiklistdata);
        context
            .read<MisiklistDetailProvider>()
            .setdetailList(misiklistdata.restaurantList);
      }
    } else {
      if (response.statusCode == 401) {
        //token다시 받아오기
      }
    }
  }

  // Future<void> setLike(String? token, String uuid) async {
  //   final url = Uri.parse('${rootURL}v1/misiklist/$uuid/like/');
  //   final response = (token == null)
  //       ? await http.get(url)
  //       : await http.get(url, headers: {"Authorization": "Bearer $token"});
  //   if (response.statusCode == 200) {
  //     if (mounted) {
  //       context.read<MisiklistDetailProvider>().setLike();
  //     }
  //   }
  // }

  // Future<void> setdislike(String? token, String uuid) async {
  //   final url = Uri.parse('${rootURL}v1/misiklist/$uuid/dislike/');
  //   final response = (token == null)
  //       ? await http.get(url)
  //       : await http.get(url, headers: {"Authorization": "Bearer $token"});
  //   if (response.statusCode == 200) {
  //     if (mounted) {
  //       context.read<MisiklistDetailProvider>().setDislike();
  //     }
  //   }
  // }

  Future<int> setBookmark(String uuid) async {
    return 1;
  }

  @override
  void initState() {
    super.initState();
    getMisiklistPageData(context.read<UserData>().token, widget.misiklist.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<MisiklistDetailProvider>().setMisikList(null);
        context.read<MisiklistDetailProvider>().setDetailMisiklistSort(
            '추천순',
            const Icon(
              Icons.thumb_up,
              color: ColorStyles.red,
              size: 20,
            ));
      },
      child: Scaffold(
        body: context.watch<MisiklistDetailProvider>().misiklist == null
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    pageHeader(context),
                    const Gap(25),
                    pageBody(context),
                    // misiklogDetailPageLowerButtons(context)
                  ],
                ),
              ),
        // bottomNavigationBar: const MisiklistDetailBottomNavbar(),
      ),
    );
  }

  Widget pageHeader(
    BuildContext context,
  ) {
    MisikListDetail? misiklist =
        context.watch<MisiklistDetailProvider>().misiklist;
    return (misiklist != null)
        ? Column(
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
                          image: NetworkImage(misiklist.thumbnail),
                          fit: BoxFit.cover,
                        )),
                    child: Column(
                      children: [
                        const Gap(30),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                            image: NetworkImage(
                                                misiklist.thumbnail),
                                            fit: BoxFit.cover),
                                        shape: const OvalBorder(),
                                      ),
                                    ),
                                    const Gap(5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ('익명'),
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
                                              borderRadius:
                                                  BorderRadius.circular(90),
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
                                      (300 / 100).toStringAsFixed(2),
                                      style: const TextStyle(
                                          color: ColorStyles.yellow),
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
                              context
                                  .read<MisiklistDetailProvider>()
                                  .setDetailText();
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
                                      color:
                                          ColorStyles.black.withOpacity(0.5)),
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
          )
        : Container();
  }

  Widget pageBody(BuildContext context) {
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
                context.watch<MisiklistDetailProvider>().icon,
                const Gap(5),
                Text(context.watch<MisiklistDetailProvider>().sorting)
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width - 30,
            height:
                context.read<MisiklistDetailProvider>().restaurantList.length *
                        120 +
                    10,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  context.read<MisiklistDetailProvider>().restaurantList.length,
              itemBuilder: (context, index) {
                return DetailMisiklistRestaurantButton(
                    restaurant: context
                        .read<MisiklistDetailProvider>()
                        .restaurantList[index]);
              },
            ),
          ),
        )
      ],
    );
  }

  // Widget lowerButtons(BuildContext context) {
  //   MisikListDetail misiklist =
  //       context.watch<MisiklistDetailProvider>().misiklist;

  //   final misiklogList = context.watch<MisiklistProvider>().misiklogs;
  //   final preMisiklogData = misiklogList.indexOf(misiklist) > 0
  //       ? misiklogList[misiklogList.indexOf(misiklist) - 1]
  //       : null;

  //   final postMisiklogData =
  //       misiklogList.indexOf(misiklist) < misiklogList.length - 1
  //           ? misiklogList[misiklogList.indexOf(misiklist) + 1]
  //           : null;
  //   return Column(
  //     children: [
  //       const Divider(),
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.only(left: 15, right: 15),
  //         child: Column(
  //           children: [
  //             const Align(
  //               alignment: Alignment.topCenter,
  //               child: Text(
  //                 '비슷한 맛집로그 보기',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 13,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ),
  //             const Gap(20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 (preMisiklogData == null)
  //                     ? const SizedBox(width: 171, height: 226)
  //                     : Stack(
  //                         children: [
  //                           MisiklogButton(misiklog: preMisiklogData),
  //                           Container(
  //                             width: 171,
  //                             height: 131,
  //                             color: Colors.transparent,
  //                             child: Expanded(
  //                               child: TextButton(
  //                                   style: ButtonStyles.transparenBtuttonStyle,
  //                                   onPressed: () {
  //                                     misiklist = preMisiklogData;
  //                                     setState(() {});
  //                                   },
  //                                   child: Container()),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                 const Gap(20),
  //                 (postMisiklogData == null)
  //                     ? const SizedBox(width: 171, height: 226)
  //                     : Stack(
  //                         children: [
  //                           MisiklogButton(misiklog: postMisiklogData),
  //                           Container(
  //                             width: 171,
  //                             height: 131,
  //                             color: Colors.transparent,
  //                             child: Expanded(
  //                               child: TextButton(
  //                                   style: ButtonStyles.transparenBtuttonStyle,
  //                                   onPressed: () {
  //                                     misiklist = postMisiklogData;
  //                                     setState(() {});
  //                                   },
  //                                   child: Container()),
  //                             ),
  //                           )
  //                         ],
  //                       )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //       const Gap(40)
  //     ],
  //   );
  // }
}
