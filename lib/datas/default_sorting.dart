import 'package:flutter/material.dart';

enum RestaurantSortStandard {
  sortDefault(Icons.star_border, '기본정렬'),
  sortRating(Icons.star, '별점순'),
  sortDistance(Icons.location_on_sharp, '거리순'),
  sortReview(Icons.text_snippet, '리뷰갯수순');

  final IconData icon;
  final String text;
  const RestaurantSortStandard(this.icon, this.text);
}

enum MisiklogSortStandard {
  sortRating(Icon(Icons.timer_sharp), '최근 변경순'),
  sortReview(Icon(Icons.bookmark), '북마크순');

  final Icon icon;
  final String text;
  const MisiklogSortStandard(this.icon, this.text);
}
