import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? token;
  String? userName;
  String? userProfile;

  bool isLogin = false;
  double latitude = 0;
  double longitude = 0;

  List<String> favRestaurantList = [];

  inputUserData(String name, String profile) {
    userName = name;
    userProfile = profile;
    notifyListeners();
  }

  logIn() {
    isLogin = true;
    notifyListeners();
  }

  logOut() {
    isLogin = false;
    token = null;
    userName = null;
    userProfile = null;
    notifyListeners();
  }

  setLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
    notifyListeners();
  }

  setToken(String data) {
    token = data;
  }

  addFavRestaurant(String uuid) {
    favRestaurantList.add(uuid);
    notifyListeners();
  }

  removeFavRestaurant(String uuid) {
    favRestaurantList.remove(uuid);
    notifyListeners();
  }

  clearFavRestaurant() {
    favRestaurantList.clear();
    notifyListeners();
  }
}
