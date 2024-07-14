import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:proto_just_design/screen_pages/select_screen/Select_screen.dart';
import 'package:proto_just_design/splash.dart';
import 'package:provider/provider.dart';

String rootURL = 'https://api.misiklog.com/';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '2877c074948b1c5bf00e656eae65ab32',
    javaScriptAppKey: '19461d4bd2ba8a4cd122c53282c81e3d',
  );

  runApp(const ProviderScope(child: MyApp()));
}

const storage = FlutterSecureStorage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //우측 상단 배너 끄기
      home: const SplashScreen(),
      routes: {
        '/Select_Screen': (context) => const SelectScreen(),
      },
    );
  }
}
