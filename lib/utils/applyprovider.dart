import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:ns_wallpaper_paystack/utils/save_purchased_wallpaper.dart';

import 'convert_url_to_file.dart';

class Applyprovider extends ChangeNotifier {
  String _message = "";
  bool _status = false;

  String get message => _message;
  bool get status => _status;

  void apply(String? image, int? location, String? path) async {
    _status = true;
    notifyListeners();

    try {
      final file = await convertFile(image!);
      await WallpaperManager.setWallpaperFromFile(file.path, location!);

      if (path != "saved") {
        purchasedWallpaperProvide().save(WallpaperImage: image);
      }
      _status = false;
      _message = "Applied";
      notifyListeners();
    } catch (e) {
      _status = false;
      _message = "error occurred";
      notifyListeners();
    }
  }
}
