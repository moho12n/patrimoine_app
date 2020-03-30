import 'package:http/http.dart';

import 'package:dio/dio.dart';

import 'dart:io';

import 'package:patrimoine_app/Models/feedbackModel.dart';

import 'listImageToListFile.dart';

final domainName = 'https://tourathi-dz.com/api';

Future<String> makePostAddFeedback(FeedbackModel feedback, var list) async {
  final dio =
      Dio(BaseOptions(headers: {"Content-type": "multipart/form-data"}));
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "multipart/form-data", // or whatever
  };
  // make GET request

  //List uploadList = await convertToListFile(list);

  //for (var imageFiles in list) { uploadList.add(UploadFileInfo(File(imageFiles), "job.jpg")); }
  String url = domainName + '/avis/store';
  print("feedback = " + feedback.toString());
  var formData = FormData.fromMap({
    "commentaire": feedback.commentaire,
    "nom_utilisateur": feedback.nomUtilisateur,
    "age": feedback.age,
    "lieu_residence": feedback.lieuResidence,
    "sexe": feedback.sexe,
    "rating": feedback.rating,
    "marker_id": feedback.markerId,
    
    //"image": uploadList
  });
  print("formData : " + formData.fields.toString());
  var response = await dio.post(
    "https://tourathi-dz.com/api/avis/store",
    data: formData,
    options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        }),
  );
  print("repoooonse " + response.toString());
  // Response response = await post(url, body: formData, headers: headers);

  // print("body" + response.body);

  // return response.body;
}
