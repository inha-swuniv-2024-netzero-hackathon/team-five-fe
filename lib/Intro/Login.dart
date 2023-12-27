import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  String kakao_token = '';
  static final storage = new FlutterSecureStorage();

  get_kakao_token() async {
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        kakao_token = '${token.accessToken}';
        Navigator.pushNamed(context, '/Select_Screen');
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
          print('카카오계정으로 로그인 성공 ${token.accessToken}');
          kakao_token = '${token.accessToken}';
          Navigator.pushNamed(context, '/Select_Screen');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        kakao_token = '${token.accessToken}';
        print('카카오계정으로 로그인 성공 ${token.accessToken}');
        Navigator.pushNamed(context, '/Select_Screen');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  post_kakao_user_token() async {
    final url =
        Uri.parse('https://basak.chungran.net/v1/auth/kakao/login/finish/');
    final response = await http.post(url, body: {'access_token': kakao_token});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      final kakao_access = responseData['access'];
      final username = responseData['user']['username'];
      print(responseData);
      await storage.write(key: 'kakao_token', value: '${kakao_access}');
      await storage.write(key: 'username', value: '${username}');
    } else
      print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    read_userinfo();
  }

  read_userinfo() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    final userInfo = (await storage.read(key: "kakao_token"));
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Navigator.pushNamed(context, '/Select_Screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double hPP = 1 / 844 * screenHeight;
    double wPP = 1 / 390 * screenWidth;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: wPP * screenWidth,
          height: hPP * screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: hPP * 168),
              Container(
                  alignment: Alignment.center,
                  child: Text.rich(TextSpan(
                      style: TextStyle(
                          color: const Color(0xFFF25757),
                          fontSize: 30 * wPP,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w900),
                      text: 'S',
                      children: const [
                        TextSpan(
                            text: 'UTA POINTO',
                            style: TextStyle(color: Color(0xFF333333)))
                      ]))),
              SizedBox(height: hPP * 79),
              Container(
                alignment: Alignment.centerLeft,
                width: 270 * wPP,
                height: 44 * hPP,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 16 * wPP, right: 16 * wPP),
                  child: TextField(
                    controller: loginController,
                    decoration: InputDecoration(
                        hintText: '아이디를 입력하세요',
                        hintStyle: const TextStyle(color: Color(0x993C3C43)),
                        suffixIcon: IconButton(
                          onPressed: loginController.clear,
                          icon: const Icon(Icons.cancel_outlined),
                          style: ButtonStyle(
                              iconSize: MaterialStateProperty.all(wPP * 17)),
                        )),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                  ),
                ),
              ),
              SizedBox(height: hPP * 9),
              SizedBox(
                  width: 270 * wPP,
                  height: 44 * hPP,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16 * wPP, right: 16 * wPP),
                    child: TextField(
                      controller: passwordContoller,
                      decoration: InputDecoration(
                        hintText: '비밀번호를 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: passwordContoller.clear,
                          icon: const Icon(Icons.cancel_outlined),
                          style: ButtonStyle(
                              iconSize: MaterialStateProperty.all(wPP * 17)),
                        ),
                      ),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      onSubmitted: (value) {},
                    ),
                  )),
              SizedBox(height: hPP * 79),
              Container(
                width: wPP * 250,
                height: hPP * 36,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              ),
              SizedBox(height: hPP * 15),
              Container(
                  width: wPP * 250,
                  height: hPP * 36,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.antiAlias,
                  child: ElevatedButton(
                    onPressed: () {
                      get_kakao_token().then((value) {
                        post_kakao_user_token();
                      });
                    },
                    child: Container(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent)),
                  )),
              SizedBox(height: hPP * 15),
              Container(
                width: wPP * 250,
                height: hPP * 36,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
