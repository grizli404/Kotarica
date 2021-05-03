import 'dart:html';

class TokenWeb {
  static set setToken(String value) => window.sessionStorage["jwt"] = value;
  static String get jwt => window.sessionStorage["jwt"];
  static set deleteToken(String value) => window.sessionStorage["jwt"] = null;
}
