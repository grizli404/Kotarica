import 'dart:io';
//import 'dart:ui';

import 'package:app/components/input_fields.dart';
import 'package:app/components/rad_sa_slikama.dart';
import 'package:app/main.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

import 'package:image_picker/image_picker.dart';
import 'package:app/model/kategorijeModel.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../constants.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String slika = "0";

String textNaziv = "";
double opacityNaziv = 0.0;
String textKolicina = "";
double opacityKolicina = 0.0;
String textCena = "";
double opacityCena = 0.0;

class AddProduct extends StatefulWidget {
  final String korisnik;
  const AddProduct({
    Key key,
    this.korisnik,
  }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final nazivController = TextEditingController();
  final kolicinaController = TextEditingController();
  final cenaController = TextEditingController();
  final opisController = TextEditingController();
  ProizvodiModel pModel;
  List<Kategorija> listaRoditeljKategorija = [];
  List<Kategorija> subcategory = [];
  Kategorija selectedCat;
  int catIndex;
  Kategorija potkategorija;
  KategorijeModel kModel;

  List<String> slike = [];

  // void dispose() {
  //   nazivController.dispose();
  //   kolicinaController.dispose();
  //   cenaController.dispose();
  //   opisController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    kModel = new KategorijeModel();
    pModel = new ProizvodiModel();
    listaRoditeljKategorija = listaRoditeljKateogrijaMain;
    selectedCat = listaRoditeljKategorija[0];
    subcategory = kModel.dajPotkategorije(selectedCat.id);
    potkategorija = subcategory[0];
    slika = "0";
  }

  @override
  Widget build(BuildContext context) {
    print(listaKategorija.length);
    print(subcategory.length);
    Size size = MediaQuery.maybeOf(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dodavanje proizvoda"),
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(36),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: slike.isNotEmpty
                              ? NetworkImage(
                                  "https://ipfs.io/ipfs/" + slike.first)
                              : AssetImage(
                                  "assets/images/defaultProductPhoto.jpg"))),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.add_a_photo),
                  focusColor: kPrimaryColor,
                  hoverColor: kPrimaryColorHover,
                  onPressed: () {
                    pickImages();
                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputFieldNotValidated(
                      myController: nazivController,
                      title: "Naziv",
                      maxLen: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Opacity(
                      opacity: opacityNaziv,
                      child: Text(
                        textNaziv,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputFieldNotValidated(
                      myController: kolicinaController,
                      title: "Kolicina",
                      maxLen: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Opacity(
                      opacity: opacityKolicina,
                      child: Text(
                        textKolicina,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputFieldNotValidated(
                      myController: cenaController, title: "Cena", maxLen: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Opacity(
                      opacity: opacityCena,
                      child: Text(
                        textCena,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputFieldNotValidated(
                      myController: opisController, title: "Opis", maxLen: 75),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Opacity(
                      opacity: 0.0,
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //kategorije
                  DropdownButton<Kategorija>(
                    value: selectedCat,
                    items: listaRoditeljKategorija.map((Kategorija value) {
                      print("Doropdown kategorija");
                      return new DropdownMenuItem<Kategorija>(
                          value: value,
                          child: Text(
                            value.naziv,
                            style: TextStyle(color: kPrimaryColor),
                          ));
                    }).toList(),
                    onChanged: (Kategorija newCat) {
                      print("Izmenjena kategorija");
                      print(newCat.naziv);
                      setState(() {
                        selectedCat = newCat;
                        subcategory = kModel.dajPotkategorije(selectedCat.id);
                        potkategorija = subcategory[0];
                      });
                    },
                  ), //potkategorije
                  DropdownButton<Kategorija>(
                    value: potkategorija,
                    items: subcategory.map((Kategorija value) {
                      print("Doropdown potkategorija");
                      return new DropdownMenuItem<Kategorija>(
                          value: value,
                          child: Text(
                            value.naziv,
                            style: TextStyle(color: kPrimaryColor),
                          ));
                    }).toList(),
                    onChanged: (Kategorija newCat) {
                      print("Izmenjena potkategorija");
                      print(newCat.naziv);
                      setState(() {
                        potkategorija = newCat;
                      });
                    },
                  ),
                ],
              ),
              RaisedButton(
                child: Text(
                  "Postavi proizvod",
                  style: TextStyle(color: Colors.white),
                ),
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: (size.width / 2) - 85),
                onPressed: () {
                  bool proba = true;
                  print("Naziv: " +
                      nazivController.text +
                      ",Kolicina: " +
                      kolicinaController.text +
                      ",Cena: " +
                      cenaController.text);

                  opacityKolicina = 0.0;
                  opacityCena = 0.0;
                  opacityNaziv = 0.0;
                  if (int.tryParse(kolicinaController.text) == null) {
                    proba = false;
                    textKolicina = "Nije unet broj";
                    opacityKolicina = 1.0;
                  }
                  if (int.tryParse(cenaController.text) == null) {
                    proba = false;
                    textCena = "Nije unet broj";
                    opacityCena = 1.0;
                  }
                  if (nazivController.text == "") {
                    proba = false;
                    textNaziv = "Nije popunjeno polje naziv";
                    opacityNaziv = 1.0;
                  }
                  if (cenaController.text == "") {
                    proba = false;
                    textCena = "Nije popunjeno polje cena";
                    opacityCena = 1.0;
                  }
                  if (kolicinaController.text == "") {
                    proba = false;
                    textKolicina = "Nije popunjeno polje kolicina";
                    opacityKolicina = 1.0;
                  }

                  if (!proba) {
                    //setState(() {});
                  } else {
                    print(korisnikInfo.id.toString() +
                        "," +
                        potkategorija.id.toString() +
                        "," +
                        nazivController.text +
                        "," +
                        kolicinaController.text +
                        "," +
                        cenaController.text +
                        "," +
                        opisController.text);
                    pModel.dodajProizvod(
                        korisnikInfo.id,
                        potkategorija.id,
                        nazivController.text,
                        int.parse(kolicinaController.text),
                        int.parse(cenaController.text),
                        slika,
                        opisController.text);
                    print("Uspesno dodavanje");
                  }
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // pickImageMobile() async {
  //   var file = await ImagePicker().getImage(source: ImageSource.gallery);
  //   print("Loading image...");
  //   var _image = File(file.path);
  //   print("Uploading image image...");
  //   SnackBar(
  //     content: Text("Loading image..."),
  //   );
  //   var res = await uploadImage(_image);
  //   print("image: " + res);
  //   slike[1] = res;
  //   setState(() {});
  // }

  bool loading = false;
  static final String uploadEndPoint = 'http://147.91.204.116:11093/upload';

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Greška pri otpremanju slike';

  File _image;
  String message = '';
  List<File> f = List();

  List<Asset> imagesAsset = List<Asset>();
  //replace the url by your url
  // your rest api url 'http://your_ip_adress/project_path' ///adresa racunara
  // bool loading1 = false;

  Future<void> pickImages() async {
    List<Asset> resultList = List<Asset>();
    slike.clear();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        //enableCamera: true,
        selectedAssets: imagesAsset,
      );
    } on Exception catch (e) {
      print(e);
    }
    //asset to image
    for (int i = 0; i < resultList.length; i++) {
      var path =
          await FlutterAbsolutePath.getAbsolutePath(resultList[i].identifier);
      f.add(File(path));
    }

    for (int i = 0; i < f.length; i++) {
      upload(f[i]);
    }

    setState(() {
      imagesAsset = resultList;
    });
  }

  upload(File file) async {
    if (file == null) return;
    setState(() {
      loading = true;
    });
    Map<String, String> headers = {
      "Accept": "multipart/form-data",
    };
    var uri = Uri.parse(uploadEndPoint);
    var length = await file.length();
    http.MultipartRequest request = new http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(
        // replace file with your field name exampe: image
        http.MultipartFile('avatar', file.openRead(), length,
            filename: 'test.png'),
      );
    var respons = await http.Response.fromStream(await request.send());
    slika = respons.body;
    slike.add(respons.body);
    setState(() {
      loading = false;
    });
    if (respons.statusCode == 200) {
      setState(() {
        message = ' image upload with success';
      });
      return;
    } else
      setState(() {
        message = ' image not upload';
      });
  }
}
