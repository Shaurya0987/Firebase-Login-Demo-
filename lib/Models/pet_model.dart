import 'package:cloud_firestore/cloud_firestore.dart';

class PetModel {
  final String name;
  final String animal;
  final int age;
  final Timestamp? createdAt;

  PetModel({
    required this.name,
    required this.animal,
    required this.age,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'animal': animal,
      'age': age,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
