class UserInfo {
  late String userName;

  UserInfo(Map<String, dynamic> userInfo) {
    userName = userInfo['username'];
  }
}
