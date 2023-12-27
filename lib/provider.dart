import 'package:flutter/material.dart';

class guide_page_data extends ChangeNotifier {
  List<dynamic>? page_data;

  change_data(List<dynamic> data) {
    page_data = data;
    notifyListeners();
  }
}

class script_page_data extends ChangeNotifier {
  List<dynamic>? page_data;

  change_data(List<dynamic> data) {
    page_data = data;
    notifyListeners();
  }
}

class review_page_data extends ChangeNotifier {
  late List<dynamic> page_data;

  change_widget(List<dynamic> data) {
    page_data = data;
    notifyListeners();
  }
}

class my_page_data extends ChangeNotifier {
  late List<dynamic> page_data;

  change_widget(List<dynamic> data) {
    page_data = data;
    notifyListeners();
  }
}

class user_info extends ChangeNotifier {
  late String username;
  List user_fav_restaurant_list = [];
  input_username(String usernmae) {
    username = usernmae;
    notifyListeners();
  }

  add_fav_restaurant(String uuid) {
    user_fav_restaurant_list.add(uuid);
    notifyListeners();
  }

  remove_fav_restaurant(String uuid) {
    user_fav_restaurant_list.remove(uuid);
    notifyListeners();
  }
}
