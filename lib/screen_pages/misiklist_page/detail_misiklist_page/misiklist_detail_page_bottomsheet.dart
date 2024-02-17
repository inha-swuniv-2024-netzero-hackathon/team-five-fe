import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/providers/detail_misiklist_provider.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Text(
              '정렬기준',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorStyles.black,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          sortingButton(
              context,
              const Icon(
                Icons.thumb_up,
                color: ColorStyles.red,
                size: 20,
              ),
              '추천순'),
          sortingButton(
              context,
              const Icon(
                Icons.star_rounded,
                color: ColorStyles.yellow,
                size: 30,
              ),
              '별점순'),
          sortingButton(
              context,
              const Icon(
                Icons.pin_drop_rounded,
                color: ColorStyles.red,
                size: 25,
              ),
              '거리순')
        ],
      ),
    );
  }

  Widget sortingButton(BuildContext context, Icon icon, String name) {
    return GestureDetector(
      onTap: () {
        context
            .read<MisiklistDetailProvider>()
            .setDetailMisiklistSort(name, icon);
        Navigator.pop(context);
        context
            .read<MisiklistDetailProvider>()
            .setdetailList(context.read<MisiklistDetailProvider>().detailList);
        if (name == '거리순') {
          context.read<MisiklistDetailProvider>().sortDetailDistance(
              context.read<UserData>().latitude,
              context.read<UserData>().longitude);
        } else if (name == '추천순') {
          context.read<MisiklistDetailProvider>().sortDetailRating();
        }
      },
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        child: Row(
          children: [
            Container(
              height: 16,
              width: 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          (context.watch<MisiklistProvider>().detailSorting ==
                                  name)
                              ? ColorStyles.red
                              : ColorStyles.gray,
                      width: 2),
                  borderRadius: BorderRadius.circular(90)),
              child: (context.watch<MisiklistProvider>().detailSorting == name)
                  ? Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorStyles.red))
                  : null,
            ),
            const Gap(10),
            icon,
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorStyles.black,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
