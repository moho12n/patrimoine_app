import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:ui' show ImageFilter;
import 'dart:async';
import 'dart:io';
//import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patrimoine_app/Models/imageModel.dart';
import 'package:patrimoine_app/controllers/avisController.dart';
import 'package:patrimoine_app/controllers/imageController.dart';
import 'package:patrimoine_app/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './pop_up_ViewImage.dart';
import 'package:fluttertoast/fluttertoast.dart';

//------------------ POP UP --------------------//
bool parcourue = false;

class MyDialog2 extends StatelessWidget {
  const MyDialog2({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MyPopupSurface2(
          child: child,
        ),
      ),
    );
  }
}

class MyPopupSurface2 extends StatelessWidget {
  const MyPopupSurface2({
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
class Dialog2 extends StatefulWidget {
  final String markerId;

  const Dialog2(this.markerId);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<Dialog2> {
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
    parcourue = false;
    _tiles.clear();
    _staggeredTiles.clear();
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _children = [Text(""), Text("")];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return MyDialog2(
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
                child: Scaffold(
                  backgroundColor: Color(0xffffffff).withOpacity(0.10),
                  body: _currentIndex == 0
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                              flex: 1,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "CE QU'EN PENSENT LES AUTRES",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                    flex: 2,
                                  ),
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
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: FutureBuilder(
                                  future: makeGetRequestAvis(widget.markerId),
                                  builder: (context, snapshot) {
                                    return snapshot.data != null
                                        ? ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    Divider(),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 34),
                                                child: Container(
                                                    child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            snapshot.data[index]
                                                                .nomUtilisateur,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          flex: 0,
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(),
                                                          flex: 1,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            snapshot.data[index]
                                                                .date
                                                                .toString()
                                                                .substring(
                                                                    0, 10),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff969494),
                                                            ),
                                                          ),
                                                          flex: 0,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        snapshot.data[index]
                                                            .commentaire,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff969494),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                )),
                                              );
                                            })
                                        : Center(
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.white),
                                          );
                                  }),
                            ),
                          ],
                        )
                      : FutureBuilder(
                          future: makeGetRequestImages(widget.markerId),
                          builder: (context, snapshot) {
                            print("parcourue " + parcourue.toString());
                            print("tiles par "+ _tiles.toString());
                            if (snapshot.data != null && parcourue == false) {
                              snapshot.data.forEach((e) {
                                parcourue = true;
                                print("snapshot" + e.toString());
                                _tiles.add(_ImageTile(
                                    "https://tourathi-dz.com/storage/app/public/" +
                                        e.image,
                                    widget.markerId));
                                print(_tiles.toString());
                                _staggeredTiles.add(StaggeredTile.count(2, 1));
                              });
                            }

                            return snapshot != null
                                ? Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                        Expanded(
                                          child: SizedBox(),
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(children: <Widget>[
                                              Expanded(
                                                child: SizedBox(),
                                                flex: 2,
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: Text(
                                                  "VOIR LES PHOTOS PARTAGEES",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                                flex: 2,
                                              ),
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
                                            ])),
                                        Expanded(
                                          child: ImageTile(widget.markerId),
                                          flex: 10,
                                        )
                                      ])
                                : Center(
                                    child: CircularProgressIndicator(
                                        backgroundColor: Colors.white),
                                  );
                          }),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    selectedItemColor: ThemeColors.Green,
                    unselectedItemColor: Colors.black38,
                    onTap: onTabTapped,
                    currentIndex: _currentIndex,
                    //selectedFontSize: 0,
                    iconSize: 30,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.feedback,
                        ),
                        title: Text("Avis"),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.photo,
                        ),
                        title: Text("Photos"),
                      ),
                    ],
                  ),
                ),
              )));
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

List<Widget> _tiles = List<Widget>();
List<StaggeredTile> _staggeredTiles = List<StaggeredTile>();

class ImageTile extends StatefulWidget {
  final String idMarker;
  const ImageTile(this.idMarker);

  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  List<ImageModel> imageList = List<ImageModel>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: StaggeredGridView.count(
        crossAxisCount: 4,
        staggeredTiles: _staggeredTiles,
        children: _tiles,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    ));
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.gridImage, this.markerId);
  final markerId;
  final gridImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0x00000000),
      elevation: 3.0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, _, __) => Dialog3(markerId,gridImage), opaque: false),
          );
        },
        child: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(gridImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(const Radius.circular(10.0)),
        )),
      ),
    );
  }
}
