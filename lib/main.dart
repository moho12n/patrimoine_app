import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patrimoine_app/Pages/sign_up.dart';

import 'Pages/map_main.dart';
import 'package:flutter/material.dart';
import 'Pages/exploring_page.dart';
import 'theme.dart';
import 'Pages/adminMap_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
      home: SignUpFirstPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(unselectedWidgetColor: Colors.black),
    ));
/*void main() {
  runApp(RoutesWidget());
}
*/
//********declaration */
BuildContext contextGlobal;
final scaffoldkey = GlobalKey<ScaffoldState>();
int indexGlobal;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  int _currentIndex = 0;
  final List<Widget> _children = [AdminMap(), ExploringMap(), MainMap()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: Container(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: ThemeColors.Green,
        unselectedItemColor: Colors.black38,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedFontSize: 0,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            title: Text("ُExploring MAP"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_city,
            ),
            title: Text("MainMap"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit_location,
            ),
            title: Text("AdminMap"),
          ),
        ],
      ),
    );
  }
//--------- UI

//--------------------- Methods

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      indexGlobal = index;
    });
  }

  int getCurrentIndex() {
    return _currentIndex;
  }
}
