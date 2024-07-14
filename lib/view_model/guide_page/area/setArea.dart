import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/datas/default_location.dart';

class SetArea extends StateNotifier<LocationList> {
  SetArea() : super(LocationList.area1);

  setArea(LocationList v) {
    state = v;
  }
}

final areaProvider = StateNotifierProvider<SetArea, LocationList>((ref) {
  return SetArea();
});
