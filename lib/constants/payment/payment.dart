import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../utils/save_purchased_wallpaper.dart';

class Makepayment {
  Makepayment({this.context, this.amount, this.image});

  BuildContext? context;
  String? email;
  String? amount;
  String? image;

  PaystackPlugin paystack = PaystackPlugin();
  final User? _user = FirebaseAuth.instance.currentUser;

  String getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'IOS';
    } else {
      platform = 'android';
    }
    return 'ChargedFrom$platform ${DateTime.now().millisecond}';
  }

  PaymentCard _getCardUi() {
    return PaymentCard(
        number: '',
        cvc: 'cvc',
        expiryMonth: 0,
        expiryYear: 0,
        country: '',
        name: _user!.displayName);
  }

  Future initializedPlugin() async {
    await paystack.initialize(
        publicKey: 'pk_live_38d76b1ddee93d31460e26747ae1ac39b0c534ec');
  }

  chargedCardAndMakePayment() async {
    final String price = amount!.replaceAll(',', '');
    initializedPlugin().then((_) async {
      Charge charge = Charge()
        ..amount = int.parse(price) * 100
        ..email = _user!.email
        ..currency = 'NGN'
        ..reference = getReference()
        ..card = _getCardUi();

      CheckoutResponse checkoutResponse = await paystack.checkout(context!,
          method: CheckoutMethod.card, fullscreen: false, charge: charge);

      final String message = checkoutResponse.message;
      if (checkoutResponse.status == true) {
        //generate receipt
        purchasedWallpaperProvide().save(WallpaperImage: image);

        //show snackBar
        print("Wallpaper Downloaded");
      } else {
        print("Something Went wrong");
      }
    });
  }
}
