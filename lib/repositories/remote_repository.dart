import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/helpers/helpers.dart';

final remoteRepository = GetIt.I<RemoteRepository>();

class RemoteRepository {
  final supabase = Supabase.instance.client;

  Future<void> saveProfile(Profile value) async {
    await _checkUserAuth();

    final data = value.toJson();

    data.remove('city');
    data['city_id'] = value.city.id;

    final rowId = await supabase
        .from(RepositorySettings.profilesRemoteTable)
        .select('id')
        .eq('created_by', supabase.auth.currentUser!.id)
        .maybeSingle();
    if (rowId != null) data['id'] = rowId['id'];

    await supabase.from(RepositorySettings.profilesRemoteTable).upsert(data);
  }

  Future<void> saveFilters(Filters value) async {
    await _checkUserAuth();

    final data = value.toJson();

    data.remove('city');
    data['city_id'] = value.city.id;

    final rowId = await supabase
        .from(RepositorySettings.filtersRemoteTable)
        .select('id')
        .eq('created_by', supabase.auth.currentUser!.id)
        .maybeSingle();
    if (rowId != null) data['id'] = rowId['id'];

    await supabase.from(RepositorySettings.filtersRemoteTable).upsert(data);
  }

  Future<void> savePost(Post value) async {
    await _checkUserAuth();

    final data = value.toJson();

    data.remove('id');
    data.remove('createdAt');
    data.remove('createdAgo');
    data.remove('createdBy');
    data.remove('city');
    data['city_id'] = value.city.id;

    await supabase.from(RepositorySettings.postsRemoteTable).insert(data);
  }

  Future<Posts> loadPosts(Filters filters, Posts? prev) async {
    await _checkUserAuth();

    const queryLimit = RepositorySettings.postsPageSize + 1;
    final pageKey = prev?.items.lastOrNull?.id ?? RepositorySettings.postsMaxId;

    final st = Stopwatch()..start();

    final data = await supabase
        .from(RepositorySettings.postsRemoteTable)
        .select(
          '*, createdAt:created_at, createdBy:created_by,'
          'city:cities(*, region:regions(*, country:countries(*)))',
        )
        .lt('id', pageKey)
        .eq('city_id', filters.city.id)
        .eq('category', filters.category.name)
        .eq('gender', filters.gender.name)
        .gte('age', filters.age.min)
        .lte('age', filters.age.max)
        .order('created_at')
        .order('id')
        .limit(queryLimit);

    for (final row in data) {
      row['createdAgo'] = DateTime.parse(row['createdAt']).timeSinceNow();
    }

    final hasMore = data.length == queryLimit;
    if (data.isNotEmpty) data.removeLast();

    final loaded = data.map((e) => Post.fromJson(e)).toList();
    final items = prev == null ? loaded : prev.items + loaded;

    //   await Future.delayed(Duration(seconds: 5)); // TODO
    print('Load DB: pageKey = $pageKey, hasMore = $hasMore, category = ${filters.category},'
        'records = ${data.length}, total = ${items.length}');
    if (loaded.isNotEmpty) print('     nextPageKey = ${loaded.last.id}');
    st.stop();
    print('      Execution time: ${st.elapsedMilliseconds}ms');

    return Posts(items: items, isFirst: prev == null, hasMore: hasMore);
  }

  Future<List<City>> loadCities() async {
    await _checkUserAuth();

    var data = await supabase
        .from(RepositorySettings.citiesRemoteTable)
        .select('*, region:regions(*, country:countries(*))')
        .order('name', ascending: true);

    return data.map((e) => City.fromJson(e)).toList();
  }

  Future<void> _checkUserAuth() async {
    if (Supabase.instance.client.auth.currentUser == null) {
      await Supabase.instance.client.auth.signInAnonymously();
    }
  }
}
