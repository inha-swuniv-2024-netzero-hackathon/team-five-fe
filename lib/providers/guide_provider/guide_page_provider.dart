import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/functions/default_function.dart';

class GuidePageProvider extends ChangeNotifier {
  LocationList selectArea = LocationList.area1;
  String bigArea = LocationList.area1.bigArea;

  SortState sorting = SortState.sortRating;
  List<LocationList> areaList = [];

  bool withMap = false;
  Set<Marker> markers = {};

  List<Restaurant> guidePageRestaurants = [];
  String? nextUrl;
  bool searchOpen = false;

  setRestaurants(List<Restaurant> restaurants) {
    guidePageRestaurants = restaurants;
    notifyListeners();
  }

  setArea(LocationList data) {
    selectArea = data;
    notifyListeners();
  }

  changeSortingStandard(SortState state) {
    sorting = state;
    notifyListeners();
  }

  addMarker(Marker data) {
    markers.add(data);
    notifyListeners();
  }

  sortByRating() {
    if (guidePageRestaurants.isNotEmpty) {
      guidePageRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
    }
    notifyListeners();
  }

  sortByDistance(double lat, double lon) {
    if (guidePageRestaurants.isNotEmpty) {
      guidePageRestaurants.sort((a, b) =>
          checkDistance(lat, lon, a.latitude, a.latitude)
              .compareTo(checkDistance(lat, lon, b.latitude, b.longitude)));
    }
    notifyListeners();
  }

  sortByReviews() {
    guidePageRestaurants.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    notifyListeners();
  }

  setBigArea(String data) {
    bigArea = data;
    notifyListeners();
  }

  setSearch() {
    searchOpen = !searchOpen;
    notifyListeners();
  }

  setWithmap() {
    withMap = !withMap;
    notifyListeners();
  }

  setNextUrl(String? data) {
    nextUrl = data;
  }
}
