import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:ui' show ImageFilter;
import 'dart:async';
import 'dart:io';
//import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:image_picker/image_picker.dart';
//------------------ POP UP --------------------//

class MyDialog extends StatelessWidget {
  const MyDialog({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        child: MyPopupSurface(
          child: child,
        ),
      ),
    );
  }
}

class MyPopupSurface extends StatelessWidget {
  const MyPopupSurface({
    Key key,
    this.isSurfacePainted = true,
    this.child,
  }) : super(key: key);

  final bool isSurfacePainted;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xfffcf4ed),
            backgroundBlendMode: BlendMode.overlay,
          ),
          child: Container(
            color: isSurfacePainted ? Colors.white : null,
            child: child,
          ),
        ),
      ),
    );
  }
}

void showOnTapMessage(BuildContext context) {
  var alert = Material(
      type: MaterialType.transparency,
      child: MyDialog(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),

              Text("data"),

              // FlutterRatingBar(
              //   initialRating: 3,
              //   fillColor: Colors.amber,
              //   borderColor: Colors.amber.withAlpha(50),
              //   allowHalfRating: true,
              //   onRatingUpdate: (rating) {
              //     print(rating);
              //   },
              // ),
            ],
          ),
        )
      ])));
  showDialog(context: context, child: alert);
}

//---------
class Dialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<Dialog> {
  File _pickedImage;

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

  double rating = 3.5;
  int starCount = 5;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return MyDialog(
          child: Material(
              type: MaterialType.transparency,
              child: AnimatedContainer(
                curve: Curves.ease,
                duration: Duration(
                  milliseconds: 400,
                ),
                width: double.infinity,
                height: 400,
                padding: const EdgeInsets.all(20),
                alignment: childAlignment,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Partagez votre Feedback ! ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        StarRating(
                          size: 35.0,
                          rating: rating,
                          color: Colors.orange,
                          borderColor: Colors.grey,
                          starCount: starCount,
                          onRatingChanged: (rating) => setState(
                            () {
                              this.rating = rating;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: "Partager votre avis",
                            hintText: "J'ai visité...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)))),
                    SizedBox(
                      height: 12.0,
                    ),
                    OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: _pickImage,
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Ajouter une photo  "),
                              Icon(Icons.add_a_photo),
                            ])),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: EdgeInsets.only(left: 23.0, right: 23.0),
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Text(
                            "ANNULER",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lora',
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Text(
                            "CONFIRMER",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lora',
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )));
    });
  }

  //----
  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Veuillez choisir la source de l'image"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallerie"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() => _pickedImage = file);
      }
    }
  }
}
