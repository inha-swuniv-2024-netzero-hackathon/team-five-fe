import 'package:flutter/material.dart';

class Profile_ extends StatefulWidget {
  const Profile_({super.key});

  @override
  State<Profile_> createState() => _Profile_State();
}

class _Profile_State extends State<Profile_> {
  int sort = 1;
  double averageStar = 3.0;
  double flavorValidity = 0.5;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: hPP * 76,
        ),
        Stack(children: [
          Container(
              padding: EdgeInsets.only(left: 15 * wPP),
              height: hPP * 80,
              child: Row(children: [
                Container(
                  width: wPP * 80,
                  height: wPP * 80,
                  decoration:
                      ShapeDecoration(shape: OvalBorder(), color: Colors.black),
                ),
                SizedBox(width: wPP * 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ㅁㅈㅇ',
                      style: TextStyle(
                        color: Color(0xFFF25757),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: hPP * 10),
                    Text('ㄴㅁㄱㄷㅎㅁㅅㄱ',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1)),
                    SizedBox(height: hPP * 10),
                    Row(
                      children: [
                        Container(
                            width: 16,
                            height: 16,
                            decoration: ShapeDecoration(
                                color: Color(0xFFF2B544),
                                shape: StarBorder(
                                    points: 5,
                                    innerRadiusRatio: 0.38,
                                    pointRounding: 0,
                                    valleyRounding: 0,
                                    rotation: 0,
                                    squash: 0))),
                        SizedBox(width: wPP * 5),
                        Text('$averageStar',
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1)),
                        SizedBox(width: wPP * 3),
                        Text('/5',
                            style: TextStyle(
                                color: Color(0xFFBEBEBE),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1)),
                        SizedBox(width: wPP * 15),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.40, color: Color(0xFFF25757)),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                        SizedBox(width: wPP * 5),
                        Text('$flavorValidity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1)),
                        Text('/100',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFBEBEBE),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1))
                      ],
                    )
                  ],
                )
              ])),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert,
                      size: 30 * wPP, color: Colors.black)),
            ],
          )
        ]),
        SizedBox(height: hPP * 31),
        Container(
            padding: EdgeInsets.only(left: wPP * 15),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    width: 175 * wPP,
                    height: 47 * hPP,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
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
                        ]),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.chat_rounded,
                            color: Color(0xFFF25757),
                          ),
                          SizedBox(width: wPP * 5),
                          const Text(
                            '리뷰 작성하기',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: wPP * 10),
                  Container(
                    width: 175 * wPP,
                    height: 47 * hPP,
                    clipBehavior: Clip.antiAlias,
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
                        ]),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.wine_bar_outlined,
                            color: Color(0xFFF25757),
                          ),
                          SizedBox(width: wPP * 5),
                          const Text(
                            '테이스팅 작성하기',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: hPP * 15),
              Row(
                children: [
                  Container(
                    width: 175 * wPP,
                    height: 47 * hPP,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
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
                        ]),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.emoji_events_outlined,
                            color: Color(0xFFF25757),
                          ),
                          SizedBox(width: wPP * 5),
                          const Text(
                            '순위 확인하기',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: wPP * 10),
                  Container(
                    width: 175 * wPP,
                    height: 47 * hPP,
                    clipBehavior: Clip.antiAlias,
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
                        ]),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_activity_outlined,
                            color: Color(0xFFF25757),
                          ),
                          SizedBox(width: wPP * 5),
                          const Text(
                            '할인 이벤트',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: hPP * 32),
              Padding(
                  padding: EdgeInsets.only(left: wPP * 18),
                  child: Row(children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 21,
                          alignment: Alignment.topCenter,
                          decoration: ShapeDecoration(
                              color: sort == 1
                                  ? Color(0xFFF25757)
                                  : Color(0xFFE4E4E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          clipBehavior: Clip.antiAlias,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  sort = 1;
                                });
                              },
                              child: Container(),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent))),
                        ),
                        Text('최신순',
                            style: TextStyle(
                              color: sort == 1 ? Colors.white : Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                    SizedBox(width: wPP * 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 21,
                          alignment: Alignment.topCenter,
                          decoration: ShapeDecoration(
                              color: sort == 2
                                  ? Color(0xFFF25757)
                                  : Color(0xFFE4E4E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          clipBehavior: Clip.antiAlias,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  sort = 2;
                                });
                              },
                              child: Container(),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent))),
                        ),
                        Text('별점순',
                            style: TextStyle(
                              color: sort == 2 ? Colors.white : Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                    SizedBox(width: wPP * 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 21,
                          alignment: Alignment.topCenter,
                          decoration: ShapeDecoration(
                              color: sort == 3
                                  ? Color(0xFFF25757)
                                  : Color(0xFFE4E4E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          clipBehavior: Clip.antiAlias,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  sort = 3;
                                });
                              },
                              child: Container(),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent))),
                        ),
                        Text('거리순',
                            style: TextStyle(
                              color: sort == 3 ? Colors.white : Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                    SizedBox(width: wPP * 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 21,
                          alignment: Alignment.topCenter,
                          decoration: ShapeDecoration(
                              color: sort == 4
                                  ? Color(0xFFF25757)
                                  : Color(0xFFE4E4E6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          clipBehavior: Clip.antiAlias,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  sort = 4;
                                });
                              },
                              child: Container(),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent))),
                        ),
                        Text('저장됨',
                            style: TextStyle(
                              color: sort == 4 ? Colors.white : Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ])),
              SizedBox(height: hPP * 32),
              Container(
                width: wPP * 340,
                constraints: BoxConstraints(minHeight: hPP * 588),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
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
                  children: [
                    SizedBox(height: hPP * 25),
                    Padding(
                      padding: EdgeInsets.only(left: wPP * 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: wPP * 31,
                              height: wPP * 31,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(90))),
                          SizedBox(width: wPP * 8),
                          Container(
                            width: wPP * 171,
                            constraints: BoxConstraints(minHeight: hPP * 60),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('텐동 마스터',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFF25757),
                                            fontSize: 11,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1))
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.bookmark,
                                          color: Color(0xFFF25757), size: 17)
                                    ]),
                                SizedBox(height: hPP * 5),
                                Row(
                                  children: [
                                    Stack(children: [
                                      Container(
                                          width: 115 * wPP,
                                          height: 8 * hPP,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFD9D9D9),
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      Container(
                                        width: 115 * wPP * averageStar / 5,
                                        height: 8 * hPP,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xFFF2B544)),
                                      )
                                    ]),
                                    SizedBox(width: wPP * 11),
                                    Text('$averageStar'),
                                    Icon(Icons.keyboard_arrow_down_outlined,
                                        color: Colors.grey[300], size: 25)
                                  ],
                                ),
                                SizedBox(height: hPP * 13),
                                Text('8/4 금요일 두번째 방문',
                                    style: TextStyle(
                                        color: Color(0xFF8E8E93),
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.20)),
                                SizedBox(height: hPP * 13),
                                Text('ㅁ\nㅜ\nㄹ'),
                                SizedBox(height: hPP * 15),
                                Container(
                                  width: 84,
                                  height: 23,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]))
      ])),
    ));
  }
}
