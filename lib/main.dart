import 'Pages/map_main.dart';
import 'package:flutter/material.dart';
import 'Pages/exploring_page.dart';
import 'theme.dart';
import 'Pages/sign_up.dart';

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
  final List<Widget> _children = [ExploringMap(), MainMap()];

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
              Icons.location_city,
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit_location,
            ),
            title: Text(""),
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
