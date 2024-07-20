import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/screen_pages/Select_screen.dart';
import 'package:proto_just_design/view_model/global/userVM.dart';
import 'package:proto_just_design/view_model/guide_page/guidePage.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(userProvider.notifier).setLocation();
        await ref.read(guidePageProvider.notifier).getDistance();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SelectScreen()));
        },
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),fit: BoxFit.fill )),
          ),
        ),
      ),
    );
  }
}
