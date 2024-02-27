import 'package:flutter/material.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/guide_provider/guide_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:provider/provider.dart';

class ChangeArea extends StatefulWidget {
  const ChangeArea({super.key});

  @override
  State<ChangeArea> createState() => _ChangeAreaState();
}

class _ChangeAreaState extends State<ChangeArea> {
  late LocationList initLocation;
  LocationList? loc;
  @override
  void initState() {
    initLocation = context.read<GuidePageProvider>().selectArea;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (loc == null) {
          context.read<GuidePageProvider>().setArea(initLocation);
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    changeAreaPageHeader(context),
                    selectBigArea(context),
                    const SizedBox(height: 20),
                    selectSmallArea(context),
                  ],
                ),
              ),
            ),
          ),
          checkButton(context)
        ],
      )),
    );
  }

  Widget changeAreaPageHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.where_to_vote, size: 30, color: ColorStyles.red),
            Row(
              children: [
                Text(context.watch<GuidePageProvider>().selectArea.bigArea,
                    style: const TextStyle(
                        color: ColorStyles.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                Text(context.read<GuidePageProvider>().selectArea.smallArea,
                    style: const TextStyle(
                        color: ColorStyles.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600))
              ],
            ),
          ],
        ),
        const SizedBox(height: 35),
        Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  getCurrentLocation(context);
                  final nowLat = context.read<UserData>().latitude;
                  final nowLon = context.read<UserData>().longitude;
                  double min = 10000;
                  LocationList area = LocationList.area1;
                  for (LocationList location in LocationList.values) {
                    final distance = checkDistance(
                        nowLat, nowLon, location.latitude, location.longitude);
                    if (min > distance) {
                      min = distance.toDouble();
                      area = location;
                    }
                  }
                  if (mounted) {
                    context.read<GuidePageProvider>().setArea(area);
                    context.read<GuidePageProvider>().setRestaurants([]);
                    Navigator.pop(context, true);
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.my_location_outlined, color: ColorStyles.red),
                    Text(
                      '현재 위치로 설정 ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ],
    );
  }

  Widget selectBigArea(BuildContext context) {
    List<String> bigAreaList = LocationList.values
        .map((location) => location.bigArea)
        .toSet()
        .toList();
    return Column(
      children: [
        const Row(
          children: [
            Text(
              '지역분류1',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorStyles.black,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 2),
            Text(
              '을 선택해주세요',
              style: TextStyle(
                color: ColorStyles.black,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: ((bigAreaList.length ~/ 3) + 1) * 124 + 20,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bigAreaList.length,
            itemBuilder: (context, index) {
              if (index % 3 == 0) {
                if ((bigAreaList.length < index + 3)) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      bigAreaButton(
                          bigAreaList[index], '${100000 + index + 1}'),
                      const SizedBox(width: 27),
                      (bigAreaList.length % 3 != 1)
                          ? bigAreaButton(
                              bigAreaList[index + 1], '${100000 + index + 2}')
                          : const SizedBox(width: 102, height: 102),
                      const SizedBox(width: 27),
                      (bigAreaList.length % 3 == 0)
                          ? bigAreaButton(
                              bigAreaList[index + 2], '${100000 + index + 3}')
                          : const SizedBox(width: 102, height: 102),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bigAreaButton(bigAreaList[index], '${100000 + index + 1}'),
                    const SizedBox(width: 27),
                    bigAreaButton(
                        bigAreaList[index + 1], '${100000 + index + 2}'),
                    const SizedBox(width: 27),
                    bigAreaButton(
                        bigAreaList[index + 2], '${100000 + index + 2}'),
                  ],
                );
              }
              return const SizedBox(height: 11);
            },
          ),
        ),
      ],
    );
  }

  Widget bigAreaButton(String area, String image) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 102,
          height: 102,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage('assets/images/$image.jpg'),
                fit: BoxFit.cover,
              )),
        ),
        Container(
          alignment: Alignment.center,
          width: 102,
          height: 24,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Text(
            area,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorStyles.black,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        (context.read<GuidePageProvider>().bigArea == area)
            ? Container(
                width: 102,
                height: 102,
                decoration: ShapeDecoration(
                  color: ColorStyles.red.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Icon(Icons.where_to_vote_rounded,
                    color: Colors.white, size: 40),
              )
            : SizedBox(
                width: 102,
                height: 102,
                child: TextButton(
                    style: ButtonStyles.transparenBtuttonStyle,
                    onPressed: () {
                      context.read<GuidePageProvider>().setBigArea(area);
                    },
                    child: const SizedBox()),
              )
      ],
    );
  }

  Widget selectSmallArea(BuildContext context) {
    List areaList = LocationList.values
        .where((area) =>
            area.bigArea == context.watch<GuidePageProvider>().bigArea)
        .toList();
    return Column(
      children: [
        const Row(children: [
          Text('지역분류2',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorStyles.black,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600)),
          SizedBox(width: 2),
          Text('를 선택해주세요',
              style: TextStyle(
                  color: ColorStyles.black,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400))
        ]),
        const SizedBox(height: 30),
        SizedBox(
          height: 123 * areaList.length ~/ 4 + 150,
          width: double.infinity,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: areaList.length,
            itemBuilder: (context, index) {
              final len = areaList.length;
              if (index % 4 == 0) {
                if ((len % 4 > 0) && (index + 4 > len)) {
                  return Row(
                    children: [
                      smallAreaButton(areaList[index]),
                      const SizedBox(width: 12),
                      (len % 4 > 1)
                          ? smallAreaButton(areaList[index + 1])
                          : Container(width: 80),
                      const SizedBox(width: 12),
                      (len % 4 > 2)
                          ? smallAreaButton(areaList[index + 2])
                          : Container(width: 80),
                      const SizedBox(width: 12),
                      Container(width: 80)
                    ],
                  );
                }
                return Row(
                  children: [
                    smallAreaButton(areaList[index]),
                    const SizedBox(width: 12),
                    smallAreaButton(areaList[index + 1]),
                    const SizedBox(width: 12),
                    smallAreaButton(areaList[index + 2]),
                    const SizedBox(width: 12),
                    smallAreaButton(areaList[index + 3])
                  ],
                );
              } else {
                return const SizedBox(height: 7);
              }
            },
          ),
        )
      ],
    );
  }

  Widget smallAreaButton(LocationList location) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: ShapeDecoration(
                  color: ColorStyles.gray,
                  shape: const OvalBorder(),
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/${location.areaNum}.jpg'),
                      fit: BoxFit.cover)),
            ),
            context.read<GuidePageProvider>().selectArea == location
                ? Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: ColorStyles.red.withOpacity(0.8),
                      shape: const OvalBorder(),
                    ),
                    child: const Icon(Icons.where_to_vote_rounded,
                        color: ColorStyles.ash, size: 30),
                  )
                : Container(
                    width: 80,
                    height: 80,
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(),
                    ),
                    child: TextButton(
                        style: ButtonStyles.transparenBtuttonStyle,
                        onPressed: () {
                          context.read<GuidePageProvider>().setArea(location);
                          loc = location;
                        },
                        child: Container()),
                  )
          ],
        ),
        const SizedBox(height: 12),
        Text(
          location.smallArea,
          style: const TextStyle(
            color: ColorStyles.black,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget checkButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        loc = context.read<GuidePageProvider>().selectArea;
        context.read<GuidePageProvider>().setRestaurants([]);
        Navigator.pop(context, true);
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        height: 66,
        color: ColorStyles.red,
        child: const Text(
          '확 인',
          style: TextStyle(
              color: ColorStyles.ash,
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
