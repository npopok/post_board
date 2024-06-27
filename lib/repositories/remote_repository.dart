import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class RemoteRepository {
  final supabase = Supabase.instance.client;

  Future<void> saveProfile(Profile profile) async {
    await _checkUserAuth();

    await supabase.rpc(RepositorySettings.functionStoreProfile, params: {
      'p_user_id': supabase.auth.currentUser!.id,
      'p_name': profile.name,
      'p_gender': profile.gender.name,
      'p_age': profile.age,
      'p_city_id': profile.city.id,
      'p_contact': profile.contact.toString(),
    });
  }

  Future<void> saveFilters(Filters filters) async {
    await _checkUserAuth();

    // TODO: Clean old schema (age as range etc.) in DB after full migraton to 0.3.0
    await supabase.rpc(RepositorySettings.functionStoreFilters, params: {
      'p_user_id': supabase.auth.currentUser!.id,
      'p_category': filters.category.name,
      'p_gender': filters.gender.name,
      'p_age_min': filters.age.min,
      'p_age_max': filters.age.max,
      'p_city_id': filters.city.id,
      'p_distance': filters.distance!,
    });
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

    // TODO: Migration to 0.4.0: Remove distance from DB result
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

    final data = await supabase.rpc(RepositorySettings.functionGetCities);
    return data.map<City>((e) => City.fromJson(e)).toList();
  }

  Future<void> _checkUserAuth() async {
    if (Supabase.instance.client.auth.currentUser == null) {
      await Supabase.instance.client.auth.signInAnonymously();
    }
  }
}
