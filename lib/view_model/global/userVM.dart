import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/user.dart';

class SetUser extends StateNotifier<UserInfo> {
  SetUser() : super(UserInfo(coo: 30, latitude: 0, longitude: 0));

  serUser() async {
    Map<String, dynamic>? a = await _getUser();
    if (a != null) {
      state = UserInfo(
          latitude: state.latitude,
          longitude: state.longitude,
          coo: a['coo'],
          qr: a['qr']);
    }
  }

  setLocation() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      state = UserInfo(
          id: state.id,
          latitude: position.latitude,
          longitude: position.longitude,
          coo: state.coo);
    }
  }

  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      return null;
    }
  }
}

final userProvider = StateNotifierProvider<SetUser, UserInfo>((ref) {
  return SetUser();
});

Future<Map<String, dynamic>?> _getUser() async {
  final url = Uri.parse('http://3.38.186.181:3000/account/data');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      print(responseData);
      return responseData;
    } else if (response.statusCode == 401) {}
  } catch (e) {
    return null;
  }
  return null;
}
