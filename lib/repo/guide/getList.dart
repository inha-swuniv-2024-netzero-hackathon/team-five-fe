import 'dart:convert';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/main.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getRestaurantList(
    String? token, String? next, LocationList area) async {
  // bool a = await ref.watch(netCheckProvider);
  // if (!a) return;

  final url = Uri.parse(next ??
      '${rootURL}v1/restaurants/?area__id=${area.areaNum}&ordering=restaurant_info__rating&page=1');

  final response = (token == null)
      ? await http.get(url)
      : await http.get(url, headers: {"Authorization": "Bearer $token"});
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));
    return responseData;
  } else if (response.statusCode == 401) {}
  return null;
}
