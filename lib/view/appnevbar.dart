import 'package:bhojapurimovie/view/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewcontroller/bottomnavitorbarprovider.dart';
import 'SearchScreen.dart';
import 'homescreen.dart';


class appnevbar extends StatelessWidget {
   appnevbar({super.key});


  final List<Widget> screens = [
    Homescreen(),
    Searchscreen(),
    Settingscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavitor>(
      builder: (context, value, child) {
        return Scaffold(
          body: screens[value.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: value.currentindex,
            onTap: value.selectedscreenChange,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Setting"),
            ],
          ),
        );
      },
    );

  }
}
