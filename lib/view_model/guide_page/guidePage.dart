import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/datas/GuidePageVMDummy.dart';
import 'package:proto_just_design/datas/default_location.dart';
import 'package:proto_just_design/datas/default_sorting.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';
import 'package:proto_just_design/repo/guide/getList.dart';

class GuidePageVM extends StateNotifier<GuidePInfo> {
  GuidePageVM() : super(dummyGuidePageVM);

  setInfo(String? token, GuidePInfo value, LocationList area) async {
    Map<String, dynamic>? jsonData =
        await getRestaurantList(token, state.next, area);
    if (jsonData != null) {
      state = GuidePInfo.fromJson(value, jsonData);
    } else {
      state = value;
    }
  }

  changeList(List<Restaurant> list) async {
    state = GuidePInfo.changeList(state, list);
  }

  changeSearch(bool search) {
    state = GuidePInfo.changeSearch(state, search);
  }

  changeSorting(SortState sort) {
    state = GuidePInfo.changeState(state, sort);
  }

  changeNext(String url) {
    state = GuidePInfo.changeNext(state, url);
  }
}

final guidePageProvider = StateNotifierProvider<GuidePageVM, GuidePInfo>((ref) {
  return GuidePageVM();
});
