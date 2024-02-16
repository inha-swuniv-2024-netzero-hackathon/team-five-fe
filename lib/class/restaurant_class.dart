class Restaurant {
  late String uuid;
  late String name;
  late String thumbnail;
  late double latitude;
  late double longitude;
  late bool isBookmarked;
  late int ratingCount;
  late int rating;
  late int ratingTaste;
  late int ratingPrice;
  late int ratingService;
  int? daytimePrice;
  int? eveningPrice;

  Restaurant(Map<String, dynamic> restaurantData) {
    uuid = restaurantData['uuid'];
    name = restaurantData['name'] ?? restaurantData['name_korean'];
    thumbnail = restaurantData['thumbnail'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    latitude = restaurantData['latitude'];
    longitude = restaurantData['longitude'];
    isBookmarked = restaurantData['is_bookmarked'] ?? false;
    Map restaurantInfo = restaurantData['restaurant_info'];
    ratingCount = restaurantInfo['rating_count'];
    rating = restaurantInfo['rating'];
    ratingTaste = restaurantInfo['rating_taste'];
    ratingPrice = restaurantInfo['rating_price'];
    ratingService = restaurantInfo['rating_service'];
    daytimePrice = restaurantInfo['daytime_price'];
    eveningPrice = restaurantInfo['evening_price'];
  }
}
