import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation(context);
    getUserToken();
  }

  Future<void> getUserToken() async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) {
      return;
    }
    final String kakaoToken = await storage.read(key: "token") ?? '';
    if (kakaoToken != '') {
      final url = Uri.parse('${rootURL}v1/auth/kakao/login/finish/');
      final response = await http.post(url, body: {'access_token': kakaoToken});
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));
        final token = responseData['access'];
        final userName = responseData['user']['username'];

        await storage.write(key: "token", value: kakaoToken);
        provideUserData(userName, null, token);
      }
    }
    if (mounted) {
      Navigator.pushNamed(context, '/Select_Screen');
    }
  }

  void provideUserData(String? name, String? profile, String token) {
    if (mounted) {
      context.read<UserData>().inputUserData(name ?? 'name', 'profile');
      context.read<UserData>().logIn();
      context.read<UserData>().setToken(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/loading.gif'),
                fit: BoxFit.contain)),
      ),
    );
  }
}
