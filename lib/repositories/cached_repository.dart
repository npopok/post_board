import 'package:get_it/get_it.dart';

import 'package:post_board/models/models.dart';

import 'local_repository.dart';
import 'remote_repository.dart';

final cachedRepository = GetIt.I<CachedRepository>();

class CachedRepository {
  final LocalRepository local;
  final RemoteRepository remote;

  const CachedRepository({
    required this.local,
    required this.remote,
  });

  Future<void> saveProfile(Profile value) async {
    localRepository.saveProfile(value);
    if (value.isComplete) {
      await remoteRepository.saveProfile(value);
    }
  }

  Future<void> saveFilters(Filters value) async {
    localRepository.saveFilters(value);
    if (value.isComplete) {
      await remoteRepository.saveFilters(value);
    }
  }

  Future<List<City>> loadCities() async {
    var data = local.loadCities();
    if (data.isEmpty) {
      data = await remote.loadCities();
      local.saveCities(data);
    }
    return data;
  }
}
