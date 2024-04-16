import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudRepository {
  const CloudRepository();

  Future<void> saveObject(String key, Map<String, dynamic> value) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final doc = await FirebaseFirestore.instance.doc('users/$userId').get();
    final ref = doc.reference;
    doc.exists ? ref.update({key: value}) : ref.set({key: value});
  }

  Future<T?> loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;

    final doc = await FirebaseFirestore.instance.doc('users/$userId').get();
    final data = doc.data()?[key];

    return data != null ? fromJson(data) : null;
  }
}
