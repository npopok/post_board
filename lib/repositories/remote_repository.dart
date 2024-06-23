import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

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

    // TODO: Now working right now!!! Implement it using RPC
    final data = value.toJson();

    data.remove('id');
    data.remove('createdAt');
    data.remove('createdAgo');
    data.remove('createdBy');
    data.remove('city');
    data.remove('distance');
    data['city_id'] = value.city.id;

    await supabase.from(RepositorySettings.postsRemoteTable).insert(data);
  }

  Future<Posts> loadPosts(Filters filters, Posts? prev) async {
    await _checkUserAuth();

    const queryLimit = RepositorySettings.postsPageSize + 1;
    final pageKey = prev?.items.lastOrNull?.id ?? RepositorySettings.postsMaxId;

    final data = await supabase.rpc(
      'get_posts',
      params: {
        'p_city_id': filters.city.id,
        'p_category': filters.category.name,
        'p_gender': filters.gender.name,
        'p_age_min': filters.age.min,
        'p_age_max': filters.age.max,
        'p_location': locationLister.location.toString(),
        'p_distance': filters.distance!,
        'p_last_id': pageKey,
        'p_max_rows': queryLimit,
      },
    );

    final hasMore = data.length == queryLimit;
    if (hasMore) data.removeLast();

    final loaded = data.map<Post>((e) => Post.fromJson(e)).toList();
    final items = prev == null ? loaded : prev.items + loaded;

    return Posts(items: items, isFirst: prev == null, hasMore: hasMore);
  }

  Future<List<City>> loadCities() async {
    await _checkUserAuth();

    final data = await supabase
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
