import 'package:flutter/material.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/datas/default_sorting.dart';

class GuidePageProvider extends ChangeNotifier {
  List<Restaurant> guidePageRestaurants = [];
  LocationList focusArea = LocationList.area1;
  List<String> favRestaurantList = [];
  RestaurantSortStandard sorting = RestaurantSortStandard.sortDefault;
  changeData(List<Restaurant> restaurants) {
    guidePageRestaurants = restaurants;
    notifyListeners();
  }

  changeArea(LocationList area) {
    focusArea = area;
    notifyListeners();
  }

  addFavRestaurant(String uuid) {
    if (favRestaurantList.contains(uuid)) {
    } else {
      favRestaurantList.add(uuid);
    }
    notifyListeners();
  }

  removeFavRestaurant(String uuid) {
    if (favRestaurantList.contains(uuid)) {
      favRestaurantList.remove(uuid);
    }
    notifyListeners();
  }

  clearFavRestaurant() {
    favRestaurantList.clear();
    notifyListeners();
  }

  changeSortingStandard(RestaurantSortStandard standard) {
    sorting = standard;
    notifyListeners();
  }
}
