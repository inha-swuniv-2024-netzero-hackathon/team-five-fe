import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

class MisiklistDetailProvider with ChangeNotifier {
  String sorting = '추천순';
  Icon icon = const Icon(
    Icons.thumb_up,
    color: ColorStyles.red,
    size: 20,
  );
  MisikListDetail? misiklist;
  List<MisiklistRestaurant> restaurantList = [];
  bool isDetailText = false;
  // bool? isGood;
  setMisikList(data) {
    misiklist = data;
    notifyListeners();
  }

  setDetailMisiklistSort(String name, Icon iconData) {
    sorting = name;
    icon = iconData;
    notifyListeners();
  }

  setdetailList(List<MisiklistRestaurant> data) {
    restaurantList = data;
    notifyListeners();
  }

  sortDetailRating() {
    restaurantList.sort((pre, post) => pre.rating.compareTo(post.rating));
    notifyListeners();
  }

  sortDetailDistance(num lat, num lon) {
    restaurantList.sort(
      (pre, post) => (pow((pre.latitude! - lat), 2) +
              pow(pre.longitude! - lon, 2))
          .compareTo(
              pow((post.latitude! - lat), 2) + pow(post.longitude! - lon, 2)),
    );
  }

  // setLike() {
  //   if (isGood == true) {
  //     isGood = null;
  //   } else {
  //     isGood = true;
  //   }
  //   notifyListeners();
  // }

  // setDislike() {
  //   if (isGood == false) {
  //     isGood = null;
  //   } else {
  //     isGood = false;
  //   }
  // }

  setDetailText() {
    isDetailText = !isDetailText;
    notifyListeners();
  }
}
