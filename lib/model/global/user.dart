class UserInfo {
  String? id;
  String? qr =
      'https://convenii.s3.ap-northeast-2.amazonaws.com/f27ac049-ffb8-42ac-a7d4-1909273f4275';
  double latitude = 0;
  double longitude = 0;
  int coo = 1;

  UserInfo({
    required this.coo,
    this.id,
    this.qr,
    required this.latitude,
    required this.longitude,
  });
}
