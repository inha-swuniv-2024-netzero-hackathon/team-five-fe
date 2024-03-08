import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proto_just_design/main.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/restaurant_provider/restaurant_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RestaurantPagePhoto extends StatefulWidget {
  final String uuid;
  const RestaurantPagePhoto({super.key, required this.uuid});

  @override
  State<RestaurantPagePhoto> createState() => _RestaurantPagePhotoState();
}

class _RestaurantPagePhotoState extends State<RestaurantPagePhoto> {
  late String uuid = widget.uuid;
  int photoCount = 1;
  @override
  void initState() {
    super.initState();
    getRestaurantPhoto();
  }

  getRestaurantPhoto() async {
    if (context.read<RestaurantProvider>().reviews.isEmpty) {
      bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
      if (!isNetwork) return;
      String url = '${rootURL}v1/restaurants/$uuid/image/';
      final response = await http.get(Uri.parse(url)
          .replace(queryParameters: <String, dynamic>{'page': '$photoCount'}));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> list = responseData['results'];
        List<String> photoList = list
            .where((map) => map.containsKey('photo_file'))
            .map((map) => map['photo_file'])
            .cast<String>()
            .toList();
        for (String data in photoList) {
          context.read<RestaurantProvider>().addPhoto(data);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> photos =
        context.watch<RestaurantProvider>().restaurantPhotos;
    int len = photos.length;
    return SizedBox(
      width: 500,
      height: 480,
      child: photos.isNotEmpty
          ? ListView.builder(
              itemCount: len,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  if ((len % 2 == 1) && (len < index + 2)) {
                    return Row(
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(photos[index], scale: 180),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 180, height: 180),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(photos[index], scale: 180),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage(photos[index + 1], scale: 180),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox(height: 10);
              },
            )
          : Container(),
    );
  }
}
