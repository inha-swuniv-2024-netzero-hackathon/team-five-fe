import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_page_bottomsheet.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_state/default_misiklist.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_state/my_misiklist.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:provider/provider.dart';

class MisiklistPage extends StatefulWidget {
  const MisiklistPage({super.key});

  @override
  State<MisiklistPage> createState() => _MisiklistPageState();
}

class _MisiklistPageState extends State<MisiklistPage> {
  String screen = 'default';

  @override
  Widget build(BuildContext context) {
    MisiklistProvider misiklistProvider = context.watch<MisiklistProvider>();
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            header(context, misiklistProvider),
            screen == 'default'
                ? const DefaultMisiklist()
                : screen == 'my'
                    ? const MyMisiklist()
                    : Container()
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context, MisiklistProvider misiklistProvider) {
    String fav = 'fav';
    String my = 'my';
    String de = 'default';
    return Column(
      children: [
        const DefaultSearchMap(),
        Row(
          children: [
            const SizedBox(width: 25),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => const MisiklistBottomSheet());
                },
                child: Row(
                  children: [
                    misiklistProvider.sorting.icon,
                    const Gap(3),
                    Text(
                      misiklistProvider.sorting.name,
                      style: const TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more,
                      color: ColorStyles.gray,
                    )
                  ],
                )),
            const SizedBox(width: 30),
            GestureDetector(
                onTap: () async {
                  if (await checkLogin(context)) {
                    if (screen == my) {
                      screen = de;
                    } else {
                      screen = my;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: screen == my
                      ? ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                              side: const BorderSide(
                                  color: ColorStyles.red, width: 1)))
                      : null,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: ColorStyles.red,
                        size: 20,
                      ),
                      Text('나의 리스트')
                    ],
                  ),
                )),
            const SizedBox(width: 30),
            GestureDetector(
                onTap: () async {
                  if (await checkLogin(context)) {
                    if (screen == fav) {
                      screen = de;
                    } else {
                      screen = fav;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: screen == fav
                      ? ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                              side: const BorderSide(
                                  color: ColorStyles.red, width: 1)))
                      : null,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.bookmarks_rounded,
                        color: ColorStyles.red,
                        size: 20,
                      ),
                      Text(
                        '찜 리스트',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ))
          ],
        ),
        const Gap(10)
      ],
    );
  }
}
