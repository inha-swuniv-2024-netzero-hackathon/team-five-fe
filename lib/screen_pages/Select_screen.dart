import 'package:flutter/material.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/screen_pages/misiklog_page/misiklog_write_page.dart';
import 'package:proto_just_design/screen_pages/review_page/review_page.dart';
import 'package:proto_just_design/screen_pages/review_page/review_restaurant_select_page.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/screen_pages/guide_page/guide_page.dart';
import 'my_page/my_page.dart';
import 'misiklog_page/misiklog_page.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const GuidePage(),
    const ScriptPage(),
    const ReviewPage(),
    const MyPage()
  ];

  void _onItemTapped(int index) async {
    if (index == _widgetOptions.length - 1) {
      final check = await checkLogin(context);
      if (check) {
        _selectedIndex = index;
      } else {
        _selectedIndex = _selectedIndex;
      }
    } else {
      _selectedIndex = index;
    }
    if (mounted) {
      setState(() {});
    }
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SizedBox(
          height: 58,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.assistant),
                label: '가이드',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.speaker_notes),
                label: '미식로그',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rate_review_outlined),
                label: '리뷰',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: '마이',
              )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: ColorStyles.red,
            unselectedItemColor: ColorStyles.black,
            unselectedLabelStyle: const TextStyle(color: ColorStyles.black),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        floatingActionButton: _selectedIndex == 1
            ? SizedBox(
                width: 70,
                height: 70,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (await checkLogin(context)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MisiklogWritePage(),
                          ));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90)),
                  backgroundColor: ColorStyles.red,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.speaker_notes, color: Colors.white, size: 25),
                      Text(
                        '로그 쓰기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : _selectedIndex == 2
                ? SizedBox(
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      onPressed: () async {
                        if (await checkLogin(context)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ReviewRestaurantSelectPage(),
                              ));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)),
                      backgroundColor: ColorStyles.red,
                      child: Icon(Icons.create_outlined,
                          color: Colors.white, size: 40),
                    ),
                  )
                : null,
      ),
    );
  }
}
