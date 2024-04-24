import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/post.dart';

class CloudRepository {
  const CloudRepository();

  Future<void> savePost(Post post) async {
    final collection = FirebaseFirestore.instance.collection(kPostsCloudKey);
    await collection.add(post.toJson());
  }

  Future<List<Post>> loadPosts(Category category) async {
    final collection = FirebaseFirestore.instance.collection(kPostsCloudKey);
    final snapshot = await collection
        .where('category', isEqualTo: category.name)
        .orderBy('timestamp', descending: true)
        .limit(kMaxPostCount)
        .get();
    return snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList();
  }
}
