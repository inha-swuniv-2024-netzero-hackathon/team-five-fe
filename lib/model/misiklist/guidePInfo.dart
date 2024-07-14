import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/model/global/restaurant.dart';

class GuidePInfo {
  List<Restaurant> restList = [];
  String next;
  bool search = false;
  SortState sort = SortState.sortRating;

  GuidePInfo(
      {required this.restList,
      required this.search,
      required this.sort,
      required this.next});

  factory GuidePInfo.copy(GuidePInfo info) {
    return GuidePInfo(
        restList: info.restList,
        search: info.search,
        sort: info.sort,
        next: info.next);
  }
  factory GuidePInfo.changeList(GuidePInfo info, List<Restaurant> list) {
    return GuidePInfo(
        restList: list, search: info.search, sort: info.sort, next: info.next);
  }
  factory GuidePInfo.changeSearch(GuidePInfo info, bool search) {
    return GuidePInfo(
        restList: info.restList,
        search: search,
        sort: info.sort,
        next: info.next);
  }
  factory GuidePInfo.changeState(GuidePInfo info, SortState state) {
    return GuidePInfo(
        restList: info.restList,
        search: info.search,
        sort: state,
        next: info.next);
  }
  factory GuidePInfo.changeNext(GuidePInfo info, String next) {
    return GuidePInfo(
        restList: info.restList,
        search: info.search,
        sort: info.sort,
        next: next);
  }

  factory GuidePInfo.fromJson(GuidePInfo info, Map<String, dynamic> json) {
    List jsonRestList = json['result'];
    List<Restaurant> restList = jsonRestList.map((value) {
      return Restaurant.fromJson(value);
    }).toList();

    return GuidePInfo(
        restList: [...info.restList, ...restList],
        search: info.search,
        sort: info.sort,
        next: json['next']);
  }
}
