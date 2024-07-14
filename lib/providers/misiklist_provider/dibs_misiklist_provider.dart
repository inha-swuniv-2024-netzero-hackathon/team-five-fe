import 'package:flutter/material.dart';
import 'package:proto_just_design/model/global/misiklist.dart';

class DibsMisiklistProvider extends ChangeNotifier {
  Set<Misiklist> dibsMisiklists = {};
  String? nextUrl;
  addMisiklist(Misiklist misiklist) {
    dibsMisiklists.add(misiklist);
    notifyListeners();
  }
}
