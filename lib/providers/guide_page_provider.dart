import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/functions/default_function.dart';

class GuidePageProvider extends ChangeNotifier {
  List<Restaurant> guidePageRestaurants = [];
  LocationList selectArea = LocationList.area1;
  Set<String> favRestaurantList = {};
  RestaurantSortStandard sorting = RestaurantSortStandard.sortDefault;
  String? nextUrl;
  Set<Marker> marker = {};
  List<Restaurant> restaurantList = [];
  changeData(List<Restaurant> restaurants) {
    guidePageRestaurants = restaurants;
    notifyListeners();
  }

  changeArea(LocationList data) {
    selectArea = data;
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

  addMarker(Marker data) {
    marker.add(data);
    notifyListeners();
  }

  sortByRating() {
    if (restaurantList.isNotEmpty) {
      restaurantList.sort((a, b) =>
          b.rating.compareTo(a.rating));
    }
    notifyListeners();
  }

  sortByDistance(double lat, double lon) {
    if (restaurantList.isNotEmpty) {
      restaurantList.sort((a, b) =>
          checkDistance(lat, lon, a.latitude, a.latitude)
              .compareTo(checkDistance(lat, lon, b.latitude, b.longitude)));
    }
    notifyListeners();
  }

  void sortByReviews() {
    restaurantList.sort((a, b) =>
        b.ratingCount.compareTo(a.ratingCount));
  }
}
