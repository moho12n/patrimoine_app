
import 'Pages/map_main.dart';
import 'package:flutter/material.dart';
import 'Pages/exploring_page.dart';
void main() => runApp(MaterialApp(home: MyApp()));

BuildContext contextGlobal;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ExploringMap(),
    MainMap(),
    Text("Profile")
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance),
            title: new Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_location),
            title: new Text('Main'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
//--------- UI 
 
//--------------------- Methods
 
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
