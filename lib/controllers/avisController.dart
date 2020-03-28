import 'package:patrimoine_app/Models/avisModel.dart';

import 'package:http/http.dart';
import 'dart:convert';

final domainName = 'https://tourathi-dz.com/api';

Future<List<AvisModel>> makeGetRequestAvis(String idMarker) async {
  // make GET request
  String url = domainName;
  Response response = await get(url + '/marker/show/' + idMarker);
  int statusCode = response.statusCode;

  List<AvisModel> avis;
  var data = json.decode(response.body);
  var rest = data["data"] as List;

  avis = rest.map<AvisModel>((json) => AvisModel.fromJson(json)).toList();
  print(avis.toString());
  
  return avis;
}
