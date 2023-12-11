
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  padding: EdgeInsets.only(top: hPP * 5),
                  alignment: Alignment.topLeft,
                  height: hPP * 150,
                  decoration: const BoxDecoration(color: Color(0xCCF25757)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5 * wPP),
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.output,
                                  color: Colors.white,
                                  size: 17,
                                ),
                                Text(
                                  '로그아웃',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                        SizedBox(width: wPP * 55),
                        Text('마이페이지',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Icon(Icons.settings, color: Colors.white))
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: hPP * 100),
                padding: EdgeInsets.fromLTRB(17, 15, 16, 15),
                width: 360 * wPP,
                height: 94 * hPP,
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
                child: Row(children: [
                  Container(
                    width: 65 * hPP,
                    height: 65 * hPP,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/65x65"),
                        fit: BoxFit.cover,
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                  SizedBox(width: wPP * 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('돈까츠러버',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              )),
                          Icon(Icons.add_box_outlined, size: 15 * wPP),
                          SizedBox(width: wPP * 1),
                          Text('@jw28p ')
                        ],
                      ),
                      SizedBox(height: hPP * 10),
                      Row(
                        children: [
                          Container(
                            width: 80 * wPP,
                            height: 26 * hPP,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: ShapeDecoration(
                              color: Color(0x33F2B544),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Color(0xFFF2B544)),
                                Text(
                                  '3.58',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: wPP * 10),
                          Container(
                            width: 110 * wPP,
                            height: 26 * hPP,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: ShapeDecoration(
                              color: Color(0x33F25757),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.interests, color: Color(0xCCF25757)),
                                Text(
                                  '미식가A',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ]),
              )
            ],
          )
        ]),
      ),
    );
  }
}

