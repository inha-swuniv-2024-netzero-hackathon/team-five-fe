class Restaurant {
  String picture;
  String name;
  String time;
  double star;
  int reviewNum;
  int tagNum;
  String tag;
  Map<String, dynamic> review;
  
  Restaurant(this.picture, this.name, this.time, this.star, this.reviewNum,
      this.tagNum, this.tag, this.review);
}
