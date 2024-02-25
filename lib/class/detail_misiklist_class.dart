import 'package:proto_just_design/class/misiklist_restaurant_class.dart';

class MisikListDetail {
  late String uuid;
  late String title;
  String? username;
  String? profileImage;
  late String thumbnail;
  late bool isPrivate;
  late String updated;
  late bool isBookmarked;
  late List<MisiklistRestaurant> restaurantList;
  int? rating;

  MisikListDetail(Map<String, dynamic> detailData) {
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
    thumbnail = detailData["thumbnail"] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    isBookmarked = detailData['is_bookmarked'];
    List dataList = detailData['restaurant_list'];
    restaurantList = dataList
        .map((data) => MisiklistRestaurant(data))
        .toList();
    if (restaurantList.isNotEmpty) {
      rating = restaurantList
          .map((data) => data.rating)
          .toList()
          .reduce((value, element) => value + element);
    } else {
      rating = 0;
    }
  }
}
