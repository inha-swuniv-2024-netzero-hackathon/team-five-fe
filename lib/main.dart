// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:proto_just_design/Intro/Intro.dart';
import 'package:proto_just_design/Intro/Login.dart';
import 'package:proto_just_design/Select_screen.dart';
import 'package:proto_just_design/Tasting.dart';
import 'package:proto_just_design/profile.dart';
import 'package:proto_just_design/restaurant.dart';
import 'package:proto_just_design/review.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'f6cffbfdf469406747f4e7d4c766db25');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false, //우측 상단 배너 끄기
      initialRoute: '/Review',
      routes: {
        '/Intro1': (context) => Intro1(),
        '/Intro2': (context) => Intro2(),
        '/Login': (context) => Login(),
        '/GuidePage': (context) => guidePage(),
        '/Tasting': (context) => Tasting(),
        '/Profile': (context) => Profile_(),
        '/Review': (context) => review(),
        '/Restaurant': (context) => restaurant(),
      },
    );
  }
}
