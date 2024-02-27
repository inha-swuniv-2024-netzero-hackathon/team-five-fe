import 'package:flutter/material.dart';

class ReviewPageData extends ChangeNotifier {
  late List<dynamic> reviewPageData;

  changeWidget(List<dynamic> reviews) {
    reviewPageData = reviews;
    notifyListeners();
  }
}
