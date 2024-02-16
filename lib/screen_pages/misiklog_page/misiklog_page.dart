import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/class/misiklog_class.dart';
import 'package:proto_just_design/providers/custom_provider.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:proto_just_design/main.dart';
import 'package:provider/provider.dart';

class ScriptPage extends StatefulWidget {
  const ScriptPage({super.key});

  @override
  State<ScriptPage> createState() => _ScriptPageState();
}

class _ScriptPageState extends State<ScriptPage> {
  String? token;
  List<Misiklog> misiklogList = [];

  Future<void> getMisiklogList() async {
    final url = Uri.parse('${rootURL}v1/misiklogu/');
    final response = (token == null)
        ? await http.get(url)
        : await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      final responseMisiklogList = responseData;
      for (var misiklogData in responseMisiklogList) {
        Misiklog misiklog = Misiklog(misiklogData);
        misiklogList.add(misiklog);
        if (misiklog.isBookmarked) {
          if (mounted) {
            context.read<MisiklogPageData>().addFavMisiklog(misiklog.uuid);
          }
        }
        if (mounted) {
          context.read<MisiklogPageData>().changeData(misiklogList);
        }
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      print(response.statusCode);
    }
  }

  void setToken() {
    final getToken = context.read<UserData>().userToken;
    if (getToken != null) {
      token = getToken;
    }
  }

  @override
  void initState() {
    super.initState();
    setToken();

    if (context.read<MisiklogPageData>().misiklogPageList.isEmpty) {
      getMisiklogList();
    } else {
      misiklogList = context.read<MisiklogPageData>().misiklogPageList;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            scriptPageHeader(context),
            scriptPageBody(context)
          ],
        ),
      ),
    );
  }

  Widget scriptPageHeader(BuildContext context) {
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
                    Icon(Icons.favorite),
                    Text('정렬'),
                    Icon(Icons.expand_more)
                  ],
                )),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () {
                  print('나의로그');
                },
                child: const Row(
                  children: [Icon(Icons.lock), Text('나의 로그')],
                )),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () {
                  print('찜로그');
                },
                child: const Row(
                  children: [Icon(Icons.bookmarks_rounded), Text('찜 로그')],
                ))
          ],
        )
      ],
    );
  }

  Widget scriptPageBody(BuildContext context) {
    int len = misiklogList.length;
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
                  misiklogButton(context, misiklogList[index]),
                  const SizedBox(width: 20),
                  Container(width: 171)
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                misiklogButton(context, misiklogList[index]),
                const SizedBox(width: 20),
                misiklogButton(context, misiklogList[index + 1])
              ],
            );
          }
          return Container(height: 20);
        },
      ),
    );
  }
}
