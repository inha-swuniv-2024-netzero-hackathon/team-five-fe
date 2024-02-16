import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 30),
          reviewPageHeader(context),
          const SizedBox(height: 5),
          reviewPageBody(context)
        ]),
      ),
    );
  }

  Widget reviewPageHeader(BuildContext context) {
    return Column(children: [
      const Stack(
        children: [
          Row(
            children: [
              SizedBox(width: 15),
              Text('맛집은 리뷰로 기억된다',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Icon(Icons.history_edu_outlined),
              Spacer(),
            ],
          ),
          DefaultSearchMap()
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 175,
                  height: 192,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: Boxshadows.defaultShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
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
                              decoration: const ShapeDecoration(
                                color: Color(0xFF1877F2),
                                shape: StarBorder.polygon(sides: 3),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(18),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: -1.5708,
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const ShapeDecoration(
                                      shape: OvalBorder()),
                                  clipBehavior: Clip.antiAlias,
                                  child: CircularProgressIndicator(
                                      backgroundColor: ColorStyles.white,
                                      value: averageStar / 5,
                                      color: ColorStyles.yellow,
                                      strokeWidth: 15),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
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
                const Spacer(),
                Column(
                  children: [
                    Container(
                      width: 175,
                      height: 69,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: Boxshadows.defaultShadow,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '오늘 작성된 리뷰수',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorStyles.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$reviewNum 명',
                                style: const TextStyle(
                                  color: ColorStyles.red,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                width: 11,
                                height: 11,
                                decoration: const ShapeDecoration(
                                  color: ColorStyles.red,
                                  shape: StarBorder.polygon(sides: 3),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 175,
                      height: 111,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: Boxshadows.defaultShadow,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '가장 많이 작성된 지역',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorStyles.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            area,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: ColorStyles.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$mostReviewAreaNum 개',
                                style: const TextStyle(
                                  color: ColorStyles.red,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                width: 11,
                                height: 11,
                                decoration: const ShapeDecoration(
                                  color: ColorStyles.red,
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
            )
          ],
        ),
      ),
    ]);
  }

  Widget reviewPageBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    '${time.month}월 ${time.day}일 ${time.hour}:${time.minute}',
                    style: const TextStyle(color: ColorStyles.black),
                  ),
                  SizedBox(width: wPP * 5),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          time = DateTime.now();
                        });
                      },
                      icon: const Icon(Icons.refresh, size: 20))
                ],
              ),
            ],
          ),
          const Row(
            children: [
              Text('초고 별점 식당만 모았어요',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Icon(Icons.military_tech_outlined, size: 20)
            ],
          ),
          SizedBox(height: hPP * 18),
          Row(
            children: [
              reviewPageRectangleButton(context, Icons.hotel_class, '4+'),
              const Spacer(),
              reviewPageRectangleButton(context, Icons.restaurant_menu, 'Best'),
              const Spacer(),
              reviewPageRectangleButton(context, Icons.handshake, 'Top50'),
              const Spacer(),
              reviewPageRectangleButton(context, Icons.currency_yen, 'Best'),
            ],
          ),
          SizedBox(height: hPP * 30),
          Row(
            children: [
              const Text('오늘의 한줄평'),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
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
                  padding: EdgeInsets.only(left: wPP * 15),
                  child: Container(
                    width: wPP * 34,
                    height: hPP * 34,
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: ColorStyles.ash),
                  ),
                ),
                Column(
                  children: [
                    Stack(alignment: Alignment.centerLeft, children: [
                      Container(
                          width: 100 * wPP,
                          height: 4 * hPP,
                          decoration: BoxDecoration(
                              color: ColorStyles.ash,
                              borderRadius: BorderRadius.circular(8))),
                      Container(
                        width: 100 * wPP * (2 - 1) / 4,
                        height: 4 * hPP,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorStyles.yellow),
                      ),
                      Container(
                        width: 16 * wPP,
                        height: 16 * wPP,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side:
                                BorderSide(width: 1, color: ColorStyles.yellow),
                          ),
                        ),
                        child: const Icon(
                          Icons.restaurant_menu,
                          color: ColorStyles.yellow,
                          size: 10,
                        ),
                      )
                    ])
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorStyles.ash,
                      size: 30,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget reviewPageRectangleButton(
      BuildContext context, IconData icon, String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;

    return Container(
      width: wPP * 80,
      height: hPP * 80,
      decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: ColorStyles.yellow,
          shadows: Boxshadows.defaultShadow),
      clipBehavior: Clip.none,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24 * wPP),
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyles.transparenBtuttonStyle,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
