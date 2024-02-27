import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklist_class.dart';

class DibsMisiklistProvider extends ChangeNotifier {
  Set<Misiklist> dibsMisiklists = {};
  String? nextUrl;
  addMisiklist(Misiklist misiklist) {
    dibsMisiklists.add(misiklist);
    notifyListeners();
  }
}
