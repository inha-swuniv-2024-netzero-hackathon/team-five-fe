import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapView extends StateNotifier<bool> {
  MapView() : super(false);

  setView(bool v) {
    state = v;
  }
}

final viewProvider = StateNotifierProvider<MapView, bool>((ref) {
  return MapView();
});
