import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/model/global/misiklist.dart';
import 'package:proto_just_design/providers/misiklist_provider/misiklist_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_add_dialog.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_add_page/misiklist_add_button.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class AddMisiklistBottom extends StatefulWidget {
  const AddMisiklistBottom({super.key});

  @override
  State<AddMisiklistBottom> createState() => _AddMisiklistBottomState();
}

class _AddMisiklistBottomState extends State<AddMisiklistBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Gap(18),
                Text(
                  '리스트에 저장하기',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // itemCount:
                // context.watch<MisiklistProvider>().misiklists.length + 1,
                itemCount:
                    context.watch<UserDataProvider>().myMisiklist.length + 1,
                itemBuilder: (context, index) {
                  List<Misiklist> misiklists =
                      context.watch<UserDataProvider>().myMisiklist.toList();
                  // context.watch<MisiklistProvider>().misiklists;
                  if (index % 3 == 0) {
                    if (index > misiklists.length - 3) {
                      if (misiklists.length % 3 == 0) {
                        return const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(30),
                            NewMisiklistButton(),
                            Spacer(),
                            SizedBox(width: 82),
                            Spacer(),
                            SizedBox(width: 82),
                            Gap(30)
                          ],
                        );
                      } else if (misiklists.length % 3 == 1) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(30),
                            MisiklistAddButton(misiklist: misiklists[index]),
                            const Spacer(),
                            const NewMisiklistButton(),
                            const Spacer(),
                            const SizedBox(width: 82),
                            const Gap(30)
                          ],
                        );
                      } else if (misiklists.length % 3 == 2) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(30),
                            MisiklistAddButton(misiklist: misiklists[index]),
                            const Spacer(),
                            MisiklistAddButton(
                                misiklist: misiklists[index + 1]),
                            const Spacer(),
                            const NewMisiklistButton(),
                            const Gap(30)
                          ],
                        );
                      }
                    }
                    return Row(
                      children: [
                        const Gap(30),
                        MisiklistAddButton(misiklist: misiklists[index]),
                        const Spacer(),
                        MisiklistAddButton(misiklist: misiklists[index + 1]),
                        const Spacer(),
                        MisiklistAddButton(misiklist: misiklists[index + 2]),
                        const Gap(30)
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewMisiklistButton extends StatefulWidget {
  const NewMisiklistButton({super.key});

  @override
  State<NewMisiklistButton> createState() => NewMisiklistButtonState();
}

class NewMisiklistButtonState extends State<NewMisiklistButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context, builder: (context) => const AddMisikList());
      },
      child: DottedBorder(
        radius: const Radius.circular(15),
        color: ColorStyles.red,
        borderType: BorderType.RRect,
        child: const SizedBox(
          height: 82,
          width: 82,
          child: Icon(Icons.playlist_add, color: ColorStyles.red, size: 30),
        ),
      ),
    );
  }
}
