import 'package:dio/dio.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as prefix0;

Future convertToListFile(var list) async {
  List<MultipartFile> multipart = List<MultipartFile>();

  for (int i = 0; i < list.length; i++) {
    var path = await FlutterAbsolutePath.getAbsolutePath(list[i].identifier);
    multipart.add(await MultipartFile.fromFile(path, filename: 'image$i.jpg'));
  }

  FormData imageFormData = FormData.fromMap({
    "files": multipart,
  });
  return imageFormData;
}
