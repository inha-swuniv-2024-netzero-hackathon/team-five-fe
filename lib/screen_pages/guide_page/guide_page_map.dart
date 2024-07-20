import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:proto_just_design/model/global/user.dart';
import 'package:proto_just_design/model/misiklist/guidePInfo.dart';
import 'package:proto_just_design/view_model/global/userVM.dart';
import 'package:proto_just_design/view_model/guide_page/guidePage.dart';

class GuidePageMap extends ConsumerStatefulWidget {
  const GuidePageMap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuidePageMapState();
}

class _GuidePageMapState extends ConsumerState<GuidePageMap> {
  @override
  Widget build(BuildContext context) {
    UserInfo user = ref.watch(userProvider);
    final screenHeight = MediaQuery.sizeOf(context).height;
    GuidePInfo guidePageVM = ref.watch(guidePageProvider);
    return SizedBox(
        height: screenHeight - 60,
        child: GoogleMap(
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: guidePageVM.restList
                .map(
                  (value) {
                    return restToMarker(value);
                  },
                )
                .toList()
                .toSet(),
            initialCameraPosition: CameraPosition(
                target: LatLng(user.latitude!, user.longitude!), zoom: 16),
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
            mapType: MapType.normal));
  }
}

Marker restToMarker(Restaurant restaurant) {
  return Marker(
      markerId: MarkerId(restaurant.uuid),
      infoWindow: InfoWindow(title: restaurant.name),
      position: LatLng(restaurant.latitude, restaurant.longitude));
}
