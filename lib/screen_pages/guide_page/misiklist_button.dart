import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/functions/default_function.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/screen_pages/misiklist_page/detail_misiklist_page/misiklist_detail_page.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:provider/provider.dart';

class MisiklistButton extends StatefulWidget {
  final Misiklist misiklist;
  const MisiklistButton({super.key, required this.misiklist});

  @override
  State<MisiklistButton> createState() => _MisiklistButtonState();
}

class _MisiklistButtonState extends State<MisiklistButton> {
  @override
  Widget build(BuildContext context) {
    late Misiklist misiklist = widget.misiklist;
    return Container(
      width: 171,
      height: 241,
      decoration: const BoxDecoration(
          boxShadow: Boxshadows.defaultShadow,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 171,
              height: 131,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.grey,
                image: DecorationImage(
                    image: NetworkImage(misiklist.thumbnail), fit: BoxFit.fill),
              ),
              child: TextButton(
                  style: ButtonStyles.transparenBtuttonStyle,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MisiklistDetailPage(misiklist: misiklist),
                        ));
                  },
                  child: Container()),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 7),
            width: 171,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 9),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 29,
                        height: 29,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(misiklist.thumbnail),
                            fit: BoxFit.fill,
                          ),
                        )),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(misiklist.username),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(0, -6),
                      child: IconButton(
                          onPressed: () async {
                            if (await checkLogin(context)) {
                              if (mounted) {
                                if (mounted) {
                                  if (await setMisiklistBookmark(
                                          context, misiklist.uuid) !=
                                      200) {
                                    if (mounted) {
                                      changeMisiklistBookmark(
                                          context, misiklist.uuid);
                                    }
                                  }
                                }
                              }
                            }
                          },
                          icon: Icon(
                            Icons.bookmark,
                            color: context
                                    .watch<MisiklistProvider>()
                                    .favMisiklists
                                    .contains(misiklist.uuid)
                                ? ColorStyles.red
                                : Colors.grey,
                            size: 24,
                          )),
                    )
                  ],
                ),
                Text(misiklist.title, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 5),
                const Text('글이 올 자리',
                    style: TextStyle(fontSize: 13, color: Color(0xff8E8E93))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
