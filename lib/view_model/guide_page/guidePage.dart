import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';

class GuidePageVM extends StateNotifier<GuidePInfo> {
  GuidePageVM() : super(dummyGuidePageVM);

  getDistance() async {
    List<dynamic>? jsonData = await _getDistance();
    if (jsonData != null) {
      state = GuidePInfo.fromJson(state, jsonData);
    }
  }

  getScore() async {
    List<dynamic>? jsonData = await _getScore();
    if (jsonData != null) {
      state = GuidePInfo.fromJson(state, jsonData);
    }
  }

  changeList(List<Restaurant> list) async {
    state = GuidePInfo.changeList(state, list);
  }

  changeSearch() {
    state = GuidePInfo.changeSearch(state, !state.search);
  }
}

final guidePageProvider = StateNotifierProvider<GuidePageVM, GuidePInfo>((ref) {
  return GuidePageVM();
});

GuidePInfo dummyGuidePageVM = GuidePInfo(restList: [], search: false);

Future<List<dynamic>?> _getScore() async {
  final url = Uri.parse('http://3.38.186.181:3000/account/score');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      return responseData;
    } else if (response.statusCode == 401) {}
  } catch (e) {
    return null;
  }
  return null;
}

Future<List<dynamic>?> _getDistance() async {
  final url = Uri.parse('http://3.38.186.181:3000/store/distance');
  final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      return responseData;
    } else if (response.statusCode == 401) {}

  return null;
}
