import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/appColors.dart';
import 'package:proto_just_design/screen_pages/guide_page/guide_page.dart';
import 'package:proto_just_design/screen_pages/myPage/myPage.dart';
import 'package:proto_just_design/screen_pages/qrScree.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const GuidePage(),
    const MyPage()
  ];

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Scaffold(
            body: SafeArea(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: SizedBox(
                height: 60,
                child: _bottomNavigatorBar(MediaQuery.sizeOf(context).width)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => QR()));
                },
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: ShapeDecoration(
                      color: greenAppcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27))),
                  child: Container(
                      child: const Icon(Icons.qr_code_2_rounded,
                          color: Colors.white, size: 37)),
                ),
              ),
              const Gap(25)
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomNavigatorBar(double width) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1))),
      padding: const EdgeInsets.symmetric(horizontal: 55),
      width: width,
      height: 60,
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                _selectedIndex = 0;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 50),
                  _selectedIndex == 0
                      ? Icon(
                          Icons.map,
                          size: 25,
                          color: greenAppcolor,
                        )
                      : const Icon(
                          Icons.map_outlined,
                          size: 25,
                        ),
                  const Gap(5),
                  Text(
                    '지도',
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            _selectedIndex == 0 ? greenAppcolor : Colors.black),
                  )
                ],
              )),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _selectedIndex = 1;
              setState(() {});
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(width: 50),
              _selectedIndex == 1
                  ? Icon(
                      Icons.account_box_rounded,
                      size: 25,
                      color: greenAppcolor,
                    )
                  : const Icon(
                      Icons.account_box_outlined,
                      size: 25,
                    ),
              const Gap(5),
              Text(
                '마이',
                style: TextStyle(
                    fontSize: 13,
                    color: _selectedIndex == 1 ? greenAppcolor : Colors.black),
              )
            ]),
          )
        ],
      ),
    );
  }
}
