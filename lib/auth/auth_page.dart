import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ns_wallpaper_paystack/utils/routers.dart';

import '../screens/main_page.dart';
import '../utils/authenticator.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 0, 85),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Authenticatication().signInWithGoogle().then((value) {
              nextpageonly(page: MyHomePage(), context: context);
            }).catchError((e) {
              print(e.toString());
            });
          },
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "SignIn with Google",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.person,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
