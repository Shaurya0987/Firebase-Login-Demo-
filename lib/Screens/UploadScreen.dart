import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebaselogindemo/Firebase/Image_Database.dart';
import 'package:firebaselogindemo/Supabase/Storage_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final UserDatabase userDatabase = UserDatabase();
  final SupabaseStorageService supabase = SupabaseStorageService();

  File? selectedImage;
  bool isLoading = false;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile Setup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🔵 SERVER IMAGE (REAL SOURCE)
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('profiles')
                    .doc(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 40),
                    );
                  }

                  final data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final imageUrl = data['profilePic'];

                  if (imageUrl == null || imageUrl.isEmpty) {
                    return const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 40),
                    );
                  }

                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(imageUrl),
                  );
                },
              ),

              const SizedBox(height: 16),

              // 📸 LOCAL PREVIEW (ONLY BEFORE UPLOAD)
              if (selectedImage != null)
                Image.file(selectedImage!, height: 100),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  final image = await supabase.pickImage();
                  if (image != null) {
                    setState(() {
                      selectedImage = image;
                    });
                  }
                },
                child: const Text("Choose Image"),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: "Name"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter name" : null,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: emailController,
                decoration:
                    const InputDecoration(labelText: "Email"),
                validator: (v) =>
                    v == null || !v.contains('@') ? "Enter email" : null,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;

                        setState(() => isLoading = true);

                        try {
                          String? imageUrl;

                          if (selectedImage != null) {
                            imageUrl =
                                await supabase.uploadProfileImage(
                              image: selectedImage!,
                              uid: uid,
                            );
                          }

                          await userDatabase.updateUser(uid, {
                            "name": nameController.text.trim(),
                            "email": emailController.text.trim(),
                            if (imageUrl != null)
                              "profilePic": imageUrl,
                          });

                          setState(() {
                            selectedImage = null;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Profile updated")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }

                        setState(() => isLoading = false);
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Save Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
