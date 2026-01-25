import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return File(image.path);
  }

  Future<String> uploadProfileImage({
    required File image,
    required String uid,
  }) async {
    final supabase = Supabase.instance.client;

    final filePath = "users/$uid/profile.jpg";

    await supabase.storage.from('images').upload(
          filePath,
          image,
          fileOptions: const FileOptions(upsert: true),
        );

    final imageUrl =
        supabase.storage.from('images').getPublicUrl(filePath);

    // 🔥 cache bust
    return "$imageUrl?v=${DateTime.now().millisecondsSinceEpoch}";
  }
}
