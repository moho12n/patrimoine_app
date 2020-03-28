import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:patrimoine_app/Models/imageModel.dart';

final domainName = 'https://tourathi-dz.com/api';

Future<List<ImageModel>> makeGetRequestImages(String idMarker) async {
  // make GET request
  String url = domainName;
  Response response = await get(url + '/marker/images/' + idMarker);

  List<ImageModel> images = List<ImageModel>();
  var data = json.decode(response.body);

  var rest = data["data"] as List;

  rest.forEach((element) {
    var js = json.decode(element);
    var vr = js as Map<String, dynamic>;
    images.add(ImageModel.fromJson(vr));
  });

  return images;
}
