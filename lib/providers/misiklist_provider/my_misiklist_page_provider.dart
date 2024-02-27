import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklist_class.dart';

class MyMisiklistProvider extends ChangeNotifier {
  Set<Misiklist> dibsMisiklists = {};
  String? nextUrl;
  addMisiklist(Misiklist data) {
    dibsMisiklists.add(data);
    notifyListeners();
  }
}
