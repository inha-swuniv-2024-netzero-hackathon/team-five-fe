class Misiklist {
  late String uuid;
  late String title;
  late String username;
  late String thumbnail;
  late String profileImage;
  late String updatedAt;
  late bool isBookmarked;
  late int bookmarkCount;
  late List<dynamic> restaurantList;
  Misiklist(Map<String, dynamic> data) {
    uuid = data['uuid'];
    title = data['title'];
    Map<String, dynamic> createdBy = data['created_by'] ?? {'username': 'name'};
    username = createdBy['username'];
    profileImage = createdBy['profile_image'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    thumbnail = data["thumbnail"] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    updatedAt = data['updated_at'];
    isBookmarked = data['is_bookmarked'];
    bookmarkCount = data['bookmark_count'];
    restaurantList = data['restaurant_list'];
  }
}
