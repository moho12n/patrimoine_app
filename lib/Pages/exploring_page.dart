import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patrimoine_app/Pages/map_main.dart' as prefix0;
import 'package:patrimoine_app/theme.dart';
import 'map_main.dart';
import './map_main.dart';

class ExploringMap extends StatefulWidget {
  ExploringMap({
    Key key,
    this.parameter,
  }) : super(key: key);

  final parameter;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ExploringMap> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(36.737232, 3.086472);

  final Set<Marker> _markers = prefix0.markers;

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    prefix0.myContext = context;
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          mapType: _currentMapType,
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 118, horizontal: 16),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
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
              children: <Widget>[
                SizedBox(
                  width: 18,
                ),
                Text(
                  "Rechercher",
                  style: new TextStyle(
                      color: ThemeColors.greyBG,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                /*Image.asset(
                  'assets/icons/Search.png',
                  height: 22,
                ),*/
                SizedBox(
                  width: 18,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}
