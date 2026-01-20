import 'package:cloud_firestore/cloud_firestore.dart';

class CrudFunctions {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<void> createData(
  String collectionName,
  String docId,
  String name,
  String animal,
  int age,
) async {
  try {
    await _firestore.collection(collectionName).doc(docId).set({
      'name': name,
      'animal': animal,
      'age': age,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print("✅ Data Created");
  } catch (e) {
    print("❌ Create Error: $e");
  }
}

Future<List<Map<String, dynamic>>> readOnce(
    String collectionName) async {
  try {
    QuerySnapshot snapshot =
        await _firestore.collection(collectionName).get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  } catch (e) {
    print("❌ Read Error: $e");
    return [];
  }
}

Future<void> updateData(
   String collectionName,
   String docId,
   String field,
   dynamic newValue,
) async {
  try {
    await _firestore
        .collection(collectionName)
        .doc(docId)
        .update({
      field: newValue,
    });

    print("✅ Data Updated");
  } catch (e) {
    print("❌ Update Error: $e");
  }
}

Future<void> deleteData(
  String collectionName,
  String docId,
) async {
  try {
    await _firestore
        .collection(collectionName)
        .doc(docId)
        .delete();

    print("✅ Document Deleted");
  } catch (e) {
    print("❌ Delete Error: $e");
  }
}

}