import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/post.dart';

class CloudRepository {
  const CloudRepository();

  Future<void> savePost(Post post) async {
    final collection = FirebaseFirestore.instance.collection('posts');
    await collection.add(post.toJson());
  }

  Stream<List<Post>> loadPosts() {
    final collection = FirebaseFirestore.instance.collection('posts');
    return collection
        .limit(kMaxPostCount)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());
  }
}
