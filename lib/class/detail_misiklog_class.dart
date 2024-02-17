import 'package:proto_just_design/class/restaurant_class.dart';

class MisiklogDetail {
  late String uuid;
  late String title;
  String? username;
  String? profileImage;
  late String thumbnail;
  int totalLikes = 0;
  int totalDislikes = 0;
  late bool isPrivate;
  late String updated;
  late bool isBookmarked;
  late List<Restaurant> restaurantList;
  int? totalRating;

  MisiklogDetail(Map<String, dynamic> detailData) {
    uuid = detailData['uuid'];
    title = detailData['title'];
    Map<String, dynamic> createdBy =
        detailData['created_by'] ?? {'username': 'name'};
    isPrivate = detailData['is_private'];
    if (!isPrivate) {
      username = createdBy['username'];
      profileImage = createdBy['profile_image'] ??
          "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    }
    totalLikes = detailData['total_likes'];
    totalDislikes = detailData['total_dislikes'];
    thumbnail = detailData["thumbnail"] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    isBookmarked = detailData['is_bookmarked'];
    List dataList = detailData['restaurant_list'];
    restaurantList =
        dataList.map((data) => Restaurant(data['restaurant'])).toList();
    totalRating = restaurantList
        .map((data) => data.rating)
        .toList()
        .reduce((value, element) => value + element);
  }
}