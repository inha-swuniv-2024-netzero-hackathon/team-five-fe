class Restaurant {
  late String uuid;
  late String name;
  late double latitude;
  late double longitude;
  late double rating;
  late String url;
  late String addrses;

  Restaurant(
      {required this.uuid,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.rating,
      required this.url,
      required this.addrses});

  factory Restaurant.fromJson(Map<String, dynamic> restaurantData) {
    print('dot');
    print(restaurantData);
    return Restaurant(
      uuid: restaurantData['idx'].toString(),
      name: restaurantData['name'] ?? 'name',
      latitude: restaurantData['latitude'] is String
          ? double.parse(restaurantData['latitude'])
          : restaurantData['latitude'].toDouble(),
      longitude: restaurantData['longtitude'] is String
          ? double.parse(restaurantData['longtitude'])
          : restaurantData['longtitude'].toDouble(),
      rating: double.parse(restaurantData['score']),
      url: restaurantData['image'],
      addrses: restaurantData['address'],
    );
  }
}
