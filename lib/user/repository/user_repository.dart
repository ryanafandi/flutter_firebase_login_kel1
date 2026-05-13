import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser({required String email}) async {
    await _firestore.collection('users').doc(email).set({
      'email': email,

      'created_at': DateTime.now(),
    });
  }

  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> updateUser({
    required String email,
    required String newEmail,
  }) async {
    await _firestore.collection('users').doc(email).update({'email': newEmail});
  }

  Future<void> deleteUser({required String email}) async {
    await _firestore.collection('users').doc(email).delete();
  }
}