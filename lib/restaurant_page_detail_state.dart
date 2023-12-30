import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Class.dart';
import 'make_rating_shower.dart';

Widget restaurant_page_rating_state(BuildContext context) {
  return Container();
}

Widget restaurant_page_menu_state(BuildContext context) {
  return Container();
}

Widget restaurant_page_review_state(BuildContext context) {
  return Container();
}

Widget restaurant_page_guide_state(BuildContext context) {
  return Container();
}

Widget restaurant_page_photo_state(BuildContext context) {
  return Container();
}

Widget restaurant_page_map_state(
    BuildContext context, double latitude, double longitude, dynamic marker) {
  return Column(
    children: [
      Container(
          height: 500,
          child: GoogleMap(
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              markers: marker,
              initialCameraPosition:
                  CameraPosition(target: LatLng(latitude, longitude), zoom: 16),
              //스크롤 우선권 부여 코드
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              },
              mapType: MapType.normal)),
      SizedBox(height: 40)
    ],
  );
}
