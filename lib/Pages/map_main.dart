import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patrimoine_app/Models/marker.dart';
import 'package:patrimoine_app/UI/pop_up_Feedback.dart' as prefix0;
import 'package:patrimoine_app/controllers/addMakerController.dart';
import 'package:patrimoine_app/controllers/markersController.dart';
import 'dart:ui' show ImageFilter;
import '../theme.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import '../main.dart';
import '../UI/pop_up_Avis.dart';

Set<Marker> markers = {};
BuildContext myContext;
//****/
const kGoogleApiKey = "AIzaSyDgID5BLQ78GOQ9AMYPwvfk6CRffTCyGCI";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
//****/

class MainMap extends StatefulWidget {
  MainMap({
    Key key,
    this.parameter,
  }) : super(key: key);

  final parameter;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MainMap> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  static LatLng _center = const LatLng(36.737232, 3.086472);

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    setState(() {
      setMarkers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          mapType: _currentMapType,
          markers: markers,
          onCameraMove: _onCameraMove,
        ),
        Center(
          child: Icon(
            Icons.add_location,
            size: 36.0,
            color: ThemeColors.Green,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 118.0, horizontal: 16),
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
                FloatingActionButton(
                  heroTag: "floatActbtn2",
                  onPressed: _onAddMarkerButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: ThemeColors.Green,
                  child: const Icon(Icons.add_location, size: 36.0),
                ),
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
    makeGetRequestMarkers();
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      makePostAddMarker(_lastMapPosition.toString(), _lastMapPosition.latitude,
          _lastMapPosition.longitude, 3);
      markers.add(Marker(
        onTap: () {
          showPopUp(myContext);
        },
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }

  void setMarkers() async {
    var notes = List<MarkersModel>();
    notes = await makeGetRequestMarkers();

    notes.forEach((document) {
      setState(() {
        markers.add(Marker(
          onTap: () {
            showPopUp(myContext);
          },
          markerId: MarkerId(document.id.toString()),
          position: LatLng(
            double.tryParse(document.latitude),
            double.tryParse(document.longitude),
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    });
  }
}

void showPopUp(BuildContext context2) {
  if (indexGlobal == 2) {
    Navigator.of(context2).push(
      PageRouteBuilder(
          pageBuilder: (context2, _, __) => prefix0.Dialog(), opaque: false),
    );
  }
  if (indexGlobal == 1) {
    Navigator.of(context2).push(
      PageRouteBuilder(
          pageBuilder: (context2, _, __) => Dialog2(), opaque: false),
    );
  }
}
