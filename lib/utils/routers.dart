import 'package:flutter/cupertino.dart';

void nextpage({required Widget page, required BuildContext context}) {
  Navigator.push(context, CupertinoPageRoute(builder: (_) => page));
}

void nextpageonly({required Widget page, required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context, CupertinoPageRoute(builder: (_) => page), (route) => false);
}
