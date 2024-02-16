class Misiklist {
  late String uuid;
  late String title;
  late String username;
  late String profileImage;
  late bool isBookmarked;
  late List<dynamic> restaurantList;
  Misiklist(Map<String, dynamic> data) {
    uuid = data['uuid'];
    title = data['title'];
    Map<String, dynamic> createdBy = data['created_by'] ?? {'username': 'name'};
    username = createdBy['username'];
    profileImage = createdBy['profile_image'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    // thumbnail = misiklogData["thumbnail"] ??
    //     "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    isBookmarked = data['is_bookmarked'];
    restaurantList = data['restaurant_list'];
  }
}
