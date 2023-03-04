import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ns_wallpaper_paystack/utils/routers.dart';

import '../auth/auth_page.dart';
import '../register_screen.dart';
import 'main_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
     if(auth.currentUser == null){
       nextpageonly(context: context, page: Register());
     }else{
       nextpageonly(context: context, page: MyHomePage());
     }
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 0, 85),
      body: Center(
        child:Container(
                          height: 100,
                          width: 150,
                          child: Image.asset('assets/nsicon.png'),
                        ),
      ),
    );
  }
}
