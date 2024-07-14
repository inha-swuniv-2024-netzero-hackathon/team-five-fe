import 'package:proto_just_design/model/misiklist/misiklist_restaurant.dart';

class MisikListDetail {
  late String uuid;
  late String title;
  String? nickname;
  String? profileImage;
  late String thumbnail;
  late bool isPrivate;
  // late String updated;
  late bool isBookmarked;
  late List<MisiklistRestaurant> restaurantList;
  int? rating;

  MisikListDetail(Map<String, dynamic> detailData) {
    uuid = detailData['uuid'];
    title = detailData['title'];
    Map<String, dynamic> createdBy =
        detailData['created_by'] ?? {'nickname': 'name'};
    isPrivate = detailData['is_private'];
    if (!isPrivate) {
      nickname = createdBy['nickname'];
      profileImage = createdBy['profile_image'] ??
          "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    }
    thumbnail = detailData["thumbnail"] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    isBookmarked = detailData['is_bookmarked'];
    List dataList = detailData['restaurant_list'];
    restaurantList = dataList.map((data) => MisiklistRestaurant(data)).toList();
    if (restaurantList.isNotEmpty) {
      rating = restaurantList
          .map((data) => data.rating)
          .toList()
          .reduce((value, element) => value + element);
    } else {
      rating = 0;
    }
  }

  MisikListDetail.copy(MisikListDetail source) {
    uuid = source.uuid;
    title = source.title;
    nickname = source.nickname;
    profileImage = source.profileImage;
    thumbnail = source.thumbnail;
    isPrivate = source.isPrivate;
    isBookmarked = source.isBookmarked;
    restaurantList = List<MisiklistRestaurant>.from(
        source.restaurantList.map((item) => MisiklistRestaurant.copy(item)));
    rating = source.rating;
  }
}
