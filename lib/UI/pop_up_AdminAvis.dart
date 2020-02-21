import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:ui' show ImageFilter;

//import 'package:image_picker_modern/image_picker_modern.dart';
//------------------ POP UP --------------------//

class MyAdminDialog extends StatelessWidget {
  const MyAdminDialog({
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
        borderRadius: BorderRadius.circular(30),
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
class MyAdminDialog2 extends StatefulWidget {
  final String title;
  final String subTitle;
  final String type;
  final String description;
  const MyAdminDialog2({Key key, this.title,this.description,this.subTitle,this.type}): super(key: key);
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyAdminDialog2> {
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
      return MyAdminDialog(
          child: Material(
              type: MaterialType.transparency,
              child: AnimatedContainer(
                  curve: Curves.ease,
                  duration: Duration(
                    milliseconds: 400,
                  ),
                  width: MediaQuery.of(context).size.width - 60,
                  height: 400,
                  padding: const EdgeInsets.all(0),
                  alignment: childAlignment,
                  child: Scaffold(
                      backgroundColor: Color(0xffffffff).withOpacity(0.10),
                      body: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child: Container(
                              alignment: Alignment.topRight,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                             widget.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff313030),
                              ),
                            )),
                          ),
                          Expanded(
                            flex: 0,
                            child: Text(
                              widget.subTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: Color(0xff313030),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              widget.type,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: Color(0xff313030),
                              ),
                            )),
                          ),
                          Expanded(
                              flex: 8,
                              child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        widget.description,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Color(0xff313030),
                                        ),
                                      ),
                                    ],
                                  ))),
                        ],
                      )))));
    });
  }
}
