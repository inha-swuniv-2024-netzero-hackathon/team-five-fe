import 'package:hooks_riverpod/hooks_riverpod.dart';

class SortState extends StateNotifier<int> {
  SortState() : super(0);

  setDistance() {
    state = 0;
  }

  setScore() {
    state = 1;
  }
}

final sortStateProvdier = StateNotifierProvider<SortState, int>((ref) {
  return SortState();
});
