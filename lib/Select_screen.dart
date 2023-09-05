import 'package:flutter/material.dart';

class guidePage extends StatefulWidget {
  const guidePage({super.key});

  @override
  State<guidePage> createState() => _guidePageState();
}

class _guidePageState extends State<guidePage> {
  bool fav = true;
  List<String> restaurantStarDetail = [];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: hPP * 137,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: wPP * 27, top: 62 * hPP),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: wPP * 89),
                          child: Row(children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '지역1',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25 * wPP,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    '지역2',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20 * wPP,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined)
                          ]),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Padding(
                      padding: EdgeInsets.only(right: wPP * 27, top: 73 * hPP),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 25,
                          )))
                ])),
            SizedBox(height: 40 * hPP),
            Container(
              padding: EdgeInsets.only(left: wPP * 15),
              height: hPP * 614,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('도쿄가 인정한 예약가능한 맛집'),
                  SizedBox(height: hPP * 10),
                  Container(
                      constraints: BoxConstraints(minHeight: 251 * hPP),
                      width: screenWidth - 15 * wPP,
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              restaurantButton(context, '이름', '가격', 3.0,
                                  "https://via.placeholder.com/171x171"),
                            ]),
                      )),
                  SizedBox(height: hPP * 45),
                  Text('이번주'),
                  SingleChildScrollView(
                      child: Row(), scrollDirection: Axis.horizontal)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget restaurantButton(
    BuildContext context,
    String name,
    String time,
    double star,
    String image,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Container(
      width: 171 * wPP,
      height: hPP * 272,
      decoration: const BoxDecoration(color: Colors.white),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Container(
          width: wPP * 171,
          height: hPP * 171,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
            width: wPP * 171,
            height: hPP * 28,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: wPP * 5, top: hPP * 5, bottom: hPP * 5),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: Offset(0, hPP * 5),
                  child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        if (fav == false) {
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
                              offset: Offset(0, -hPP * 10),
                              child: const Icon(
                                Icons.bookmark_border_sharp,
                                color: Colors.black,
                                size: 30,
                              ),
                            )
                          : Transform.translate(
                              offset: Offset(0, -hPP * 10),
                              child: const Icon(
                                Icons.bookmark,
                                color: Color(0xFFF25757),
                                size: 30,
                              ),
                            )),
                )
              ],
            )),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: wPP * 3, right: wPP * 4),
              child: const Icon(Icons.currency_yen, size: 15),
            ),
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            )
          ],
        ),
        Container(
          width: wPP * 171,
          padding: EdgeInsets.fromLTRB(hPP * 7, hPP * 4, 0, hPP * 4),
          child: Row(
            children: [
              Stack(children: [
                Container(
                    width: 100 * wPP,
                    height: 4 * hPP,
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(8))),
                Container(
                  width: 100 * wPP * (star - 1) / 4,
                  height: 4 * hPP,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF2B544)),
                )
              ]),
              Padding(
                padding: EdgeInsets.only(left: wPP * 5, right: wPP * 5),
                child: Container(
                  width: wPP * 17,
                  child: Text(
                    '$star',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFF2B544),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                      width: wPP * 25,
                      height: hPP * 28,
                      child: Transform.translate(
                        offset: Offset(5, -5),
                        child: ElevatedButton(
                          onPressed: () {
                            if (restaurantStarDetail.contains(name)) {
                              setState(() {
                                restaurantStarDetail.remove(name);
                              });
                            } else {
                              setState(() {
                                restaurantStarDetail.add(name);
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Transform.translate(
                              offset: Offset(-13 * wPP, hPP * 2),
                              child: Icon(
                                restaurantStarDetail.contains(name) == true
                                    ? Icons.keyboard_arrow_down_outlined
                                    : Icons.keyboard_arrow_left_outlined,
                                color: const Color(0xFFE4E4E6),
                              )),
                        ),
                      )),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
