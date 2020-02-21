import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Pages/map_main.dart';
import 'package:flutter/material.dart';
import 'Pages/exploring_page.dart';
import 'theme.dart';
import 'dart:async';
import 'Pages/adminMap_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
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

  
  @override
  void initState() {

    Firestore.instance.collection('markers')
  .snapshots()
  .listen((QuerySnapshot querySnapshot){
    querySnapshot.documents.forEach((document) => print(document));
  }
);
    _getThingsOnStartup().then((value){
      print('Async done');
    });
    super.initState();
  }
  Future _getThingsOnStartup() async {
    
    return StreamBuilder(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        print("hey");
        if (!snapshot.hasData) print("there is nothing");
        print(snapshot.data.documents.length.toString());
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          print(snapshot.data.documents[i]['coords']);
          adminMarkers.add(Marker(
            markerId: MarkerId(snapshot.data.hashCode.toString()),            
            position: LatLng(snapshot.data.documents[i]['coords'].latitude,
                  snapshot.data.documents[i]['coords'].longitude),
             ));
        }
  });
  }

  int _currentIndex = 0;
  final List<Widget> _children = [AdminMap(),ExploringMap(), MainMap()];

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
