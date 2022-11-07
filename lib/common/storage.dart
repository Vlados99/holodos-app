import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static Future<String> getImage(String dir, String imgName) async {
    final ref = FirebaseStorage.instance.ref(dir).child(imgName);

    var url = await ref.getDownloadURL();

    return url;
  }
}
