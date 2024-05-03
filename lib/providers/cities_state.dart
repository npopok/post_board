import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/common/common.dart';

part 'cities_state.g.dart';

@riverpod
class CitiesState extends _$CitiesState {
  @override
  Future<List<City>> build() => loadData();

  Future<List<City>> loadData() async {
    var data = getIt<LocalRepository>().loadCities();
    if (data.isEmpty) {
      data = await getIt<RemoteRepository>().loadCities();
      getIt<LocalRepository>().saveCities(data);
    }
    return data;
  }
}
