// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:proto_just_design/Intro/Intro.dart';
import 'package:proto_just_design/Intro/Login.dart';
import 'package:proto_just_design/Select_screen.dart';
import 'package:proto_just_design/review.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '2877c074948b1c5bf00e656eae65ab32');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => user_info(),
        ),
        ChangeNotifierProvider(
          create: (context) => guide_page_data(),
        ),
        ChangeNotifierProvider(
          create: (context) => script_page_data(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
      initialRoute: '/Login',
      routes: {
        '/Intro1': (context) => Intro1(),
        '/Intro2': (context) => Intro2(),
        '/Login': (context) => Login(),
        '/Review': (context) => review(),
        '/Select_Screen': (context) => selectScreen()
      },
    );
  }
}
