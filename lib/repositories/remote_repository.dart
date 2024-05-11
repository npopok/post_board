import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class RemoteRepository {
  final supabase = Supabase.instance.client;

  Future<void> savePost(Post post) async {
    await supabase.from(kPostsRemoteTable).insert(post.toJson());
  }

  Future<List<Post>> loadPosts(Filters filters) async {
    final data = await supabase
        .from(kPostsRemoteTable)
        .select()
        .eq('category', filters.category.name)
        .eq('gender', filters.gender.name)
        .gte('age', filters.age.min)
        .lte('age', filters.age.max)
        .order('created_at')
        .limit(kPostMaxCount);
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<City>> loadCities() async {
    var data = await supabase.from(kCitiesRemoteTable).select('*, regions(name)').order(
          'name',
          ascending: true,
        );
    for (final city in data) {
      city['region'] = city['regions']['name'];
    }
    return data.map((e) => City.fromJson(e)).toList();
  }
}
