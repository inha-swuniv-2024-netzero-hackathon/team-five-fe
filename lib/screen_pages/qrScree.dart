import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/view_model/global/userVM.dart';

class QR extends ConsumerStatefulWidget {
  const QR({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QRState();
}

class _QRState extends ConsumerState<QR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                  image: NetworkImage(ref.watch(userProvider).qr ??
                      'https://convenii.s3.ap-northeast-2.amazonaws.com/f27ac049-ffb8-42ac-a7d4-1909273f4275'))),
        ),
      ),
    );
  }
}
