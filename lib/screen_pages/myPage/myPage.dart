import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/appColors.dart';
import 'package:proto_just_design/model/global/favlist.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';
import 'package:proto_just_design/screen_pages/guide_page/square_restaurant_button.dart';
import 'package:proto_just_design/view_model/global/userVM.dart';
import 'package:proto_just_design/view_model/guide_page/guidePage.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    GuidePInfo guidePInfo = ref.watch(guidePageProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '마이페이지',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 10, top: 20, bottom: 30),
              width: MediaQuery.sizeOf(context).width * 0.85,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
                  borderRadius: BorderRadius.circular(22)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: ShapeDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/image.png')),
                              color: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90))),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Gap(20),
                              Transform.translate(
                                offset: const Offset(0, -3),
                                child: Text('준혁',
                                    style: TextStyle(
                                        color: greenAppcolor, fontSize: 17)),
                              ),
                              const Text(' 유저님 안녕하세요!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        width: 300,
                        height: 30,
                        decoration: ShapeDecoration(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width:
                            300 * max((ref.read(userProvider).coo / 100), 0.1),
                        height: 30,
                        decoration: ShapeDecoration(
                            color: greenAppcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90))),
                        child: Text(
                          '${ref.read(userProvider).coo}p',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('지금까지'),
                      Text(
                        ' ${ref.read(userProvider).coo}점',
                        style: TextStyle(color: greenAppcolor),
                      ),
                      const Text('달성하셨어요!'),
                    ],
                  )
                ],
              ),
            ),
            const Gap(10),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.075),
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '내가 찜한 리스트',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),
            SizedBox(
              height: 274,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: guidePInfo.restList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (ref
                      .watch(favProvider)
                      .contains(guidePInfo.restList[index].uuid)) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SquareRestaurantButton(guidePInfo.restList[index]),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
