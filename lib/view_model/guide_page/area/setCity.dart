import 'package:hooks_riverpod/hooks_riverpod.dart';

class SetCity extends StateNotifier<String> {
  SetCity() : super('');

  setArea(String area) {
    state = area;
  }
}

final cityProvider = StateNotifierProvider<SetCity, String>((ref) {
  return SetCity();
});
