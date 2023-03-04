import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:ns_wallpaper_paystack/utils/applyprovider.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'constants/payment/payment.dart';

class ApplyWallpaper extends StatefulWidget {
  ApplyWallpaper({super.key, this.data, this.path = ""});

  final QueryDocumentSnapshot<Object?>? data;
  final String? path;

  @override
  State<ApplyWallpaper> createState() => _ApplyWallpaperState();
}

class _ApplyWallpaperState extends State<ApplyWallpaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
            widget.data!.get("wallpaper"),
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  if (widget.data!.get("price") != "") {
                    //make payment
                    
                    Makepayment(
                            context: context,
                            amount: widget.data!.get("price"),
                            image: widget.data!.get('wallpaper'))
                        .chargedCardAndMakePayment();
                        
                  } else {
                    //showModel();
                    print("hello");
                    print(widget.data!.get("wallpaper").toString());

                    List<String> applyText = [
                      'Home Screen',
                      'Lock Screen',
                      'Both'
                    ];
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 250,
                            child: Consumer<Applyprovider>(
                              builder: (context, applyprovider, child) {
                                WidgetsBinding.instance!.addPostFrameCallback(
                                  (timeStamp) {
                                    if (applyprovider.message != "") {
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(applyprovider.status == true
                                          ? 'Please waiting...Applying'
                                          : "Apply"),
                                    ),
                                    ...List.generate(applyText.length, (index) {
                                      final data = applyText[index];
                                      return GestureDetector(
                                        onTap: () {
                                          final image =
                                              widget.data!.get('wallpaper');
                                          switch (index) {
                                            case 0:
                                              applyprovider.apply(
                                                  image,
                                                  WallpaperManager.HOME_SCREEN,
                                                  widget.path);
                                              break;
                                            case 1:
                                              applyprovider.apply(
                                                  image,
                                                  WallpaperManager.LOCK_SCREEN,
                                                  widget.path);
                                              break;
                                            case 2:
                                              applyprovider.apply(
                                                  image,
                                                  WallpaperManager.BOTH_SCREEN,
                                                  widget.path);
                                              break;
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.white,
                                          ),
                                          child: Text(data),
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              },
                            ),
                          );
                        });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Text(
                      widget.data!.get("price") == "" ? "Apply" : "Purchase",
                      style: TextStyle()),
                ),
              )),
        ],
      ),
    );
  }

  void showModel() {
    List<String> applyText = ['Home Screen', 'Lock Screen', 'Both'];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: Consumer<Applyprovider>(
              builder: (context, applyprovider, child) {
                WidgetsBinding.instance!.addPostFrameCallback(
                  (timeStamp) {
                    if (applyprovider.message != "") {
                      Navigator.pop(context);
                    }
                  },
                );
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(applyprovider.status == true
                          ? 'Please waiting...Applying'
                          : "Apply"),
                    ),
                    ...List.generate(applyText.length, (index) {
                      final data = applyText[index];
                      return GestureDetector(
                        onTap: () {
                          final image = widget.data!.get('wallpaper');
                          switch (index) {
                            case 0:
                              applyprovider.apply(image,
                                  WallpaperManager.HOME_SCREEN, widget.path);
                              break;
                            case 1:
                              applyprovider.apply(image,
                                  WallpaperManager.LOCK_SCREEN, widget.path);
                              break;
                            case 2:
                              applyprovider.apply(image,
                                  WallpaperManager.BOTH_SCREEN, widget.path);
                              break;
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Text(data),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          );
        });
  }
}
