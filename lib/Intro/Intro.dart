// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

class Intro1 extends StatefulWidget {
  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  List<String> flavorList = ['맛1', '맛2', '맛3', '맛4', '맛5'];
  List<String> foodList = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> philosophyList = ['1', '2', '3', '4', '5'];
  List<String> tasteList = ['1', '2', '3', '4', '5'];

  String flavor = '';
  String food = '';
  String philosophy = '';
  String taste = '';

  List<Widget> flavorWidgetList = [];
  List<Widget> foodWidgetList = [];
  List<Widget> philosophyWidgetList = [];
  List<Widget> tasteWidgetList = [];
  makeFlavorSelectWidget(List<String> inputFlavorList) {
    //맛 선택 원형 버튼
    flavorWidgetList = [];
    for (String inputFlavor in inputFlavorList) {
      flavorWidgetList.add(Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Container(
            width: 72,
            height: 72,
            decoration: ShapeDecoration(
              color: Colors.transparent,
              shape: OvalBorder(),
            ),
            clipBehavior: Clip.antiAlias,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(
                        flavor == inputFlavor ? 0xFFF25757 : 0xFFD9C5C1))),
                child: Text(inputFlavor),
                onPressed: () {
                  setState(() {
                    flavor = inputFlavor;
                    makeFlavorSelectWidget(inputFlavorList);
                  });
                })),
      ));
    }
  }

  makeFoodSelectWidget(List<String> inputFoodList) {
    // 음식 선택 원형 버튼
    foodWidgetList = [];
    for (String inputFood in inputFoodList) {
      foodWidgetList.add(Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Container(
            width: 72,
            height: 72,
            decoration: ShapeDecoration(
              color: Colors.transparent,
              shape: OvalBorder(),
            ),
            clipBehavior: Clip.antiAlias,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color(food == inputFood ? 0xFFF25757 : 0xFFD9C5C1))),
                child: Text(inputFood),
                onPressed: () {
                  setState(() {
                    food = inputFood;
                    makeFoodSelectWidget(inputFoodList);
                  });
                })),
      ));
    }
  }

  makePhilosophySelectWidget(List<String> inputPhilosophyList) {
    //철학 선택 원형 버튼
    philosophyWidgetList = [];
    for (String inputPhilosophy in inputPhilosophyList) {
      philosophyWidgetList.add(Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Container(
            width: 72,
            height: 72,
            decoration: ShapeDecoration(
              color: Color(
                  philosophy == inputPhilosophy ? 0xFFD9C5C1 : 0xFFF25757),
              shape: OvalBorder(),
            ),
            clipBehavior: Clip.antiAlias,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(
                        philosophy == inputPhilosophy
                            ? 0xFFF25757
                            : 0xFFD9C5C1))),
                child: Text(inputPhilosophy),
                onPressed: () {
                  setState(() {
                    philosophy = inputPhilosophy;
                    makePhilosophySelectWidget(inputPhilosophyList);
                  });
                })),
      ));
    }
  }

  makeTasteSelectWidget(List<String> inputTasteList) {
    // 취향 선택 원형 버튼
    tasteWidgetList = [];
    for (String inputTaste in inputTasteList) {
      tasteWidgetList.add(Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Container(
            width: 72,
            height: 72,
            decoration: ShapeDecoration(
              color: Color(taste == inputTaste ? 0xFFD9C5C1 : 0xFFF25757),
              shape: OvalBorder(),
            ),
            clipBehavior: Clip.antiAlias,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color(taste == inputTaste ? 0xFFF25757 : 0xFFD9C5C1))),
                child: Text(inputTaste),
                onPressed: () {
                  setState(() {
                    taste = inputTaste;
                    makeTasteSelectWidget(inputTasteList);
                  });
                })),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    makeFlavorSelectWidget(flavorList);
    makeFoodSelectWidget(foodList);
    makePhilosophySelectWidget(philosophyList);
    makeTasteSelectWidget(tasteList);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // double screenHeight = 844;
    // double screenWidth = 390;
    double hPP = 1 / 844 * screenHeight; //Height per pixel
    double wPP = 1 / 390 * screenWidth; //Width per pixel
    double cPP = min(hPP, wPP); //for circle Unit

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            height: screenHeight,
            width: screenWidth,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(children: [
              SizedBox(
                  width: 238 * wPP,
                  child: Text.rich(TextSpan(
                      style: TextStyle(
                          color: Color(0xFFF25757),
                          fontSize: 30 * wPP,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w900),
                      text: 'S',
                      children: [
                        TextSpan(
                            text: 'UTA POINTO',
                            style: TextStyle(color: Color(0xFF333333)))
                      ]))),
              SizedBox(height: 57 * hPP),
              Padding(
                padding: EdgeInsets.only(left: 25 * wPP),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('나를 만족시킬 수 있는 맛',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF333333))),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10 * hPP, bottom: 29 * wPP),
                            child: Row(children: flavorWidgetList),
                          )),
                      Text('내가 자주 찾는 음식',
                          style: TextStyle(
                              fontSize: 14 * wPP, color: Color(0xFF333333))),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10 * hPP, bottom: 29 * wPP),
                              child: Row(children: foodWidgetList))),
                      Text('나만의 음식 철학',
                          style: TextStyle(
                              fontSize: 14 * wPP, color: Color(0xFF333333))),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10 * hPP, bottom: 29 * hPP),
                              child: Row(children: philosophyWidgetList))),
                      Text('내가 좋아하는 음식점 취향',
                          style: TextStyle(
                              fontSize: 14 * wPP, color: Color(0xFF333333))),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10 * hPP),
                              child: Row(children: tasteWidgetList)))
                    ]),
              ),
              SizedBox(height: hPP * 47),
              Column(children: [
                Container(
                    width: 238 * wPP,
                    height: 38 * hPP,
                    decoration: ShapeDecoration(
                      color: Color(0xFFBEBEBE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ElevatedButton(
                        onPressed: () {
                          if (flavor != '' &&
                              food != '' &&
                              philosophy != '' &&
                              taste != '') {
                            setState(() {
                              Navigator.pushNamed(context, '/Intro2');
                            });
                          }
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(1),
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFFBEBEBE),
                            )),
                        child: Text('완료'))),
                SizedBox(height: hPP * 28),
                SizedBox(
                    width: 30 * wPP,
                    height: 7.35 * hPP,
                    child: Row(children: [
                      Container(
                          width: 7.35 * cPP,
                          height: 7.35 * cPP,
                          decoration: ShapeDecoration(
                              color: Color(0xFF8E8E93), shape: OvalBorder())),
                      Spacer(),
                      Container(
                          width: 7.35 * cPP,
                          height: 7.35 * cPP,
                          decoration: ShapeDecoration(
                              color: Color(0xFFDEDEDE), shape: OvalBorder())),
                      Spacer(),
                      Container(
                          width: 7.35 * cPP,
                          height: 7.35 * cPP,
                          decoration: ShapeDecoration(
                              color: Color(0xFFDEDEDE), shape: OvalBorder()))
                    ])),
              ])
            ])),
      ),
    );
  }
}

class Intro2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    double cPP = min(hPP, wPP);
    double averageStar = 3.0;
    double flavorValidity = 0.5;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: hPP * screenHeight,
          width: wPP * screenWidth,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(children: [
            SizedBox(
              height: hPP * 95,
            ),
            Container(
                alignment: Alignment.center,
                child: Text.rich(TextSpan(
                    style: TextStyle(
                        color: const Color(0xFFF25757),
                        fontSize: 30 * wPP,
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w900),
                    text: 'S',
                    children: const [
                      TextSpan(
                          text: 'UTA POINTO',
                          style: TextStyle(color: Color(0xFF333333)))
                    ]))),
            SizedBox(height: hPP * 42),
            Container(
              width: 304 * wPP,
              height: 519 * hPP,
              decoration: ShapeDecoration(
                color: const Color(0xFFD9C5C1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                children: [
                  SizedBox(height: hPP * 27),
                  Container(
                      width: 180 * cPP,
                      height: 180 * cPP,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: OvalBorder(),
                      )),
                  SizedBox(height: hPP * 17),
                  Text('낭만 가득한 미식가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 15 * wPP,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 40 * hPP),
                  Row(children: [
                    SizedBox(width: 33 * wPP),
                    const Text('평균 별점'),
                    SizedBox(width: wPP * 4),
                    Container(
                        width: 16 * cPP,
                        height: 16 * cPP,
                        decoration: const ShapeDecoration(
                            gradient: RadialGradient(
                              colors: [Color(0xFFF2B544), Color(0xFFF2B544)],
                            ),
                            shape:
                                StarBorder(points: 5, innerRadiusRatio: 0.38))),
                    SizedBox(width: wPP * 4),
                    Text('$averageStar'),
                  ]),
                  SizedBox(
                    height: hPP * 12,
                  ),
                  Stack(children: [
                    Container(
                        width: 253 * wPP,
                        height: 8 * hPP,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8))),
                    Container(
                      width: 253 * wPP * averageStar / 5,
                      height: 8 * hPP,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF2B544)),
                    )
                  ]),
                  SizedBox(height: hPP * 17),
                  Row(
                    children: [
                      SizedBox(width: 33 * wPP),
                      Text(
                        '맛 신뢰도',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 14 * wPP,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: wPP * 9),
                      SizedBox(
                        width: 6,
                        height: 16,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 6,
                                height: 8.30,
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.38, 0.93),
                                    end: Alignment(0.38, -0.93),
                                    colors: [
                                      Color(0xFFD96A29),
                                      Color(0xFFE59F77)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0.29,
                              top: 0.30,
                              child: Container(
                                width: 5.43,
                                height: 7.70,
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.33, -0.94),
                                    end: Alignment(-0.33, 0.94),
                                    colors: [
                                      Color(0xFFD96A29),
                                      Color(0xFFE49F76)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: wPP * 9),
                      const Text(
                        '0.5',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w400,
                          height: 1.57,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: hPP * 10),
                  Stack(children: [
                    Container(
                        width: 253 * wPP,
                        height: 8 * hPP,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8))),
                    Container(
                      width: 253 * wPP * flavorValidity / 100,
                      height: 8 * hPP,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFD96A29)),
                    )
                  ]),
                  SizedBox(height: hPP * 47),
                  Container(
                      width: 238 * wPP,
                      height: 38 * hPP,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFBEBEBE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(1),
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFBEBEBE),
                              )),
                          child: const Text(
                            '시작하기',
                            style: TextStyle(color: Colors.black),
                          )))
                ],
              ),
            ),
            SizedBox(height: hPP * 66),
            SizedBox(
              width: 30,
              height: 7.35,
              child: Row(
                children: [
                  Container(
                    width: 7.35,
                    height: 7.35,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFBEBEBE),
                      shape: OvalBorder(),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 7.35,
                    height: 7.35,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFDEDEDE),
                      shape: OvalBorder(),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 7.35,
                    height: 7.35,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF8E8E93),
                      shape: OvalBorder(),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
