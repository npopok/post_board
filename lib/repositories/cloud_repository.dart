import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class CloudRepository {
  final supabase = Supabase.instance.client;

  Future<void> savePost(Post post) async {
    await supabase.from(kPostsCloudTable).insert(post.toJson());
  }

  Future<List<Post>> loadPosts(Filter filter) async {
    final data = await supabase
        .from(kPostsCloudTable)
        .select()
        .eq('category', filter.category.name)
        .eq('gender', filter.gender.name)
        .gte('age', filter.age.min)
        .lte('age', filter.age.max)
        .order('created_at')
        .limit(kPostMaxCount);

    return data.map((e) => Post.fromJson(e)).toList();
  }
}
