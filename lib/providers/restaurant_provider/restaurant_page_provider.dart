import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/class/detail_restaurant_class.dart';
import 'package:proto_just_design/class/restaurant_review_class.dart';

enum RestaurantPageDetailState { menu, review, photo, map }

class RestaurantPageProvider extends ChangeNotifier {
  late RestaurantDetail restaurantData;
  Enum state = RestaurantPageDetailState.menu;
  Set<Marker> markers = <Marker>{};
  List<RestaurantReview> reviews = [];
  List<String> restaurantPhotos = [];
  String opening = '';

  setRestaurant(RestaurantDetail data) {
    restaurantData = data;
    notifyListeners();
  }

  changeState(RestaurantPageDetailState data) {
    state = data;
    notifyListeners();
  }

  addMarker(Marker data) {
    markers.add(data);
    notifyListeners();
  }

  cleardata() {
    markers.clear();
    reviews.clear;
    restaurantPhotos.clear();
    state = RestaurantPageDetailState.menu;
    notifyListeners();
  }

  addReview(RestaurantReview data) {
    reviews.add(data);
    notifyListeners();
  }

  addPhoto(String data) {
    restaurantPhotos.add(data);
    notifyListeners();
  }

  setOpening(String data) {
    opening = data;
    notifyListeners();
  }
}
