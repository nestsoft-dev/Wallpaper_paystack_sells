import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../apply_wallpaper.dart';
import '../utils/routers.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  CollectionReference wallpaper =
      FirebaseFirestore.instance.collection("PurchasedWallpaper");

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 0, 85),
      body: FutureBuilder(
          future: wallpaper.doc(uid).collection("WallpaperImage").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No Wallpaper Currently Saved",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                );
              } else {
                final data = snapshot.data!.docs;
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, right: 3, left: 3),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.6,
                      children: List.generate(data.length, (index) {
                        final image = data[index];
                        return GestureDetector(
                          onTap: () {
                            nextpage(
                                context: context,
                                page: ApplyWallpaper(
                                  data: image,
                                  path: "saved",
                                ));
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image.get("wallpaper"))),
                            ),
                            child: Center(
                                child: image.get("price") == ""
                                    ? Text("")
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Text("\₦${image.get("price")}"),
                                      )),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
