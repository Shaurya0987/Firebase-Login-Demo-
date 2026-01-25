import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogindemo/Models/user_Model.dart';

class UserDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create user profile
  Future<void> createUser(String uid, UserModel user) async {
    try {
      await _firestore.collection('profiles').doc(uid).set({
        ...user.toJson(),
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Create User Error: $e");
    }
  }

  /// Update user profile (partial update)
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('profiles').doc(uid).set(
      {
        ...data,
        "updatedAt": FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  /// Delete user profile
  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('profiles').doc(uid).delete();
    } catch (e) {
      print("Delete User Error: $e");
    }
  }
}
