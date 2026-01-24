import 'dart:io';

import 'package:firebaselogindemo/Firebase/Storage_DataBase.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final StorageDatabase service = StorageDatabase();

  File? selectedImage; // ✅ STORE IMAGE HERE
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload Images"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📸 PICK IMAGE
            ElevatedButton(
              onPressed: () async {
                final image = await service.pickImage();
                if (image != null) {
                  setState(() {
                    selectedImage = image;
                  });
                }
              },
              child: const Text("Choose Image"),
            ),

            const SizedBox(height: 10),

            // 👁 PREVIEW IMAGE
            if (selectedImage != null)
              Image.file(
                selectedImage!,
                height: 120,
              ),

            const SizedBox(height: 20),

            // ☁️ UPLOAD IMAGE
            ElevatedButton(
              onPressed: selectedImage == null
                  ? null
                  : () async {
                      imageUrl = await service.uploadImage(
                        imageFile: selectedImage!,
                        fileName: "101", // product id
                      );

                      print("Uploaded Image URL: $imageUrl");
                    },
              child: const Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
