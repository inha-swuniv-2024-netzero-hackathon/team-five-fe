import 'package:hooks_riverpod/hooks_riverpod.dart';

class SetFav extends StateNotifier<List<String>> {
  SetFav() : super(['']);
  setFav(String id) {
    if (state.contains(id)) {
      List<String> a = [];
      for (String i in state) {
        if (i != id) {
          a.add(i);
        }
        state = a;
      }
    } else {
      state = [...state, id];
    }
  }
}

final favProvider = StateNotifierProvider<SetFav, List<String>>((ref) {
  return SetFav();
});
