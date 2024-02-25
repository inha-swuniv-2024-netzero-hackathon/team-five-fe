import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class MisiklistBottomSheet extends StatefulWidget {
  const MisiklistBottomSheet({super.key});

  @override
  State<MisiklistBottomSheet> createState() => _MisiklistBottomSheetState();
}

class _MisiklistBottomSheetState extends State<MisiklistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final misiklistProvider = context.watch<MisiklistProvider>();

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
                  fontWeight: FontWeight.w600),
            ),
          ),
          sortingButton(context, SortState.sortRecent, onPressed: () {
            misiklistProvider.sortByRecent();
          }),
          sortingButton(context, SortState.sortThumb, onPressed: () {
            misiklistProvider.sortByThumb();
          })
        ],
      ),
    );
  }

  Widget sortingButton(BuildContext context, SortState state,
      {required VoidCallback? onPressed}) {
    final misiklistProvider = context.watch<MisiklistProvider>();
    return GestureDetector(
      onTap: () {
        misiklistProvider.changeSortingStandard(state);
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
                      color: (misiklistProvider.sorting == state)
                          ? ColorStyles.red
                          : ColorStyles.gray,
                      width: 2),
                  borderRadius: BorderRadius.circular(90)),
              child: (misiklistProvider.sorting == state)
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
