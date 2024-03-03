import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/providers/guide_provider/guide_page_provider.dart';
import 'package:proto_just_design/providers/restaurant_provider/restaurant_page_provider.dart';
import 'package:provider/provider.dart';

class RestaurantPageMap extends StatefulWidget {
  const RestaurantPageMap({super.key});

  @override
  State<RestaurantPageMap> createState() => _RestaurantPageMapState();
}

class _RestaurantPageMapState extends State<RestaurantPageMap> {
  @override
  Widget build(BuildContext context) {
    RestaurantPageProvider restaurantPageProvider =
        context.watch<RestaurantPageProvider>();
    final latitude = restaurantPageProvider.restaurantData.latitude ??
        context.read<GuidePageProvider>().selectArea.latitude;
    final longitude = restaurantPageProvider.restaurantData.longitude ??
        context.read<GuidePageProvider>().selectArea.longitude;
    final marker = context.watch<RestaurantPageProvider>().markers;
    return Column(
      children: [
        SizedBox(
            height: 500,
            child: GoogleMap(
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                markers: marker,
                initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude), zoom: 16),
                //스크롤 우선권 부여 코드
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                mapType: MapType.normal)),
        const SizedBox(height: 40)
      ],
    );
  }
}
