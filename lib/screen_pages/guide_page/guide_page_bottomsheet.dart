import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/providers/guide_provider/guide_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class GuidePageBottomSheet extends StatefulWidget {
  const GuidePageBottomSheet({super.key});

  @override
  State<GuidePageBottomSheet> createState() => _GuidePageBottomSheetState();
}

class _GuidePageBottomSheetState extends State<GuidePageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final guidePageProvider = context.watch<GuidePageProvider>();
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
          sortingButton(context, SortState.sortThumb, onPressed: () {
            guidePageProvider.sortByReviews();
          }),
          sortingButton(context, SortState.sortRating, onPressed: () {
            guidePageProvider.sortByRating();
          }),
          sortingButton(context, SortState.sortDistance, onPressed: () {
            guidePageProvider.sortByDistance(context.read<UserDataProvider>().latitude,
                context.read<UserDataProvider>().longitude);
          })
        ],
      ),
    );
  }

  Widget sortingButton(BuildContext context, SortState state,
      {required VoidCallback? onPressed}) {
    final guidePageProvider = context.watch<GuidePageProvider>();
    return GestureDetector(
      onTap: () {
        guidePageProvider.changeSortingStandard(state);
        onPressed?.call();
        Navigator.pop(context);
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
                      color: (guidePageProvider.sorting == state)
                          ? ColorStyles.red
                          : ColorStyles.gray,
                      width: 2),
                  borderRadius: BorderRadius.circular(90)),
              child: (guidePageProvider.sorting == state)
                  ? Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorStyles.red))
                  : null,
            ),
            const Gap(10),
            state.icon,
            Text(
              state.name,
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
