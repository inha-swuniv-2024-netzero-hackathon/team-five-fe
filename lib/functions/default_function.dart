import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/guide_page_provider.dart';
import 'package:proto_just_design/providers/misiklist_page_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/screen_pages/login_page/login_page.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<void> getCurrentLocation(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  // print(permission);
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    context.read<UserData>().setLocation(position.latitude, position.longitude);
  } catch (e) {
    print(e);
  }
}

Future<bool> checkLogin(BuildContext context) async {
  if (context.read<UserData>().isLogin == false) {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
    return result;
  }
  return true;
}

Future setRestaurantBookmark(
    BuildContext context, String token, String uuid) async {
  changeRestaurantBookmark(context, uuid);
  final url = Uri.parse('${rootURL}v1/restaurants/restaurants/$uuid/bookmark/');
  final response =
      await http.post(url, headers: {"Authorization": 'Bearer $token'});

  if (response.statusCode != 200) {
    changeRestaurantBookmark(context, uuid);
  }
}

void changeRestaurantBookmark(BuildContext context, String uuid) {
  if (context.read<GuidePageProvider>().favRestaurantList.contains(uuid) == false) {
    context.read<GuidePageProvider>().addFavRestaurant(uuid);
  } else {
    context.read<GuidePageProvider>().removeFavRestaurant(uuid);
  }
}

void setMisiklogBookmark(BuildContext context, String uuid) async {
  changeMisiklogBookmark(context, uuid);
  final url = Uri.parse('${rootURL}v1/misiklogu/$uuid/bookmark/');
  final response = await http.post(url, headers: {
    "Authorization": "Bearer ${context.read<UserData>().token}"
  });

  if (response.statusCode != 200) {
    changeMisiklogBookmark(context, uuid);
  }
  print(response.statusCode);
}

changeMisiklogBookmark(BuildContext context, String uuid) {
  if (context.read<MisiklistProvider>().favMisiklogList.contains(uuid) ==
      false) {
    context.read<MisiklistProvider>().addFavMisiklog(uuid);
  } else {
    context.read<MisiklistProvider>().removeFavMisiklog(uuid);
  }
}

num checkDistance(nowLat, nowLon, lat, lon) {
  return pow((nowLat - lat), 2) + pow((nowLon - lon), 2);
}
