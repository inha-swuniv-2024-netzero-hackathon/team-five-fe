import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    apcheck();
  }

  apcheck() async {
    final next = await appVersionCheck();
    if (next == true) {
      getUserToken();
      getCurrentLocation(context);
    }
  }

  Future<bool> appVersionCheck() async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) {
      showDialog(context: context, builder: (context) => const PopDialog());
      return false;
    }
    final uri = Uri.parse('$rootURL/v1/version/android/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      final nowVerStr = await PackageInfo.fromPlatform();
      String minVerStr = responseData['min_version'];
      List<int> nowVer =
          nowVerStr.version.toString().split('.').map(int.parse).toList();
      List<int> minVer = minVerStr.split('.').map(int.parse).toList();
      for (int i = 0; i < nowVer.length; i++) {
        if (nowVer[i] < minVer[i]) {
          await showDialog(
              context: context, builder: (context) => const PopDialog());
          return false;
        }
      }
      return true;
    } else {
      showDialog(context: context, builder: (context) => const PopDialog());
    }
    return false;
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
      context.read<UserDataProvider>().inputUserData(name ?? 'name', 'profile');
      context.read<UserDataProvider>().logIn();
      context.read<UserDataProvider>().setToken(token);
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

class PopDialog extends StatelessWidget {
  const PopDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('업데이트가 필요합니다'),
              ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('확인'))
            ],
          ),
        ),
      ),
    );
  }
}
