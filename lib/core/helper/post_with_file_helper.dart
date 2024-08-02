// import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
class PostHelper{

postWithFile(String url, Map data, File file) async {
  var multipartrequest = await http.MultipartRequest('POST', Uri.parse(url));
  var length = await file.length();
  var stream = await http.ByteStream(file.openRead());
  var multipartfile = await http.MultipartFile('file', stream, length,
      filename: basename(file.path));
  multipartrequest.files.add(multipartfile);
  data.forEach((key, value) {
    multipartrequest.fields[key] = value;
  });
  http.StreamedResponse sresponce = await multipartrequest.send();
  http.Response response = await http.Response.fromStream(sresponce);
  print(jsonDecode(response.body));
  return response;
}
}