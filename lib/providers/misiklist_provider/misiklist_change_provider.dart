import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';

class MisiklistChangeProvider extends ChangeNotifier {
  late MisikListDetail copiedList;
  List<String> selectedList = [];
  File? image;

  copyList(MisikListDetail data) {
    copiedList = MisikListDetail.copy(data);
    notifyListeners();
  }

  removeall() {
    selectedList.clear();
    notifyListeners();
  }

  selectRestaurant(MisiklistRestaurant data) {
    if (selectedList.contains(data.uuid)) {
      selectedList.remove(data.uuid);
    } else {
      selectedList.add(data.uuid);
    }
    notifyListeners();
  }

  changePrivate() {
    copiedList.isPrivate = !copiedList.isPrivate;
    notifyListeners();
  }

  reorder(int oldIndex, int newIndex) {
    final item = copiedList.restaurantList.removeAt(oldIndex);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    } else if (newIndex < 0) {
      newIndex = 0;
    }

    copiedList.restaurantList.insert(newIndex, item);
    notifyListeners();
  }

  changeimage(File data) {
    image = data;
    notifyListeners();
  }
}
