import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patrimoine_app/UI/pop_up_Feedback.dart' as prefix0;
import 'dart:ui' show ImageFilter;
import '../theme.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import '../main.dart';
import '../UI/pop_up_Avis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patrimoine_app/UI/pop_up_AdminAvis.dart';

Set<Marker> adminMarkers = {};
BuildContext myAdminContext;
//****/
const kGoogleApiKey = "AIzaSyDgID5BLQ78GOQ9AMYPwvfk6CRffTCyGCI";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
//****/

class AdminMap extends StatefulWidget {
  AdminMap({
    Key key,
    this.parameter,
  }) : super(key: key);

  final parameter;

  @override
  _MyAdminMapWidgetState createState() => _MyAdminMapWidgetState();
}

class _MyAdminMapWidgetState extends State<AdminMap> {
  BitmapDescriptor pinLocationIcon;
  Uint8List markerIcon;
  @override
  void initState() {
    super.initState();
  }

 

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  static LatLng _center = const LatLng(36.737232, 3.086472);

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    myAdminContext = context;
    //****** */

    return StreamBuilder(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        Firestore.instance
            .collection('markers')
            .snapshots()
            .listen((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((document) {
            print ("Title: ${document.data['title']}, Latitude = ${document.data['latitude']}, longitude = ${document.data['longitude']} ");
            
            if ((document.data['longitude'] != null) && (document.data['latitude'] != null )  ){
            adminMarkers.add(Marker(
              draggable: false,
                icon: BitmapDescriptor.fromAsset("assets/icons/monument3.png"),
                onTap: () {
                  Navigator.of(myAdminContext).push(
                    PageRouteBuilder(
                        pageBuilder: (myAdminContext, _, __) => MyAdminDialog2(
                              title: document.data['title'],
                              subTitle: document.data['subTitle'],
                              description: document.data['description'],
                              type: document.data['type'],
                            ),
                        opaque: false),
                  );
                },
                markerId: MarkerId(document.data.hashCode.toString()),
                position: LatLng(
                    double.tryParse(document.data['latitude'].toString()),
                    double.tryParse(document.data['longitude'].toString()))));}
          });
        });
        return Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: adminMarkers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 118.0, horizontal: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "floatActbtn1",
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: ThemeColors.Green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 48,
          ),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 12))
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                
                Expanded(
                  flex: 7,
                  child: FlatButton(
                    //padding: EdgeInsets.only(
                      //  right: MediaQuery.of(context).size.width - 200),
                    onPressed: () async {
                      Prediction p = await PlacesAutocomplete.show(
                          context: context, apiKey: kGoogleApiKey);
                      await displayPrediction(p, scaffoldkey.currentState);
                    },
                    child: Text(
                      "Chercher un lieu",
                      style: TextStyle(
                          color: ThemeColors.greyBG,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/icons/Search.png',
                    height: 22,
                  ),
                )
              ],
            ),
          ),
        ),
          ],
        );
      },
    );
//**** */
  }
  //****** */

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      _center = LatLng(lat.toDouble(), lng.toDouble());
      if (lat != null && lng != null)
        mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              lat,
              lng,
            ),
          ),
        );
    }
  }

  //****** */
  void _onMapTypeButtonPressed() {
    setState(() {
      print(adminMarkers.toString());
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }
}
