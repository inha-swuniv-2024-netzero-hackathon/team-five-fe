import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  String kakaoToken = '';

  Future<void> getKakaoToken() async {
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        kakaoToken = token.accessToken;
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          kakaoToken = token.accessToken;
          print('카카오계정으로 로그인 성공 ${token.accessToken}');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        kakaoToken = token.accessToken;
        print('카카오계정으로 로그인 성공 ${token.accessToken}');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  Future<void> getUserToken() async {
    final url = Uri.parse('${rootURL}v1/auth/kakao/login/finish/');
    final response = await http.post(url, body: {'access_token': kakaoToken});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      final token = responseData['access'];
      final userName = responseData['user']['username'];
      print(token);

      await storage.write(key: "token", value: kakaoToken);
      provideUserData(userName, null, token);

      // Navigator.pushNamed(context, '/Select_Screen');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation(context);
  }

  void provideUserData(String? name, String? profile, String token) {
    if (mounted) {
      context.read<UserData>().inputUserData(name ?? 'name', 'profile');
      context.read<UserData>().logIn();
      context.read<UserData>().setToken(token);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          return Navigator.of(context).pop(false);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 168),
                Container(
                    alignment: Alignment.center,
                    child: const Text.rich(TextSpan(
                        style: TextStyle(
                            color: ColorStyles.red,
                            fontSize: 30,
                            fontFamily: 'Segoe UI',
                            fontWeight: FontWeight.w900),
                        text: '美',
                        children: [
                          TextSpan(
                              text: '식록',
                              style: TextStyle(color: ColorStyles.black))
                        ]))),
                const SizedBox(height: 79),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 270,
                  height: 44,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      controller: loginController,
                      decoration: InputDecoration(
                          hintText: '아이디를 입력하세요',
                          hintStyle: const TextStyle(color: Color(0x993C3C43)),
                          suffixIcon: IconButton(
                            onPressed: loginController.clear,
                            icon: const Icon(Icons.cancel_outlined),
                            style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(17)),
                          )),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                SizedBox(
                    width: 270,
                    height: 44,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextField(
                        controller: passwordContoller,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요',
                          suffixIcon: IconButton(
                            onPressed: passwordContoller.clear,
                            icon: const Icon(Icons.cancel_outlined),
                            style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(17)),
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        onSubmitted: (value) {},
                      ),
                    )),
                const SizedBox(height: 79),
                ElevatedButton(
                  onPressed: () {
                    getKakaoToken().then((value) {
                      getUserToken();
                    });
                  },
                  style: ButtonStyles.transparenBtuttonStyle,
                  child: Image.asset(
                    'assets/images/kakao_login.png',
                    width: 300,
                    height: 45,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    // Navigator.pushNamed(context, '/Select_Screen');
                  },
                  style: ButtonStyles.transparenBtuttonStyle,
                  child: Image.asset(
                    'assets/images/not_login.png',
                    width: 300,
                    height: 45,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}