import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

final remoteRepository = GetIt.I<RemoteRepository>();

class RemoteRepository {
  final supabase = Supabase.instance.client;

  Future<void> savePost(Post post) async {
    await supabase.from(RepositorySettings.postsRemoteTable).insert(post.toJson());
  }

  Future<List<Post>> loadPosts(Filters filters) async {
    final data = await supabase
        .from(RepositorySettings.postsRemoteTable)
        .select()
        .eq('city_id', filters.city.id)
        .eq('category', filters.category.name)
        .eq('gender', filters.gender.name)
        .gte('age', filters.age.min)
        .lte('age', filters.age.max)
        .order('created_at')
        .limit(RepositorySettings.postMaxCount);

    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<City>> loadCities() async {
    var data = await supabase
        .from(RepositorySettings.citiesRemoteTable)
        .select('*, regions(name)')
        .order('name', ascending: true);

    for (final city in data) {
      city['region'] = city['regions']['name'];
    }

    return data.map((e) => City.fromJson(e)).toList();
  }
}
