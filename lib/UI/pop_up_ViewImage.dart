import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:ui' show ImageFilter;
import 'dart:async';
import 'dart:io';
//import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patrimoine_app/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//------------------ POP UP --------------------//

class MyDialog3 extends StatelessWidget {
  const MyDialog3({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MyPopupSurface3(
          child: child,
        ),
      ),
    );
  }
}

class MyPopupSurface3 extends StatelessWidget {
  const MyPopupSurface3({
    Key key,
    this.isSurfacePainted = true,
    this.child,
  }) : super(key: key);

  final bool isSurfacePainted;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(00),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              backgroundBlendMode: BlendMode.overlay,
            ),
            child: Container(
              color: Color(0xffffffff).withOpacity(0.90),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

//---------
class Dialog3 extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<Dialog3> {
  Alignment childAlignment = Alignment.center;
  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        // Add state updating code
        setState(() {
          childAlignment = visible ? Alignment.topCenter : Alignment.center;
        });
      },
    );
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _children = [Text(""), Text("")];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return MyDialog3(
          child: Material(
              type: MaterialType.transparency,
              child: AnimatedContainer(
                curve: Curves.ease,
                duration: Duration(
                  milliseconds: 400,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(0),
                alignment: childAlignment,
                child: Text(""),
              )));
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}