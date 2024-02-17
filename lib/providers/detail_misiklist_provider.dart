import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class MisiklistDetailProvider with ChangeNotifier {
  String detailSorting = '추천순';
  Icon detailIcon = const Icon(
    Icons.thumb_up,
    color: ColorStyles.red,
    size: 20,
  );
  List<Restaurant> detailList = [];
  bool? isGood;
  bool isDetailText = false;
  setDetailMisiklistSort(String name, Icon icon) {
    detailSorting = name;
    detailIcon = icon;
    notifyListeners();
  }

  setdetailList(List<Restaurant> list) {
    detailList = list;
    notifyListeners();
  }

  sortDetailRating() {
    detailList.sort((a, b) => a.rating.compareTo(b.rating));
    notifyListeners();
  }

  sortDetailDistance(num lat, num lon) {
    detailList.sort(
      (a, b) => (pow((a.latitude - lat), 2) + pow(a.longitude - lon, 2))
          .compareTo(pow((b.latitude - lat), 2) + pow(b.longitude - lon, 2)),
    );
  }

  setLike() {
    if (isGood == true) {
      isGood = null;
    } else {
      isGood = true;
    }
    notifyListeners();
  }

  setDislike() {
    if (isGood == false) {
      isGood = null;
    } else {
      isGood = false;
    }
  }

  setDetailText() {
    isDetailText = !isDetailText;
    notifyListeners();
  }
}
