import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PhotoService {
  static Future<String?> uploadPhoto(String id, File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final photoRef = storageRef.child(id);

      await photoRef.putFile(image);
      String photoUrl = await photoRef.getDownloadURL();

      return photoUrl;
    } catch (e) {
      print('UPLOAD PHOTO ERROR $e');
    }
  }
}
