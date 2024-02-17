import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_misiklog_class.dart';
import 'package:proto_just_design/class/misiklog_class.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class MisiklistProvider extends ChangeNotifier {
  List<Misiklog> misiklogs = [];
  List<String> favMisiklogList = [];
  String detailSorting = '추천순';
  Icon detailIcon = const Icon(
    Icons.thumb_up,
    color: ColorStyles.red,
    size: 20,
  );
  MisiklogDetail? misiklogdata;

  changeData(List<Misiklog> misiklistList) {
    misiklogs = misiklistList;
    notifyListeners();
  }

  addFavMisiklog(String uuid) {
    if (favMisiklogList.contains(uuid)) {
    } else {
      favMisiklogList.add(uuid);
    }

    notifyListeners();
  }

  removeFavMisiklog(String uuid) {
    if (favMisiklogList.contains(uuid)) {
      favMisiklogList.remove(uuid);
    }
    notifyListeners();
  }

  clearFavMisiklog() {
    favMisiklogList.clear();
    notifyListeners();
  }
}
