import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/model/global/user.dart';

class Setmarker extends StateNotifier<UserInfo> {
  Setmarker() : super(UserInfo());
}

final markersProvider = StateNotifierProvider<Setmarker, UserInfo>((ref) {
  return Setmarker();
});
