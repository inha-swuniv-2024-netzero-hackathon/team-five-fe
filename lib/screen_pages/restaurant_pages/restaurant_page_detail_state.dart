import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proto_just_design/class/restaurant_review_class.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';

Widget restaurantPageMenuState(BuildContext context) {
  return Container();
}

Widget restaurantPageReviewState(BuildContext context, List<dynamic> reviews) {
  return SizedBox(
    width: 400,
    height: 500,
    child: reviews.isNotEmpty
        ? ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              if ((reviews.length > index)) {
                RestaurantReview review = RestaurantReview(reviews[index]);
                if (review.reviewPhotos.isNotEmpty) {
                  List<Widget> photos = [];
                  for (Map<String, dynamic> photo in review.reviewPhotos) {
                    photos.add(Container(
                      width: 255,
                      height: 255,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('${photo['photo_file']}',
                                scale: 255),
                            fit: BoxFit.cover),
                      ),
                    ));
                  }
                  int rating = (review.ratingPrice +
                          review.ratingService +
                          review.ratingTaste) ~/
                      3;
                  return Container(
                    padding:
                        const EdgeInsets.only(top: 25, left: 15, right: 30),
                    width: 340,
                    height: 440,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadows: Boxshadows.defaultShadow),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: const ShapeDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg",
                                      scale: 30),
                                  fit: BoxFit.cover),
                              shape: OvalBorder()),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(review.userName,
                                style: const TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                makeRatingShower(context, 115, 4, rating),
                                const SizedBox(width: 10),
                                Text(
                                  '${rating / 100}',
                                  style: const TextStyle(
                                    color: ColorStyles.yellow,
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(review.title,
                                style: const TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                )),
                            const SizedBox(height: 5),
                            Text(review.content, maxLines: 5),
                            const SizedBox(height: 6),
                            Text(
                              review.updatedAt,
                              style: const TextStyle(
                                color: ColorStyles.silver,
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 225,
                              height: 225,
                              color: Colors.grey,
                              child: PageView(
                                scrollDirection: Axis.horizontal,
                                children: photos,
                              ),
                            ),
                            const SizedBox(height: 40)
                          ],
                        )
                      ],
                    ),
                  );
                }
              }
              return Container();
            },
          )
        : Container(),
  );
}

Widget restaurantPagePhotoState(BuildContext context, List<String> photos) {
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
                            image: NetworkImage(photos[index + 1], scale: 180),
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

Widget restaurantPageMapState(
    BuildContext context, double latitude, double longitude, dynamic marker) {
  return Column(
    children: [
      SizedBox(
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
      const SizedBox(height: 40)
    ],
  );
}
