import 'dart:io';

class MisiklistRestaurant {
  late String uuid;
  late String name;
  late String thumbnail;
  File? changedThumbnail;
  double? latitude;
  double? longitude;
  late String memo;
  late int rating;
  late int ratingTaste;
  late int ratingPrice;
  late int ratingService;
  int? daytimePrice;
  int? eveningPrice;

  late List serviceList;
  MisiklistRestaurant(Map<String, dynamic> data) {
    Map<String, dynamic> restaurantDetail = data['restaurant'];
    uuid = restaurantDetail['uuid'];
    name = restaurantDetail['name'] ?? '';
    thumbnail = restaurantDetail['thumbnail_url'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    latitude = restaurantDetail['latitude'];
    longitude = restaurantDetail['longitude'];
    memo = data['memo'] ?? '';
    Map restaurantInfo = restaurantDetail['restaurant_info'];
    rating = restaurantInfo['rating'];
    ratingTaste = restaurantInfo['rating_taste'];
    ratingPrice = restaurantInfo['rating_price'];
    ratingService = restaurantInfo['rating_service'];
    daytimePrice = restaurantInfo['daytime_price'];
    eveningPrice = restaurantInfo['evening_price'];
    serviceList = [];
  }

  MisiklistRestaurant.copy(MisiklistRestaurant data) {
    uuid = data.uuid;
    name = data.name;
    thumbnail = data.thumbnail;
    latitude = data.latitude;
    longitude = data.longitude;
    memo = data.memo;
    rating = data.rating;
    ratingTaste = data.ratingTaste;
    ratingPrice = data.ratingPrice;
    ratingService = data.ratingService;
    daytimePrice = data.daytimePrice;
    eveningPrice = data.eveningPrice;
  }
}
