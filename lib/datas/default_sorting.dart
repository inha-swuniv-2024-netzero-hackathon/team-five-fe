import 'package:flutter/material.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';

enum SortState {
  sortRating(Icon(Icons.star, color: ColorStyles.yellow), '별점순'),
  sortThumb(Icon(Icons.thumb_up, color: ColorStyles.red, size: 20), '추천순'),
  sortDistance(Icon(Icons.pin_drop_rounded, color: ColorStyles.green), '거리순'),
  sortRecent(Icon(Icons.update, color: ColorStyles.blue), '최근순'),
  sortCost(Icon(Icons.sell, color: ColorStyles.red), '가격순');

  final Icon icon;
  final String name;
  const SortState(this.icon, this.name);
}

enum MisiklogSortStandard {
  sortRating(Icon(Icons.timer_sharp), '최근 변경순'),
  sortReview(Icon(Icons.bookmark), '북마크순');

  final Icon icon;
  final String text;
  const MisiklogSortStandard(this.icon, this.text);
}
