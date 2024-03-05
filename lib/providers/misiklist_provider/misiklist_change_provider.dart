import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';

class MisiklistChangeProvider extends ChangeNotifier {
  late MisikListDetail copiedList;
  List<MisiklistRestaurant> selectedList = [];

  copyList(MisikListDetail data) {
    copiedList = data;
    notifyListeners();
  }

  addAll(List<MisiklistRestaurant> list) {
    selectedList = list;
    notifyListeners();
  }

  removeall() {
    selectedList.clear();
    notifyListeners();
  }

  selectRestaurant(MisiklistRestaurant data) {
    if (selectedList.contains(data)) {
      selectedList.remove(data);
    } else {
      selectedList.add(data);
    }
    notifyListeners();
  }
}
