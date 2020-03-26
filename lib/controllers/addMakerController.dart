import 'package:patrimoine_app/Models/marker.dart';
import 'package:http/http.dart';
import 'dart:convert';

final domainName = 'https://tourathi-dz.com/api';

Future<String> makePostAddMarker(
    String name, double latitude, double longitude, int rating) async {
  String url = domainName + '/marker/store';
  // make PUT request
  Response response = await post(url,
      body:
          '{"name":"$name",	"latitude":$latitude, "longitude":$longitude,"rating":$rating}',
      headers: {"Content-type": "application/json"});
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the updated item with the id added
  String body = response.body;

  print("status code = " + statusCode.toString() + "\n body: " + body);

  return body;
}
