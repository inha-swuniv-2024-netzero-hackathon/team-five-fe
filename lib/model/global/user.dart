class UserInfo {
  String? token;
  String? nickName;
  String? id;
  double? latitude;
  double? longitude;

  UserInfo({this.id, this.nickName, this.token, this.latitude, this.longitude});

  factory UserInfo.fromJson(UserInfo info, Map<String, dynamic> json) {
    return UserInfo(
        nickName: json['nickName'],
        id: json['id'],
        token: json['token'],
        latitude: info.latitude,
        longitude: info.longitude);
  }
}

UserInfo dummyUserinfo = UserInfo();
