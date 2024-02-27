import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklist_class.dart';
import 'package:proto_just_design/datas/default_sorting.dart';

class MisiklistProvider extends ChangeNotifier {
  List<Misiklist> misiklists = [];
  List<String> favMisiklists = [];
  List<Misiklist> myMisiklists = [];
  SortState sorting = SortState.sortRecent;

  changeData(List<Misiklist> misiklistList) {
    misiklists = misiklistList;
    notifyListeners();
  }

  addFavMisiklist(String uuid) {
    if (favMisiklists.contains(uuid)) {
    } else {
      favMisiklists.add(uuid);
    }
    notifyListeners();
  }

  removeFavMisiklist(String uuid) {
    if (favMisiklists.contains(uuid)) {
      favMisiklists.remove(uuid);
    }
    notifyListeners();
  }

  clearFavMisiklist() {
    favMisiklists.clear();
    notifyListeners();
  }

  sortByRecent() {
    misiklists.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
    notifyListeners();
  }

  sortByThumb() {
    misiklists.sort((a, b) => a.bookmarkCount.compareTo(b.bookmarkCount));
    notifyListeners();
  }

  changeSortingStandard(SortState state) {
    sorting = state;
    notifyListeners();
  }

  
}
