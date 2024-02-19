import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_class.dart';

class MisiklistProvider extends ChangeNotifier {
  List<Misiklist> misiklists = [];
  List<String> favMisiklists = [];

  MisikListDetail? misiklistdata;

  changeData(List<Misiklist> misiklistList) {
    misiklists = misiklistList;
    notifyListeners();
  }

  addFavMisiklist(String uuid) {
    if (favMisiklists.contains(uuid)) {
    } else {
      favMisiklists.add(uuid);
    }

    notifyListeners();
  }

  removeFavMisiklist(String uuid) {
    if (favMisiklists.contains(uuid)) {
      favMisiklists.remove(uuid);
    }
    notifyListeners();
  }

  clearFavMisiklist() {
    favMisiklists.clear();
    notifyListeners();
  }
}
