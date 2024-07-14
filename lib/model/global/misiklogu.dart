class Misiklog {
  late String uuid;
  late String title;
  late String nickname;
  late String profileImage;
  late String thumbnail;
  late bool isBookmarked;
  late List<dynamic> restaurantList;

  Misiklog(Map<String, dynamic> data) {
    uuid = data['uuid'];
    title = data['title'];
    Map<String, dynamic> createdBy = data['created_by'] ?? {'nickname': 'name'};
    nickname = createdBy['nickname'];
    profileImage = createdBy['profile_image'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    thumbnail = data["thumbnail"] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    isBookmarked = data['is_bookmarked'];
    restaurantList = data['restaurant_list'];
  }
}
