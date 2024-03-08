class RestaurantDetail {
  late String uuid;
  late String nameKorean;
  late String nameNative;
  late String nameEnglish;
  late String thumbnail;
  late String telephoneNumber;
  late List<String> genre;
  late String addressNative;
  late String addressEnglish;
  late String addressKorean;
  late String area;
  Map<String, dynamic>? openingHour;
  double? latitude;
  double? longitude;

  late int rating;
  late int ratingTaste;
  late int ratingPrice;
  late int ratingService;
  int? daytimePrice;
  int? eveningPrice;

  late List serviceList;
  // 서비스 제공 목록이나 ui같은것들을 여기 담아 반환 할 예정
  RestaurantDetail(Map<String, dynamic> restaurantDetail) {
    uuid = restaurantDetail['uuid'];
    nameKorean = restaurantDetail['name_korean'];
    nameNative =
        restaurantDetail['name_native'] ?? restaurantDetail['name_korean'];
    thumbnail = restaurantDetail['thumbnail'] ??
        "https://basak-image-bucket.s3.amazonaws.com/restaurant_thumbnails_sample/sample_ramen.jpg";
    latitude = restaurantDetail['latitude'];
    longitude = restaurantDetail['longitude'];
    telephoneNumber = restaurantDetail['telephone_number'] ?? 'Unknown_tel';
    addressNative = restaurantDetail['address_native'] ?? '';
    addressEnglish = restaurantDetail['address_english'] ?? '';
    addressKorean = restaurantDetail['address_korean'] ?? '';

    Map restaurantInfo = restaurantDetail['restaurant_info'];
    openingHour = restaurantInfo['opening_hours'];
    rating = restaurantInfo['rating'];
    ratingTaste = restaurantInfo['rating_taste'];
    ratingPrice = restaurantInfo['rating_price'];
    ratingService = restaurantInfo['rating_service'];
    daytimePrice = restaurantInfo['daytime_price'];
    eveningPrice = restaurantInfo['evening_price'];

    genre = restaurantInfo['genre'] ?? [];
    area = restaurantInfo['area'] ?? '';

    serviceList = [];
  }
}
