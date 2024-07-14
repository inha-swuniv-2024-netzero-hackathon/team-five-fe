import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/restaurant.dart';

class RestMarker extends StateNotifier<List<Restaurant>> {
  RestMarker() : super([]);

  setMarker(List<Restaurant> v) {
    state = v;
  }

  addMarker(List<Restaurant> v) {
    state = [...state, ...v];
  }
}

final markerProvider = StateNotifierProvider<RestMarker, List<Restaurant>>((ref) {
  return RestMarker();
});
