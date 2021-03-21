
import 'package:app/api/api.dart';
import 'package:app/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APILogin {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = ROUTE_MAIN + "login/";

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login user(LOGIN)!');
    }
  }
}
