import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/detail_misiklist_class.dart';
import 'package:proto_just_design/class/misiklist_restaurant_class.dart';
import 'package:proto_just_design/datas/default_sorting.dart';

class MisiklistDetailProvider with ChangeNotifier {
  SortState sort = SortState.sortRating;
  MisikListDetail? misiklist;
  List<MisiklistRestaurant> restaurantList = [];
  bool isDetailText = false;
  // bool? isGood;
  setMisikList(data) {
    misiklist = data;
    notifyListeners();
  }

  setSort(SortState data) {
    sort = data;
    notifyListeners();
  }

  setdetailList(List<MisiklistRestaurant> data) {
    restaurantList = data;
    notifyListeners();
  }

  sortByRating() {
    restaurantList.sort((pre, post) => pre.rating.compareTo(post.rating));
    notifyListeners();
  }

  sortByDistance(num lat, num lon) {
    restaurantList.sort(
      (pre, post) => (pow((pre.latitude! - lat), 2) +
              pow(pre.longitude! - lon, 2))
          .compareTo(
              pow((post.latitude! - lat), 2) + pow(post.longitude! - lon, 2)),
    );
  }

  sortByThumb() {
    restaurantList.sort((a, b) => a.rating.compareTo(b.rating));
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
