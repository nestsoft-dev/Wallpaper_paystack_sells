import 'package:flutter/material.dart';

import '../bottomnav/download_pages.dart';
import '../bottomnav/home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int pageIndex = 0;
List<Map> bottomvalue = [
  {'icons': Icons.home, 'title': 'Home'},
  {'icons': Icons.download, 'title': 'Download'},
];
List<Widget> pages = [
  HomePage(),
  Downloads()
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Wallpaper"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 55, 0, 150),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Color.fromARGB(255, 55, 0, 150),
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: List.generate(bottomvalue.length, (index) {
          final data = bottomvalue[index];
          return BottomNavigationBarItem(
              icon: Icon(data['icons'],color: Colors.grey,), label: data['title']);
        }),
        currentIndex: pageIndex,
      ),
    );
  }
}
