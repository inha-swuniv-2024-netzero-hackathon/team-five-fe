import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';
import 'package:proto_just_design/providers/misiklist_provider/detail_misiklist_provider.dart';
import 'package:proto_just_design/providers/misiklist_provider/misiklist_change_provider.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_change_page/misiklist_change_page_restaurant_button.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_change_page/misiklist_change_remove_dialog.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MisiklistChangePage extends StatefulWidget {
  const MisiklistChangePage({super.key});

  @override
  State<MisiklistChangePage> createState() => _MisiklistChangePageState();
}

class _MisiklistChangePageState extends State<MisiklistChangePage> {
  @override
  Widget build(BuildContext context) {
    MisiklistChangeProvider changeProvider =
        context.watch<MisiklistChangeProvider>();
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<MisiklistChangeProvider>().removeall();
      },
      child: Scaffold(
        body: context.watch<MisiklistDetailProvider>().misiklist == null
            ? Container()
            : SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    pageHeader(context),
                    const Gap(25),
                    pageBody(context, changeProvider),
                  ],
                ),
              ),
      ),
    );
  }

  Widget pageHeader(BuildContext context) {
    MisikListDetail? misiklist =
        context.watch<MisiklistDetailProvider>().misiklist;
    return (misiklist != null)
        ? Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 300,
                    padding: const EdgeInsets.only(
                        left: 14, right: 22, top: 11, bottom: 11),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(misiklist.thumbnail),
                          fit: BoxFit.cover,
                        )),
                    child: Column(
                      children: [
                        const Gap(30),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: Colors.black.withOpacity(0.5)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                misiklist.thumbnail),
                                            fit: BoxFit.cover),
                                        shape: const OvalBorder(),
                                      ),
                                    ),
                                    const Gap(5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ('${misiklist.username}'),
                                          style: const TextStyle(
                                            color: ColorStyles.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const Gap(5),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 36,
                                          height: 15,
                                          decoration: ShapeDecoration(
                                            color: ColorStyles.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                            ),
                                          ),
                                          child: const Text(
                                            '등급 1',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  print('photo');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.5)),
                                  child: const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: ColorStyles.white,
                                      size: 30),
                                ),
                              ),
                            ]),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            width: 270,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      misiklist.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: ColorStyles.white,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(10),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 62,
                                      height: 26,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          color: Colors.black.withOpacity(0.5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.star,
                                              color: ColorStyles.yellow,
                                              size: 20),
                                          const Gap(1),
                                          Text(
                                            (300 / 100).toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: ColorStyles.yellow),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'text',
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: ColorStyles.white,
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        : Container();
  }

  Widget pageBody(
      BuildContext context, MisiklistChangeProvider changeProvider) {
    return Container(
      height: MediaQuery.sizeOf(context).height - 325,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (context
                          .read<MisiklistChangeProvider>()
                          .selectedList
                          .length !=
                      context
                          .read<MisiklistDetailProvider>()
                          .restaurantList
                          .length) {
                    for (MisiklistRestaurant restaurant in context
                        .read<MisiklistChangeProvider>()
                        .copiedList
                        .restaurantList) {
                      if (!context
                          .read<MisiklistChangeProvider>()
                          .selectedList
                          .contains(restaurant.uuid)) {
                        context
                            .read<MisiklistChangeProvider>()
                            .selectRestaurant(restaurant);
                      }
                    }
                  } else {
                    context.read<MisiklistChangeProvider>().removeall();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 3,
                            offset: Offset(0, 0.50))
                      ],
                      borderRadius: BorderRadius.circular(90),
                      color: (context
                              .watch<MisiklistChangeProvider>()
                              .selectedList
                              .isEmpty)
                          ? ColorStyles.white
                          : ColorStyles.red),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (changeProvider.selectedList.isEmpty)
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorStyles.silver),
                                  borderRadius: BorderRadius.circular(90)),
                            )
                          : Container(
                              padding: const EdgeInsets.all(2),
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorStyles.white),
                                  borderRadius: BorderRadius.circular(90)),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorStyles.white,
                                    borderRadius: BorderRadius.circular(90)),
                              ),
                            ),
                      const Gap(3),
                      ((changeProvider.selectedList.isEmpty) ||
                              changeProvider.selectedList.length ==
                                  context
                                      .watch<MisiklistDetailProvider>()
                                      .restaurantList
                                      .length)
                          ? Text(
                              '전체 선택',
                              style: TextStyle(
                                  color: (changeProvider.selectedList.isEmpty)
                                      ? ColorStyles.black
                                      : ColorStyles.white),
                            )
                          : Text(
                              '${changeProvider.selectedList.length}개 선택',
                              style: const TextStyle(color: ColorStyles.white),
                            )
                    ],
                  ),
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  if (context
                      .read<MisiklistChangeProvider>()
                      .selectedList
                      .isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const MisiklistRemoveDialog());
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 3,
                            offset: Offset(0, 0.50))
                      ],
                      borderRadius: BorderRadius.circular(90),
                      color: ColorStyles.white),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_outline,
                          color: ColorStyles.red, size: 20),
                      Text('삭제')
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<MisiklistChangeProvider>().changePrivate();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  decoration: BoxDecoration(
                      color: context
                              .watch<MisiklistChangeProvider>()
                              .copiedList
                              .isPrivate
                          ? ColorStyles.red.withOpacity(0.6)
                          : ColorStyles.gray,
                      borderRadius: BorderRadius.circular(90)),
                  child: context
                          .watch<MisiklistChangeProvider>()
                          .copiedList
                          .isPrivate
                      ? Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 16,
                              height: 16,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: OvalBorder(),
                                shadows: Boxshadows.defaultShadow,
                              ),
                              child: const Icon(Icons.lock_person,
                                  color: ColorStyles.red, size: 12),
                            ),
                            const Gap(3),
                            const Text(
                              '비공개',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            const Text(
                              '공개',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(3),
                            Container(
                              alignment: Alignment.center,
                              width: 16,
                              height: 16,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: OvalBorder(),
                                shadows: Boxshadows.defaultShadow,
                              ),
                              child: const Icon(Icons.lock_open,
                                  color: ColorStyles.gray, size: 12),
                            )
                          ],
                        ),
                ),
              )
            ],
          ),
          const Gap(10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 30,
            height: MediaQuery.sizeOf(context).height - 362,
            child: ReorderableListView.builder(
              itemCount: context
                  .watch<MisiklistChangeProvider>()
                  .copiedList
                  .restaurantList
                  .length,
              itemBuilder: (context, index) {
                return MisiklistChangeRestaurantButton(
                    key: Key('misiklistrestaurant$index'),
                    restaurant: context
                        .watch<MisiklistChangeProvider>()
                        .copiedList
                        .restaurantList[index]);
              },
              onReorder: (oldIndex, newIndex) {
                context
                    .read<MisiklistChangeProvider>()
                    .reorder(oldIndex, newIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}
