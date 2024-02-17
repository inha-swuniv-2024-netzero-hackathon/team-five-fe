import 'package:flutter/material.dart';

class MyPageProvider extends ChangeNotifier {
  List<dynamic> myPageReviews = [];
  List myPageMisikLog = [];
  bool getMyReview = false;
  bool getMyMisiklog = false;

  changeMyReviewData(List<dynamic> reviews) {
    myPageReviews = reviews;
    notifyListeners();
  }

  changeMyMisiklogData(List misiklog) {
    myPageMisikLog = misiklog;
    notifyListeners();
  }
}
