// import 'package:cloud_firestore/cloud_firestore.dart';

// class CrudFunctions {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> createData(
//     String collectionName,
//     String docId,
//     String name,
//     String animal,
//     int age,
//   ) async {
//     try {
//       await _firestore.collection(collectionName).doc(docId).set({
//         'name': name,
//         'animal': animal,
//         'age': age,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       print("✅ Data Created");
//     } catch (e) {
//       print("❌ Create Error: $e");
//     }
//   }

//   Future<void> updateData(
//     String collectionName,
//     String docId,
//     String field,
//     dynamic newValue,
//   ) async {
//     try {
//       await _firestore.collection(collectionName).doc(docId).update({
//         field: newValue,
//       });

//       print("✅ Data Updated");
//     } catch (e) {
//       print("❌ Update Error: $e");
//     }
//   }

//   Future<void> deleteData(String collectionName, String docId) async {
//     try {
//       await _firestore.collection(collectionName).doc(docId).delete();

//       print("✅ Document Deleted");
//     } catch (e) {
//       print("❌ Delete Error: $e");
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogindemo/Models/pet_model.dart';

class CrudFunctions {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ CREATE using MODEL
  Future<void> createPet(String collectionName, String docId, PetModel pet) async {
    try {
      await _firestore.collection(collectionName).doc(docId).set({
        ...pet.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("✅ Data Created");
    } catch (e) {
      print("❌ Create Error: $e");
    }
  }

  // ✅ UPDATE using MAP (multiple fields at once)
  Future<void> updatePet(
    String collectionName,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collectionName).doc(docId).update(data);
      print("✅ Data Updated");
    } catch (e) {
      print("❌ Update Error: $e");
    }
  }

  // ✅ DELETE (no change needed)
  Future<void> deletePet(String collectionName, String docId) async {
    try {
      await _firestore.collection(collectionName).doc(docId).delete();
      print("✅ Document Deleted");
    } catch (e) {
      print("❌ Delete Error: $e");
    }
  }
}
