import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/class/restaurant_review_class.dart';

class MyPageProvider extends ChangeNotifier {
  List<dynamic> myPageReviews = [];
  List myPageMisikLog = [];
  bool getMyReview = false;
  bool getMyMisiklog = false;

  setMyReivew(List<RestaurantReview> reviews) {
    myPageReviews = reviews;
    notifyListeners();
  }

  setMisiklist(List<Misiklist> datas) {
    myPageMisikLog = datas;
    notifyListeners();
  }
}
