import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screen_pages/guide_page.dart';
import 'screen_pages/my_page.dart';
import 'screen_pages/review_page.dart';
import 'screen_pages/script_page.dart';

class selectScreen extends StatefulWidget {
  const selectScreen({super.key});

  @override
  State<selectScreen> createState() => _selectScreenState();
}
  
class _selectScreenState extends State<selectScreen> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    guidePage(),
    scriptPage(),
    reviewPage(),
    myPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    
  }
  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: '가이드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: '스크립트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speaker_notes_outlined),
            label: '리뷰',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review_outlined),
            label: '마이',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFF25757),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        onTap: _onItemTapped,
      ),
    );
  }
}
