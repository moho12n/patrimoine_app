import 'package:patrimoine_app/Models/avisModel.dart';

import 'package:http/http.dart';
import 'dart:convert';

final domainName = 'https://tourathi-dz.com/api';

Future<AvisModel> makeGetRequestSingleAvis(String idMarker) async {
  // make GET request
  String url = domainName;
  Response response = await get(url + '/avis/show/' + idMarker);
  int statusCode = response.statusCode;

  AvisModel avis;
  var data = json.decode(response.body);
  var rest = data["data"] as Map<String, dynamic>;

  avis = AvisModel.fromJson(rest);

  return avis;
}
