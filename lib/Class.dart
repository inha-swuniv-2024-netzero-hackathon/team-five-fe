import 'package:proto_just_design/restaurant.dart';

class Restaurant {
  late String uuid;
  late String name_korean;
  late String thumbnail;
  late int rating_count;
  late int rating;
  late int rating_taste;
  late int rating_price;
  late int rating_service;
  int? daytime_price;
  int? evening_price;

  Restaurant(Map<String, dynamic> restaurant_data) {
    this.uuid = restaurant_data['uuid'];
    this.name_korean = restaurant_data['name_korean'];
    this.thumbnail = restaurant_data['thumbnail'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    Map restaurant_info = restaurant_data['restaurant_info'];
    this.rating_count = restaurant_info['rating_count'];
    this.rating = restaurant_info['rating'];
    this.rating_taste = restaurant_info['rating_taste'];
    this.rating_price = restaurant_info['rating_price'];
    this.rating_service = restaurant_info['rating_service'];
    this.daytime_price = restaurant_info['daytime_price'] ?? 0;
    this.evening_price = restaurant_info['evening_price'] ?? 0;
  }
}

class Restaurant_list {
  late String uuid;
  late String title;
  late String username;
  late String profile_image;
  late bool is_private;
  late int bookmark_count;
  late List<dynamic> restaurant_list;
  late double avg_rate;
  late String thumbnail;

  Restaurant_list(Map<String, dynamic> restaurant_list_data) {
    this.uuid = restaurant_list_data['uuid'];
    this.title = restaurant_list_data['title'];
    Map created_by = restaurant_list_data['created_by'];
    this.username = created_by['username'];
    this.profile_image = created_by['profile_image'];
    this.is_private = restaurant_list_data['is_private'];
    this.bookmark_count = restaurant_list_data['bookmark_count'];
    this.restaurant_list = restaurant_list_data['restaurant_list'];
    if (restaurant_list.length != 0) {
      double rate_sum = 0;
      for (Map<String, dynamic> restaurant_data in restaurant_list) {
        rate_sum += Restaurant(restaurant_data['restaurant']).rating;
      }
      this.avg_rate = rate_sum / restaurant_list.length;
    } else {
      this.avg_rate = 300;
    }
    this.thumbnail = created_by['profile_image'];
  }
}

class RestaurantDetail {
  late String uuid;
  late String name_korean;
  late String name_native;
  late String name_english;
  late String thumbnail;

  late String telephone_number;
  late List<String> genre;
  late String address_korean;
  late String address_native;
  late String address_english;
  late String area;
  double? latitude;
  double? longitude;

  late int rating_count;
  late int rating;
  late int rating_taste;
  late int rating_price;
  late int rating_service;
  int? daytime_price;
  int? evening_price;

  late List service_list;
  // 서비스 제공 목록이나 ui같은것들을 여기 담아 반환 할 예정
  RestaurantDetail(Map<String, dynamic> restaurant_detail) {
    this.uuid = restaurant_detail['uuid'];
    this.name_korean = restaurant_detail['name_korean'];
    this.thumbnail = restaurant_detail['thumbnail'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    Map restaurant_info = restaurant_detail['restaurant_info'];
    this.rating_count = restaurant_info['rating_count'];
    this.rating = restaurant_info['rating'];
    this.rating_taste = restaurant_info['rating_taste'];
    this.rating_price = restaurant_info['rating_price'];
    this.rating_service = restaurant_info['rating_service'];
    this.daytime_price = restaurant_info['daytime_price'];
    this.evening_price = restaurant_info['evening_price'];

    this.telephone_number = restaurant_info['telephone_number'] ?? 'Unknwon';
    this.genre = restaurant_info['genre'] ?? [];
    this.address_korean = restaurant_info['address_korean'] ?? 'Unknwon';
    this.address_native = restaurant_info['address_native'] ?? 'Unknwon';
    this.address_english = restaurant_info['address_english'] ?? 'Unknwon';
    this.area = restaurant_info['area'] ?? 'Unknwon';
    this.latitude = restaurant_info['latitude'];
    this.longitude = restaurant_info['longitude'];
    this.service_list = [];
  }
}
