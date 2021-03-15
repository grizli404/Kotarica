class SignupResponseModel {
  final String name;
  final String job;

  SignupResponseModel({this.name, this.job});
  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
        name: json["name"] != null ? json["name"] : "",
        job: json["job"] != null ? json["job"] : "");
  }
}

class SignupRequestModel {
  String email;
  String password;

  SignupRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': email.trim(),
      'job': password.trim(),
    };
    return map;
  }
}
