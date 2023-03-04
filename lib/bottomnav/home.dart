import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ns_wallpaper_paystack/utils/routers.dart';

import '../apply_wallpaper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference wallpaper =
      FirebaseFirestore.instance.collection("Allwallpapers");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 0, 85),
      body: FutureBuilder(
          future: wallpaper.get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No Wallpaper Currently Available"),
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
