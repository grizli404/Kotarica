import 'dart:io';
import 'dart:ui';

import 'package:app/components/input_fields.dart';
import 'package:app/components/rad_sa_slikama.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/model/kategorijeModel.dart';
import '../../constants.dart';

import 'package:flutter/material.dart';

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

  void dispose() {
    nazivController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    KategorijeModel kModel = new KategorijeModel();
    kModel.dajKategorije();
    List<Kategorija> listaRoditeljKategorija = kModel.kategorije;
    //print(listaKategorija.length);
    ValueChanged<String> naziv;
    ValueChanged<String> kolicina;
    ValueChanged<String> cena;
    ValueChanged<String> opis;
    ValueChanged<String> kategorija;
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
                          image: slika != "0"
                              ? NetworkImage("https://ipfs.io/ipfs/" + slika)
                              : AssetImage(
                                  "assets/images/defaultProductPhoto.jpg"))),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                focusColor: kPrimaryColor,
                hoverColor: kPrimaryColorHover,
                onPressed: () async {
                  var file =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  print("Loading image...");
                  var _image = File(file.path);
                  print("Uploading image image...");
                  SnackBar(
                    content: Text("Loading image..."),
                  );
                  var res = await uploadImage(_image);
                  print("image: " + res);
                  slika = res;
                  setState(() {});
                },
              ),
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
              DropdownButton<String>(
                items: listaRoditeljKategorija.map((Kategorija value) {
                  return new DropdownMenuItem<String>(
                      value: "izaberi",
                      child: Text(
                        value.naziv,
                        style: TextStyle(color: kPrimaryColor),
                      ));
                }).toList(),
                hint: Text(
                  "Izaberite kategoriju",
                  style: TextStyle(color: kPrimaryColor),
                ),
                onChanged: (_) {},
              ),
              InputFieldNotValidated(
                  field: kategorija, title: "Kategorija comboBox"),
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
                    setState(() {});
                  } else {
                    ProizvodiModel().dodajProizvod(
                        1, //Zamentiti sa pravim IDjem korisnika
                        int.parse("1"), //zameniti sa pravim idjem kategorije
                        nazivController.text,
                        int.parse(kolicinaController.text),
                        int.parse(cenaController.text),
                        slika,
                        opisController.text);
                    print("proslo");
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
}
