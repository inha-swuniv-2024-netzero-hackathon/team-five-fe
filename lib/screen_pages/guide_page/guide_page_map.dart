import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proto_just_design/providers/guide_page_provider.dart';
import 'package:provider/provider.dart';

class GuidePageMap extends StatefulWidget {
  const GuidePageMap({Key? key}) : super(key: key);

  @override
  State<GuidePageMap> createState() => _GuidePageMapState();
}

class _GuidePageMapState extends State<GuidePageMap> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final guidePageData = context.read<GuidePageProvider>();
    return SizedBox(
        height: screenHeight * 0.85,
        child: GoogleMap(
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: context.watch<GuidePageProvider>().marker,
            initialCameraPosition: CameraPosition(
                target: LatLng(guidePageData.selectArea.latitude,
                    guidePageData.selectArea.longitude),
                zoom: 16),
            //스크롤 우선권 부여 코드
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
            mapType: MapType.normal));
  }
}
