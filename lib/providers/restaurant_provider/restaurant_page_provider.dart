import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/model/misiklogu/detail_restaurant.dart';
import 'package:proto_just_design/model/global/restaurant_review.dart';

enum RestaurantPageDetailState { menu, review, photo, map }

class RestaurantProvider extends ChangeNotifier {
  late RestaurantDetail restaurantData;
  Enum state = RestaurantPageDetailState.menu;
  Set<Marker> markers = <Marker>{};
  List<RestaurantReview> reviews = [];
  List<String> restaurantPhotos = [];
  String opening = '';
  String lastOrder = '';

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

  setTime(String data, String data2) {
    opening = data;
    lastOrder = data2;
    notifyListeners();
  }
}
