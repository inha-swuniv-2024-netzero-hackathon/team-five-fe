import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/guide_page/misiklist_button.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:proto_just_design/main.dart';
import 'package:provider/provider.dart';

class MisiklistPage extends StatefulWidget {
  const MisiklistPage({super.key});

  @override
  State<MisiklistPage> createState() => _MisiklistPageState();
}

class _MisiklistPageState extends State<MisiklistPage> {
  Future<void> getMisiklists() async {
    List<Misiklist> misiklists = [];
    String? token = context.read<UserData>().token;
    final url = Uri.parse('${rootURL}v1/misiklist/');

    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> responseMisiklists = responseData['results'];
      for (var misiklistData in responseMisiklists) {
        Misiklist misiklist = Misiklist(misiklistData);
        misiklists.add(misiklist);
        if (misiklist.isBookmarked) {
          if (mounted) {
            context.read<MisiklistProvider>().addFavMisiklist(misiklist.uuid);
          }
        }
        if (mounted) {
          context.read<MisiklistProvider>().changeData(misiklists);
        }
      }
      if (mounted) {
        setState(() {});
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();

    if (context.read<MisiklistProvider>().misiklists.isEmpty) {
      getMisiklists();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            header(context),
            body(context)
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Column(
      children: [
        const DefaultSearchMap(),
        Row(
          children: [
            const SizedBox(width: 25),
            TextButton(
                onPressed: () {
                  print('정렬');
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: ColorStyles.red,
                      size: 20,
                    ),
                    Gap(3),
                    Text(
                      '추천순',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: ColorStyles.gray,
                    )
                  ],
                )),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () {
                  print('나의리스트');
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: ColorStyles.red,
                      size: 20,
                    ),
                    Text('나의 리스트')
                  ],
                )),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () {
                  print('찜리스트');
                },
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
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ))
          ],
        )
      ],
    );
  }

  Widget body(BuildContext context) {
    List<Misiklist> misiklists = context.watch<MisiklistProvider>().misiklists;
    int len = misiklists.length;
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 670,
      child: ListView.builder(
        itemCount: len + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == len) {
            return const SizedBox(height: 100);
          }
          if ((index % 2 == 0)) {
            if ((len % 2 == 1) && (index + 2 > len)) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MisiklistButton(misiklist: misiklists[index]),
                  const SizedBox(width: 20),
                  Container(width: 171)
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MisiklistButton(misiklist: misiklists[index]),
                const SizedBox(width: 20),
                MisiklistButton(misiklist: misiklists[index + 1])
              ],
            );
          }
          return Container(height: 20);
        },
      ),
    );
  }
}
