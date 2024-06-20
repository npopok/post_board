import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';

part 'location_state.g.dart';

@riverpod
class LocationState extends _$LocationState {
  @override
  Future<Location> build() async => loadData();

  Future<Location> loadData() async {
    ref.cacheFor(LocationSettings.cacheDuration);
    return LocationHelper.getCurrentPosition();
  }
}
