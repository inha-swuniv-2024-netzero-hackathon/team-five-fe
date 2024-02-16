import 'package:flutter/material.dart';

class MisiklogWritePage extends StatefulWidget {
  const MisiklogWritePage({super.key});

  @override
  State<MisiklogWritePage> createState() => _MisiklogWritePageState();
}

class _MisiklogWritePageState extends State<MisiklogWritePage> {
  double bottomModalHeight = 500;
  double delayedHeight = 500;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/location_images/1.jpg'))),
          ),
        ],
      ),
    );
  }
}
