class MisiklistRestaurant {
  late String uuid;
  late String name;
  late String thumbnail;
  double? latitude;
  double? longitude;

  late int ratingCount;
  late int rating;
  late int ratingTaste;
  late int ratingPrice;
  late int ratingService;
  int? daytimePrice;
  int? eveningPrice;

  late List serviceList;
  MisiklistRestaurant(Map<String, dynamic> restaurantDetail) {
    uuid = restaurantDetail['uuid'];
    name = restaurantDetail['name'] ?? '';
    thumbnail = restaurantDetail['thumbnail'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    latitude = restaurantDetail['latitude'];
    longitude = restaurantDetail['longitude'];

    Map restaurantInfo = restaurantDetail['restaurant_info'];
    ratingCount = restaurantInfo['rating_count'];
    rating = restaurantInfo['rating'];
    ratingTaste = restaurantInfo['rating_taste'];
    ratingPrice = restaurantInfo['rating_price'];
    ratingService = restaurantInfo['rating_service'];
    daytimePrice = restaurantInfo['daytime_price'];
    eveningPrice = restaurantInfo['evening_price'];

    serviceList = [];
  }
}
