import 'package:flutter/material.dart';

class ReviewRestaurantSelectProvider extends ChangeNotifier {
  String selectRestaurant = '';
  changeRestaurant(String uuid) {
    selectRestaurant = uuid;
  }
}
