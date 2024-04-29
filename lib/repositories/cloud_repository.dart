import 'package:post_board/common/common.dart';
import 'package:post_board/models/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CloudRepository {
  final supabase = Supabase.instance.client;

  Future<void> savePost(Post post) async {
    await supabase.from(kPostsCloudTable).insert(post.toJson());
  }

  Future<List<Post>> loadPosts(Category category) async {
    final data = await supabase
        .from(kPostsCloudTable)
        .select()
        .eq('category', category.name)
        .order('createdAt')
        .limit(kMaxPostCount);

    return data.map((e) => Post.fromJson(e)).toList();
  }
}
