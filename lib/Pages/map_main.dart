import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patrimoine_app/UI/pop_up_Feedback.dart' as prefix0;
import 'dart:ui' show ImageFilter;
import '../theme.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import '../main.dart';

final Set<Marker> markers = {};

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
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(vertical: 110.0, horizontal: 16),
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
            horizontal: 24,
            vertical: 48,
          ),
          child: Container(
            height: 54,
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
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 7,
                  child: FlatButton(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width - 200),
                    onPressed: () async {
                      // show input autocomplete with selected mode
                      // then get the Prediction selected
                      Prediction p = await PlacesAutocomplete.show(
                          context: context, apiKey: kGoogleApiKey);
                      await displayPrediction(p, scaffoldkey.currentState);
                    },
                    child: Text(
                      "Rechercher",
                      style: new TextStyle(
                          color: ThemeColors.greyBG,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
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
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      markers.add(Marker(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, _, __) => prefix0.Dialog(),
                opaque: false),
          );
        },
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: 'Donner un feedback',
            onTap: () {
              Fluttertoast.showToast(
                  msg: "Veuillez remplir les informations suivantes",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 12.0);
            }),
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
}
