import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklog_class.dart';
import 'package:proto_just_design/class/restaurant_class.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/datas/default_sorting.dart';

class GuidePageData extends ChangeNotifier {
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
  }
}

class MisiklogPageData extends ChangeNotifier {
  List<Misiklog> misiklogPageList = [];
  List<String> favMisiklogList = [];
  changeData(List<Misiklog> misiklogs) {
    misiklogPageList = misiklogs;
    notifyListeners();
  }

  addFavMisiklog(String uuid) {
    if (favMisiklogList.contains(uuid)) {
    } else {
      favMisiklogList.add(uuid);
    }

    notifyListeners();
  }

  removeFavMisiklog(String uuid) {
    if (favMisiklogList.contains(uuid)) {
      favMisiklogList.remove(uuid);
    }
    notifyListeners();
  }

  clearFavMisiklog() {
    favMisiklogList.clear();
    notifyListeners();
  }
}

class ReviewPageData extends ChangeNotifier {
  late List<dynamic> reviewPageData;

  changeWidget(List<dynamic> reviews) {
    reviewPageData = reviews;
    notifyListeners();
  }
}

class MyPageData extends ChangeNotifier {
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

class UserData extends ChangeNotifier {
  String? userToken;
  String? userName;
  String? userProfile;

  bool isLogin = false;
  double latitude = 0;
  double longitude = 0;

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
    userToken = null;
    userName = null;
    userProfile = null;
    notifyListeners();
  }

  setLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
    notifyListeners();
  }

  setToken(String token) {
    userToken = token;
  }
}
