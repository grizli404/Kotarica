import 'package:app/components/product_card.dart';
import 'package:app/model/favoritesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import '../../../main.dart';
import '../../../model/listaZeljaModel.dart';
import '../../../model/proizvodiModel.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListaZeljaModel lzModel = new ListaZeljaModel();
    ProizvodiModel pModel = new ProizvodiModel();
    lzModel.dajLajkove(korisnikInfo.id);
    List<Proizvod> listaOmiljenihProizvoda;
    List<int> listaIndeksaOmiljenihProizvoda = lzModel.listaLajkovanihProizvoda;

    for (int i = 0; i < listaIndeksaOmiljenihProizvoda.length; i++) {
      listaOmiljenihProizvoda
          .add(pModel.dajProizvodZaId(listaIndeksaOmiljenihProizvoda[i]));
      print(pModel.dajProizvodZaId(listaIndeksaOmiljenihProizvoda[i]).naziv);
    }
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          children: generateChildren(listaOmiljenihProizvoda),
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

// List<Proizvod> testProizvodi = [
//   new Proizvod(
//     cena: 100,
//     id: 100,
//     idKorisnika: 1,
//     kolicina: 100,
//     naziv: "Jabuke",
//   ),
//   new Proizvod(
//     cena: 100,
//     id: 100,
//     idKorisnika: 1,
//     kolicina: 100,
//     naziv: "Kruske",
//   ),
//   new Proizvod(
//     cena: 100,
//     id: 100,
//     idKorisnika: 1,
//     kolicina: 100,
//     naziv: "Jabuke",
//   ),
//   new Proizvod(
//     cena: 100,
//     id: 100,
//     idKorisnika: 1,
//     kolicina: 100,
//     naziv: "Kruske",
//   ),
//   new Proizvod(
//     cena: 100,
//     id: 100,
//     idKorisnika: 1,
//     kolicina: 100,
//     naziv: "Jabuke",
//   ),
//   new Proizvod(
//     cena: 100,
//     id: 100,
//     idKorisnika: 1,
//     kolicina: 100,
//     naziv: "Kruske",
//   ),
// ];
