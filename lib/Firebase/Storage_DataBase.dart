import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageDatabase {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // 📸 PICK IMAGE FROM GALLERY
  Future<File?> pickImage() async {
    final XFile? image =
      await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    print("Image Picked");

    return File(image.path);
  }

  // ☁️ UPLOAD IMAGE TO FIREBASE STORAGE
  Future<String?> uploadImage({required File imageFile,required String fileName,}) async {
    try {
      final ref =
          _storage.ref().child("products/$fileName.jpg");

      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("Image Uploaded");

      return downloadUrl;
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }
}
