import 'package:patrimoine_app/Models/marker.dart';
import 'package:http/http.dart';
import 'dart:convert';

final domainName = 'https://tourathi-dz.com/api';

Future<List<MarkersModel>> makeGetRequestMarkers() async {
  // make GET request
  String url = domainName;
  Response response = await get(url + '/marker/');
  int statusCode = response.statusCode;
  List<MarkersModel> markers;
  var data = json.decode(response.body);
  var rest = data["data"] as List;

  markers =
      rest.map<MarkersModel>((json) => MarkersModel.fromJson(json)).toList();
  print(markers.toString());
  return markers;
}
