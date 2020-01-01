import 'package:patrimoine_app/Pages/sign_up.dart';

import 'Pages/map_main.dart';
import 'package:flutter/material.dart';
import 'Pages/exploring_page.dart';
import 'example.dart';
import 'theme.dart';

void main() => runApp(MaterialApp(
      home: SignUpFirstPage(),
      theme: ThemeData(unselectedWidgetColor: Colors.white70),
    ));
/*void main() {
  runApp(RoutesWidget());
}
*/
BuildContext contextGlobal;
final scaffoldkey = GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _children = [ExploringMap(), MainMap(), Text("Profile")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: Container(
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
            icon: Icon(Icons.account_balance),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            title: Text('Main'),
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
