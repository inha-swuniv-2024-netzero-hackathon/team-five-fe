import 'package:flutter/material.dart';
import 'package:proto_just_design/class/restaurant_review_class.dart';
import 'package:proto_just_design/providers/restaurant_provider/restaurant_page_provider.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/widget_datas/default_widget.dart';
import 'package:provider/provider.dart';

class RestaurantPageReview extends StatefulWidget {
  const RestaurantPageReview({super.key});

  @override
  State<RestaurantPageReview> createState() => _RestaurantPageReviewState();
}

class _RestaurantPageReviewState extends State<RestaurantPageReview> {
  @override
  Widget build(BuildContext context) {
    List<RestaurantReview> reviews =
        context.watch<RestaurantPageProvider>().restaurantreviews;

    return SizedBox(
      width: 400,
      height: 500,
      child: reviews.isNotEmpty
          ? ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                if ((reviews.length > index)) {
                  RestaurantReview review = reviews[index];
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
}
