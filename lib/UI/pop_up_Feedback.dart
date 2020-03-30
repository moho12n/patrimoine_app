import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:ui' show ImageFilter;
import 'dart:async';
import 'dart:io';
//import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patrimoine_app/Models/feedbackModel.dart';
import 'package:patrimoine_app/State/UserOnline.dart';
import 'package:patrimoine_app/controllers/postFeedbackController.dart';
import 'package:patrimoine_app/theme.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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
        width: MediaQuery.of(context).size.width - 70,
        height: 340,
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
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
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
  /*showDialog(context: context, child: alert,);
  Navigator.of(context).push(
    PageRouteBuilder(
        pageBuilder: (context, _, __) => alert, opaque: false),
  );*/
}

//---------
class Dialog extends StatefulWidget {
  Dialog(this.markerId);
  final markerId;
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
                //color: Colors.white10,
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
                      "PARTAGE TON AVIS AVEC LES AUTRES !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff353535),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StarRating(
                          size: 22.0,
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
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText:
                                "Que veux-tu dire à propos de ce lieu ? ",
                            labelStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              color: Color(0xff686868),
                            ),
                            hintText: "...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)))),
                    SizedBox(
                      height: 12.0,
                    ),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: loadAssets,
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
                      mainAxisSize: MainAxisSize.max,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 0, left: 10),
                          //flex: 2,
                          child: FlatButton(
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
                            color: Colors.transparent,
                            child: Text(
                              "ANNULER",
                              style: TextStyle(
                                  color: ThemeColors.greyDark,
                                  fontFamily: 'Lora',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width -
                                  155 -
                                  168),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () async {
                              var feedback = FeedbackModel(
                                "hfalk",
                                UserOnline.user.name,
                                UserOnline.user.age,
                                UserOnline.user.adress,
                                UserOnline.user.gender,
                                "5",
                                widget.markerId,
                              );
                              print("feedback page" + feedback.toString());
                              await makePostAddFeedback(feedback, images);
                              Navigator.pop(
                                context,
                              );
                            },
                            color: Color(0xff05A187),
                            child: Text(
                              "CONFIRMER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Lora',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
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
              title: Text(
                "Veuillez choisir la source de l'image",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff686868),
                ),
              ),
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

  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
}
