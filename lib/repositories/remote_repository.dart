import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

final remoteRepository = GetIt.I<RemoteRepository>();

class RemoteRepository {
  final supabase = Supabase.instance.client;

  Future<void> saveProfile(Profile value) async {
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
    final data = value.toJson();

    data.remove('id');
    data.remove('createdAt');
    data.remove('createdBy');
    data.remove('city');
    data['city_id'] = value.city.id;

    await supabase.from(RepositorySettings.postsRemoteTable).insert(data);
  }

  Future<List<Post>> loadPosts(Filters filters) async {
    final data = await supabase
        .from(RepositorySettings.postsRemoteTable)
        .select(
          '*, createdAt:created_at, createdBy:created_by,'
          'city:cities(*, region:regions(*, country:countries(*)))',
        )
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
        .select('*, region:regions(*, country:countries(*))')
        .order('name', ascending: true);

    return data.map((e) => City.fromJson(e)).toList();
  }
}
