import 'package:flutter/material.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class ReviewRestaurantSelectPage extends StatefulWidget {
  const ReviewRestaurantSelectPage({super.key});

  @override
  State<ReviewRestaurantSelectPage> createState() =>
      _ReviewRestaurantSelectPageState();
}

class _ReviewRestaurantSelectPageState
    extends State<ReviewRestaurantSelectPage> {
  int selected = 0;
  List<Restaurant> nearRestaurant = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            reviewRestaurantSelectPageAppbar(context),
            reviewRestaurantSelectPageBody(context)
          ],
        ),
      ),
    );
  }

  Widget reviewWritePageAppbar(BuildContext context, String pageName) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            TextButton(
                onPressed: () {},
                child: const Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: ColorStyles.red,
                      size: 35,
                    ),
                    Text(
                      '       뒤로가기',
                      style: TextStyle(
                        color: ColorStyles.red,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  pageName,
                  style: const TextStyle(
                    color: ColorStyles.red,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.help_outline_outlined,
                  size: 20,
                  color: ColorStyles.red,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget reviewRestaurantSelectPageAppbar(BuildContext context) {
    return Column(
      children: [
        reviewWritePageAppbar(context, '식당 선택'),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      selected = 0;
                      setState(() {});
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: selected == 0
                                  ? ColorStyles.red
                                  : ColorStyles.black,
                              size: 24),
                          Text('주변 식당',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: selected == 0
                                      ? ColorStyles.red
                                      : ColorStyles.black))
                        ])),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: selected == 0 ? Color(0x4CF25757) : Color(0x19000000),
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      selected = 1;
                      setState(() {});
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.schedule,
                              color: selected == 1
                                  ? ColorStyles.red
                                  : ColorStyles.black,
                              size: 24),
                          Text('최근 식당',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: selected == 1
                                      ? ColorStyles.red
                                      : ColorStyles.black))
                        ])),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: selected == 1 ? Color(0x4CF25757) : Color(0x19000000),
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      selected = 2;
                      setState(() {});
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmarks_outlined,
                              color: selected == 2
                                  ? ColorStyles.red
                                  : ColorStyles.black,
                              size: 24),
                          Text('찜목록',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: selected == 2
                                      ? ColorStyles.red
                                      : ColorStyles.black))
                        ])),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: selected == 2 ? Color(0x4CF25757) : Color(0x19000000),
                )
              ],
            )),
          ],
        )
      ],
    );
  }

  Widget reviewRestaurantSelectPageBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          child: Row(
            children: [
              const SizedBox(width: 25),
              TextButton(
                  onPressed: () {
                    print('좌표');
                  },
                  child: Row(
                    children: [Icon(Icons.my_location), Text('장소')],
                  )),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    print('???');
                  },
                  child: Icon(Icons.tune)),
              const SizedBox(width: 25)
            ],
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 500,
          child: ListView.builder(
            itemCount: nearRestaurant.length + 2,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                height: 125,
                child: Row(
                  children: [
                    Container(
                      width: 108,
                      child: Stack(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: ShapeDecoration(
                                    color: ColorStyles.red,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.70,
                                          color: Color(0xFF8E8E93)),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  height: 77,
                                  width: 77,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                print(index);
                              },
                              child: Container()),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}