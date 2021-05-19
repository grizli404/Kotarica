import 'package:http/http.dart' as http;

import 'dart:io';

Future<String> uploadImage(File filename) async {
  var request =
      http.MultipartRequest('POST', Uri.parse("http://147.91.204.116:11093/upload"));
  print("Function: Adding request...");
  request.files
      .add(await http.MultipartFile.fromPath('picture', filename.path));

  print("Function: Sending request for" + filename.path);
  var res = await request.send();
  print("Function: Request sent.");
  return res.stream.bytesToString();
  //return res.reasonPhrase;
}
