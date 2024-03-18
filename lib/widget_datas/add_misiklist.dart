import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/misiklist_add_page/misiklist_add_button.dart';
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
                itemCount: context.watch<UserDataProvider>().myMisiklist.length,
                itemBuilder: (context, index) {
                  List<Misiklist> misiklists =
                      context.watch<UserDataProvider>().myMisiklist.toList();
                  if ((misiklists.length ~/ 3 == index ~/ 3) && true) {
                    if ((misiklists.length % 3 == 0)) {
                      return Row(
                        children: [
                          const Spacer(),
                          MisiklistAddButton(misiklist: misiklists[index + 1]),
                          const Spacer(),
                          MisiklistAddButton(misiklist: misiklists[index + 2]),
                          const Spacer(),
                          MisiklistAddButton(misiklist: misiklists[index + 3]),
                          const Spacer(),
                        ],
                      );
                    } else if (index % 3 == 1) {
                      return Container();
                    } else {
                      return Container(height: 10);
                    }
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
