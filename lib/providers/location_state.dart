import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';

part 'location_state.g.dart';

@riverpod
class LocationState extends _$LocationState {
  @override
  Location build() {
    locationLister.addListener(() => state = locationLister.location);
    return locationLister.location;
  }
}
