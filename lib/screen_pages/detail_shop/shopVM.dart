import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/screen_pages/detail_shop/shopScreen.dart';

class SetProduct extends StateNotifier<List<Product>> {
  SetProduct() : super([]);

  setList(List<dynamic> value) {
    state = value.map(
      (e) {
        return Product.fromJson(e as Map<String, dynamic>);
      },
    ).toList();
  }
}

final productProvider = StateNotifierProvider<SetProduct, List<Product>>((ref) {
  return SetProduct();
});

class SetReview extends StateNotifier<List<Review>> {
  SetReview() : super([]);

  setList(List<dynamic> value) {
    state = value.map(
      (e) {
        return Review.fromJson(e as Map<String, dynamic>);
      },
    ).toList();
  }
}

final reviewProvider = StateNotifierProvider<SetReview, List<Review>>((ref) {
  return SetReview();
});
