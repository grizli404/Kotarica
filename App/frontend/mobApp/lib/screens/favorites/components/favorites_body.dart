import 'package:app/components/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/listaZeljaModel.dart';
import '../../../model/proizvodiModel.dart';

class FavoritesBody extends StatelessWidget {
  //ListaZeljaModel lzModel;
  ProizvodiModel pModel;
  List<Proizvod> listaOmiljenihProizvoda = [];
  List<int> listaIndeksaOmiljenihProizvoda = [];

  FavoritesBody({
    Key key,
  }) {
    initObjects();
    init();
  }

  void init() async {
    print("here1");
    //await this.lzModel.dajLajkove(korisnikInfo.id);
    listaZeljaModelMain.dajLajkove(korisnikInfo.id);
    print("here2");
    this.listaIndeksaOmiljenihProizvoda =
        listaZeljaModelMain.listaLajkovanihProizvoda;

    for (int i = 0; i < listaIndeksaOmiljenihProizvoda.length; i++) {
      listaOmiljenihProizvoda
          .add(pModel.dajProizvodZaId(listaIndeksaOmiljenihProizvoda[i]));
      print(pModel.dajProizvodZaId(listaIndeksaOmiljenihProizvoda[i]).naziv);
    }
    print("proso omiljene");
  }

  void initObjects() {
    //this.lzModel = new ListaZeljaModel();
    this.pModel = new ProizvodiModel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          children: generateChildren(testProizvodi),
        ));
  }

  List<ProductCard> generateChildren(List<Proizvod> proizvodi) {
    List<ProductCard> kartice = [];
    for (int i = 0; i < proizvodi.length; i++) {
      print(proizvodi[i].naziv);
      kartice.add(new ProductCard(
          proizvod: proizvodi[i],
          name: proizvodi[i].naziv,
          price: proizvodi[i].cena.toString() + "din",
          imgPath: "assets/images/cookiechoco.jpg",
          added: true,
          isFavorite: false,
          context: "context"));
    }
    return kartice;
  }
}

List<Proizvod> testProizvodi = [
  new Proizvod(
    cena: 100,
    id: 100,
    idKorisnika: 1,
    kolicina: 100,
    naziv: "Jabuke",
  ),
  new Proizvod(
    cena: 100,
    id: 100,
    idKorisnika: 1,
    kolicina: 100,
    naziv: "Kruske",
  ),
  new Proizvod(
    cena: 100,
    id: 100,
    idKorisnika: 1,
    kolicina: 100,
    naziv: "Jabuke",
  ),
  new Proizvod(
    cena: 100,
    id: 100,
    idKorisnika: 1,
    kolicina: 100,
    naziv: "Kruske",
  ),
  new Proizvod(
    cena: 100,
    id: 100,
    idKorisnika: 1,
    kolicina: 100,
    naziv: "Jabuke",
  ),
  new Proizvod(
    cena: 100,
    id: 100,
    idKorisnika: 1,
    kolicina: 100,
    naziv: "Kruske",
  ),
];
