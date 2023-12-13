import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Class.dart';

class restaurant_page extends StatefulWidget {
  final String uuid;
  const restaurant_page({Key? key, required this.uuid}) : super(key: key);
  @override
  State<restaurant_page> createState() => _restaurant_pageState();
}

class _restaurant_pageState extends State<restaurant_page> {
  late String uuid = widget.uuid;
  late RestaurantDetail? restaurant_data = null;

  @override
  void initState() {
    super.initState();
    get_Restaurant_List();
  }

  Future<void> get_Restaurant_List() async {
    String url =
        'https://basak.chungran.net/v1/restaurants/restaurants/${uuid}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        restaurant_data = RestaurantDetail(responseData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${restaurant_data}'),
    );
  }
}
