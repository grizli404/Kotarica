import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/add_product/add_product.dart';
import 'package:app/screens/products/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';
import '../model/kategorijeModel.dart';
import '../token.dart';
import 'changeThemeButton.dart';

class ListenToDrawerEvent extends StatefulWidget {
  @override
  ListenToDrawerEventState createState() {
    return new ListenToDrawerEventState();
  }
}

class ListenToDrawerEventState extends State<ListenToDrawerEvent> {
  ListenToDrawerEventState({Key key});
  @override
  Widget build(BuildContext context) {
    KategorijeModel kategorije = Provider.of<KategorijeModel>(context);

    if (kategorije.isLoading == false) {
      kategorije.dajKategorije();
    }
    if (ResponsiveLayout.isIphone(context)) {
      return Drawer(
        elevation: 0.0,
        child: drawerContainer(context, kategorije),
      );
    } else {
      return drawerContainer(context, kategorije);
    }
  }
}

Widget drawerContainer(BuildContext context, KategorijeModel kategorije) {
  // var tokenWeb;
  zatvoriSesiju() async {
    korisnikInfo = null;
    //  print('jwt  ' + Token.jwt);
    !isWeb
        ? await Token.storage.delete(key: "jwt")
        : await FlutterSession().set('jwt', '');

    // tokenWeb = await FlutterSession().get('jwt');
  }

  ProizvodiModel proizvodi = ProizvodiModel();

  return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
          child: Container(
        //width: ResponsiveLayout.isIphone(context) ? null : 1000,
        color: ResponsiveLayout.isIphone(context)
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: ResponsiveLayout.isIphone(context) ? 120 : 150,
              child: DrawerHeader(
                  decoration: ResponsiveLayout.isIphone(context)
                      ? BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(36),
                          //   bottomRight: Radius.circular(36),
                          //),
                        )
                      : BoxDecoration(color: Theme.of(context).primaryColor),
                  child: !ResponsiveLayout.isIphone(context)
                      ? (
                          //tokenWeb != ''
                          korisnikInfo != null
                              ? Text(
                                  'Dobrodošli, ${korisnikInfo.ime}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  'Dobrodošli',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                'Kotarica',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                              //korisnikInfo != null
                              Token.jwt != null
                                  ? Text(
                                      'Dobrodošli, ${korisnikInfo.ime}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'Dobrodošli',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    )
                            ])),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Kategorije:',
                style: TextStyle(fontSize: 22),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: kategorije.kategorije.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ExpansionTile(
                  //dense: true,
                  title: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductByCategory(
                              listaProizvoda:
                                  proizvodi.dajProizvodeZaKategoriju(
                                      kategorije.kategorije[index].id),
                              category: '${kategorije.kategorije[index].naziv}',
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${kategorije.kategorije[index].naziv}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  children: [
                    prikazPotkategorija(index, kategorije, proizvodi),
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            if (korisnikInfo != null && isWeb)
              Container(
                height: 80,
                padding: EdgeInsets.only(left: 15.0),
                child: InkWell(
                  hoverColor: Colors.grey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProduct()),
                    );
                  },
                  child: Text(
                    'Dodajte novi proizvod',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            korisnikInfo != null
                ? Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 15.0),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Da li ste sigurni da želite da se odjavite?'),
                              content: SingleChildScrollView(),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Da',
                                    style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    zatvoriSesiju();
                                    Navigator.of(context).pushNamed('/home');
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Ne',
                                    style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Odjavite se',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  )
                : Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 15.0),
                    child: InkWell(
                      hoverColor: Colors.grey,
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Row(
                        children: [
                          Text(
                            'Prijavite se',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('Tamna tema',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  ChangeThemeButton(),
                ],
              ),
            )
          ],
        ),
      )));
}

Widget prikazPotkategorija(
    int index, KategorijeModel kategorije, ProizvodiModel proizvodi) {
  List<Kategorija> potkategorije =
      kategorije.dajPotkategorije(kategorije.kategorije[index].id);
  return ListView.builder(
    shrinkWrap: true,
    itemCount: potkategorije.length,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return ListTile(
        dense: true,
        title: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProductByCategory(
                    listaProizvoda: proizvodi
                        .dajProizvodeZaKategoriju(potkategorije[index].id),
                    category: '${potkategorije[index].naziv}',
                  );
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: Text(
              '  ${potkategorije[index].naziv}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      );
    },
  );
}
