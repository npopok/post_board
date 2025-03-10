import 'package:flutter/foundation.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';

import 'local_repository.dart';
import 'remote_repository.dart';

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
      try {
        await remoteRepository.saveProfile(value);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> saveFilters(Filters value) async {
    localRepository.saveFilters(value);
    if (value.isComplete) {
      try {
        await remoteRepository.saveFilters(value);
      } catch (e) {
        debugPrint(e.toString());
      }
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
