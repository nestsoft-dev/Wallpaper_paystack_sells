import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class purchasedWallpaperProvide {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void save({required String? WallpaperImage}) async {
    CollectionReference _product = _firestore.collection("PurchasedWallpaper");

    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      Map<String, dynamic> data = <String, dynamic>{
        "price": '',
        'uid': uid,
        "wallpaper": WallpaperImage
      };
      _product.doc(uid).collection("WallpaperImage").add(data);
    } catch (e) {
      print(e);
    }
  }
}
