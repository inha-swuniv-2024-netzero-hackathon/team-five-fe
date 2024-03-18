import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/misiklist_provider/misiklist_page_provider.dart';
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => context
            .read<UserDataProvider>()
            .setLocation(position.latitude, position.longitude));
    // context.read<UserData>().setLocation(position.latitude, position.longitude);
  } catch (e) {
    // print(e);
    return;
  }
}

Future<bool> checkLogin(BuildContext context) async {
  if (context.read<UserDataProvider>().isLogin == false) {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
    return result;
  }
  return true;
}

Future<int> setRestaurantBookmark(
    BuildContext context, String token, String uuid) async {
  changeRestaurantBookmark(context, uuid);
  final url = Uri.parse('${rootURL}v1/restaurants/$uuid/bookmark/');
  final response =
      await http.post(url, headers: {"Authorization": 'Bearer $token'});
  return response.statusCode;
}

void changeRestaurantBookmark(BuildContext context, String uuid) {
  if (context.read<UserDataProvider>().favRestaurantList.contains(uuid) == false) {
    context.read<UserDataProvider>().addFavRestaurant(uuid);
  } else {
    context.read<UserDataProvider>().removeFavRestaurant(uuid);
  }
}

Future<int> setMisiklistBookmark(BuildContext context, String uuid) async {
  changeMisiklistBookmark(context, uuid);
  final url = Uri.parse('${rootURL}v1/misiklist/$uuid/bookmark/');
  final response = await http.post(url,
      headers: {"Authorization": "Bearer ${context.read<UserDataProvider>().token}"});
  return response.statusCode;
}

changeMisiklistBookmark(BuildContext context, String uuid) {
  if (context.read<MisiklistProvider>().favMisiklists.contains(uuid) == false) {
    context.read<MisiklistProvider>().addFavMisiklist(uuid);
  } else {
    context.read<MisiklistProvider>().removeFavMisiklist(uuid);
  }
}

num checkDistance(double lat1, double lon1, double lat2, double lon2) {
  double p = pi / 180;
  return 12742 *
      asin(sqrt(0.5 -
          cos((lat1 - lat2) * p) / 2 +
          cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2));
}
