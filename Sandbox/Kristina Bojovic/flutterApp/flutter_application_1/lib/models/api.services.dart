import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class APIServices {
  static String studentUrl = 'https://127.0.0.1:55928/Students';

  static Future fetchStudent() async {
    try {
      var response = await http.get(studentUrl);
      return response;
    } finally {}
  }
}
