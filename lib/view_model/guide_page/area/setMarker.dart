import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Setmarker extends StateNotifier<List<Marker>> {
  Setmarker() : super([]);

  setMarekr(List<Restaurant> restList) {
    state = setRestaurantMarker(restList);
  }
}

final markersProvider = StateNotifierProvider<Setmarker, List<Marker>>((ref) {
  return Setmarker();
});

List<Marker> setRestaurantMarker(List<Restaurant> restList) {
  List<Marker> marekrs = [];
  for (Restaurant restaurant in restList) {
    marekrs.add(Marker(
        markerId: MarkerId(restaurant.name),
        infoWindow: InfoWindow(title: restaurant.name),
        position: LatLng(restaurant.latitude, restaurant.longitude)));
  }
  return marekrs;
}
