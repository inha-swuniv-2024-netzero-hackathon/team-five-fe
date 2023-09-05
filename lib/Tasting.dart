import 'package:flutter/material.dart';

class Tasting extends StatefulWidget {
  const Tasting({super.key});

  @override
  State<Tasting> createState() => _TastingState();
}

class _TastingState extends State<Tasting> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Scaffold(
        body: SizedBox(
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
          SizedBox(height: hPP * 10),
          SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(left: 22 * wPP),
            child: Container(
                height: hPP * 112,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 25 * wPP),
                      child: Column(
                        children: [
                          Container(
                              clipBehavior: Clip.antiAlias,
                              width: 90 * hPP,
                              height: 90 * hPP,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(17))),
                          SizedBox(height: hPP * 5),
                          Text(
                            '추천 맛집',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          )),
          SizedBox(height: hPP * 50),
          Container(
            padding: EdgeInsets.only(left: wPP * 22),
            alignment: Alignment.centerLeft,
            child: Text(
              '슈포가이너들이 추천하는 오사카 맛집',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1),
            ),
          ),
          SizedBox(height: wPP * 10),
          SingleChildScrollView(
              child: Container(height: hPP * 212, child: Row())),
          SizedBox(height: hPP * 46),
          Container(
              padding: EdgeInsets.only(left: wPP * 22),
              alignment: Alignment.centerLeft,
              child: Text('낭만가득한 미식가들이 추천하는 맛집 여행')),
          SingleChildScrollView(
              child: Container(height: hPP * 212, child: Row()))
        ],
      ),
    ));
  }
}
