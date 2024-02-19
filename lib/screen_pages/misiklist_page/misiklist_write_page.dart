import 'package:flutter/material.dart';

class MisiklistWritePage extends StatefulWidget {
  const MisiklistWritePage({super.key});

  @override
  State<MisiklistWritePage> createState() => _MisiklistWritePageState();
}

class _MisiklistWritePageState extends State<MisiklistWritePage> {
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/location_images/1.jpg'))),
          ),
        ],
      ),
    );
  }
}
