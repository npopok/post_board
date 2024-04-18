import 'package:cloud_firestore/cloud_firestore.dart';

class CloudRepository {
  const CloudRepository();

  Future<void> saveObject(String path, Map<String, dynamic> value) async {
    final collection = FirebaseFirestore.instance.collection(path);
    await collection.add(value);
  }

  // Future<T?> loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson) async {
  //   String? userId = FirebaseAuth.instance.currentUser?.uid;
  //   if (userId == null) return null;

  //   final doc = await FirebaseFirestore.instance.doc('users/$userId').get();
  //   final data = doc.data()?[key];

  //   return data != null ? fromJson(data) : null;
  // }
}
