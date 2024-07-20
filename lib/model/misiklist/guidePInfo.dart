import 'package:proto_just_design/model/global/restaurant.dart';

class GuidePInfo {
  List<Restaurant> restList = [];
  bool search = false;

  GuidePInfo({
    required this.restList,
    required this.search,
  });

  factory GuidePInfo.copy(GuidePInfo info) {
    return GuidePInfo(
      restList: info.restList,
      search: info.search,
    );
  }
  factory GuidePInfo.changeList(GuidePInfo info, List<Restaurant> list) {
    return GuidePInfo(restList: list, search: info.search);
  }
  factory GuidePInfo.changeSearch(GuidePInfo info, bool search) {
    return GuidePInfo(restList: info.restList, search: search);
  }

  factory GuidePInfo.fromJson(GuidePInfo info, List<dynamic> json) {
    print(json);
    List<Restaurant> restList = [];
    for (dynamic element in json) {
      restList.add(Restaurant.fromJson(element));
    }

    return GuidePInfo(
      restList: restList,
      search: info.search,
    );
  }
}
