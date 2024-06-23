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

  Future<void> savePost(Post post) async {
    await _checkUserAuth();

    await supabase.rpc(RepositorySettings.functionAddPost, params: {
      'p_author': post.author,
      'p_gender': post.gender.name,
      'p_age': post.age,
      'p_city_id': post.city.id,
      'p_contact': post.contact.toString(),
      'p_category': post.category.name,
      'p_text': post.text,
      'p_location': locationLister.location.toString(),
    });
  }

  Future<Posts> loadPosts(Filters filters, Posts? prev) async {
    await _checkUserAuth();

    const queryLimit = RepositorySettings.postsPageSize + 1;
    final pageKey = prev?.items.lastOrNull?.id ?? RepositorySettings.postsMaxId;

    final data = await supabase.rpc(
      RepositorySettings.functionGetPosts,
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
