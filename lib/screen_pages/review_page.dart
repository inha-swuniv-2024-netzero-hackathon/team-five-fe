import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                  padding: EdgeInsets.only(left: wPP * 15),
                  child: Container(
                    width: wPP * 34,
                    height: hPP * 34,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(), color: Colors.grey),
                  ),
                ),
                Column(
                  children: [
                    Stack(alignment: Alignment.centerLeft, children: [
                      Container(
                          width: 100 * wPP,
                          height: 4 * hPP,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(8))),
                      Container(
                        width: 100 * wPP * (2 - 1) / 4,
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
                Spacer(),
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
