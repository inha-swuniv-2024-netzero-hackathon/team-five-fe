class RestaurantReview {
  late String uuid;
  late String restaurantUuid;
  late String userName;
  late String profileImage;
  late String title;
  late String content;
  late int ratingTaste;
  late int ratingPrice;
  late int ratingService;
  late bool isAnonymous;
  late String updatedAt;
  late List<dynamic> reviewPhotos;
  RestaurantReview(Map<String, dynamic> review) {
    uuid = review['uuid'];
    restaurantUuid = review['restaurant'];
    Map<String, dynamic>? createdBy = review['created_by'];
    userName = createdBy?['username'] ?? '익명';
    profileImage = createdBy?['profile_image'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    title = review['title'];
    content = review['content'];
    ratingTaste = review['rating_taste'];
    ratingPrice = review['rating_price'];
    ratingService = review['rating_service'];
    isAnonymous = review['is_anonymous'];
    updatedAt = review['updated_at'];
    reviewPhotos = review['review_photos'];
  }
}
