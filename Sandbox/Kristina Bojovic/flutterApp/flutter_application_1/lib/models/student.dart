import 'dart:ffi';

class Student {
  int id;
  String indeks;
  String imePrezime;

  Student(this.imePrezime, this.indeks);
  Student.withId(this.id, this.imePrezime, this.indeks);

  // int get id => _id;
  // String get indeks => _indeks;
  // String get imePrezime => _imePrezime;

  // set imePrezime(String ime) {
  //   _imePrezime = ime;
  // }

  // set indeks(String ind) {
  //   _imePrezime = ind;
  // }

  // od json fajla pravi mapu
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['imePrezime'] = imePrezime;
    map['indeks'] = indeks;

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // iz json u objekat
  Student.fromObject(dynamic o) {
    this.id = o['id'];
    this.imePrezime = o['imePrezime'];
    this.indeks = o['indeks'];
  }
}
