import 'package:flutter/material.dart';
import 'package:proto_just_design/providers/restaurant_provider/restaurant_page_provider.dart';
import 'package:provider/provider.dart';

class RestaurantPagePhoto extends StatefulWidget {
  const RestaurantPagePhoto({super.key});

  @override
  State<RestaurantPagePhoto> createState() => _RestaurantPagePhotoState();
}

class _RestaurantPagePhotoState extends State<RestaurantPagePhoto> {
  @override
  Widget build(BuildContext context) {
    List<String> photos =
        context.watch<RestaurantPageProvider>().restaurantPhotos;
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
                        Container(),
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
