import 'package:http/http.dart' as http;

import 'dart:io';

Future<String> uploadImage(File filename) async {
  var request =
      http.MultipartRequest('POST', Uri.parse("http://10.0.2.2:5000/upload"));
  request.files
      .add(await http.MultipartFile.fromPath('picture', filename.path));
  var res = await request.send();

  return res.stream.bytesToString();
  //return res.reasonPhrase;
}
