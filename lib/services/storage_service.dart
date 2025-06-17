import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfilePhoto(String userId, File file) async {
    try {
      final ref = _storage.ref().child('profile_photos').child('$userId.jpg');
      final uploadTask = await ref.putFile(file);
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading profile photo: $e');
      return null;
    }
  }
}
