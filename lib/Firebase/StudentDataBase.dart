import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogindemo/Models/Student_Model.dart';

class StudentDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createStudent(
    String collName,
    String docId,
    StudentModel student,
  ) async {
    try {
      await _firestore.collection(collName).doc(docId).set({
        ...student.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Student Created");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateStudent(
    String collName,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collName).doc(docId).update(data);
      print("Student Updated");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteStudent(String collName, String docId) async {
    try {
      await _firestore.collection(collName).doc(docId).delete();
      print("Student Deleted");
    } catch (e) {
      print("Error: $e");
    }
  }
}
