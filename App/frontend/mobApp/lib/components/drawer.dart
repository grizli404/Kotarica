import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/add_product/add_product.dart';
import 'package:app/screens/products/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  List<Kategorija> kategorijeBezRoditelja() {
    //  print("askdfjklasjdf");
    List<Kategorija> kategorijeBez = <Kategorija>[];
    //   print('1');
    for (var i = 0; i < kategorije.kategorije.length; i++) {
      if (kategorije.kategorije[i].idRoditelja == 0) {
        //      print('kat ' + kategorije.kategorije[i].naziv);
        kategorijeBez.add(kategorije.kategorije[i]);
      }
    }
//    print('2');
    return kategorijeBez;
  }

  ProizvodiModel proizvodi = ProizvodiModel();
  List<Kategorija> noveKategorije = kategorijeBezRoditelja();
  return Container(
      width: 300,
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
                height: ResponsiveLayout.isIphone(context) ? 150 : 150,
                child: !isWeb
                    ? DrawerHeader(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        // print("nesto " +
                                        //     ModalRoute.of(context)
                                        //         .settings
                                        //         .name
                                        //         .toString());

                                        ModalRoute.of(context).settings.name ==
                                                "/home"
                                            ? Navigator.pushReplacementNamed(
                                                context, "/home")
                                            : Navigator.popAndPushNamed(
                                                context, "/home");
                                      },
                                      child: Row(children: [
                                        IconButton(
                                          onPressed: () {
                                            ModalRoute.of(context)
                                                        .settings
                                                        .name ==
                                                    "/home"
                                                ? Navigator
                                                    .pushReplacementNamed(
                                                        context, "/home")
                                                : Navigator.popAndPushNamed(
                                                    context, "/home");
                                          },
                                          icon: SvgPicture.asset(Theme.of(
                                                          context)
                                                      .colorScheme ==
                                                  ColorScheme.dark()
                                              ? "assets/icons/shopping-basket-dark.svg"
                                              : "assets/icons/shopping-basket.svg"),
                                          iconSize: 45,
                                        ),
                                        Text(
                                          'Kotarica',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ])),
                                ],
                              ),
                              korisnikInfo != null
                                  // Token.jwt != null
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
                            ]))
                    : Container(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      ModalRoute.of(context).settings.name ==
                                              "/home"
                                          ? Navigator.pushReplacementNamed(
                                              context, "/home")
                                          : Navigator.popAndPushNamed(
                                              context, "/home");
                                    },
                                    child: Row(children: [
                                      IconButton(
                                        onPressed: () {
                                          ModalRoute.of(context)
                                                      .settings
                                                      .name ==
                                                  "/home"
                                              ? Navigator.pushReplacementNamed(
                                                  context, "/home")
                                              : Navigator.popAndPushNamed(
                                                  context, "/home");
                                        },
                                        icon: SvgPicture.asset(Theme.of(context)
                                                    .colorScheme ==
                                                ColorScheme.dark()
                                            ? "assets/icons/shopping-basket-dark.svg"
                                            : "assets/icons/shopping-basket.svg"),
                                        iconSize: 45,
                                      ),
                                      Text(
                                        'Kotarica',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ])),
                              ],
                            ),
                            Text(
                              korisnikInfo != null
                                  ? 'Dobrodošli,\n${korisnikInfo.ime}'
                                  : 'Dobrodošli',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ))),
            Container(
                padding: EdgeInsets.only(left: 15.0),
                child: InkWell(
                    focusColor: tamnoPlava,
                    onTap: () {
                      ModalRoute.of(context).settings.name == "/home"
                          ? Navigator.pushReplacementNamed(context, "/home")
                          : Navigator.popAndPushNamed(context, "/home");
                    },
                    child: Row(
                      children: [
                        Icon(Icons.home,
                            size: 26,
                            color: !isWeb &&
                                    Theme.of(context).colorScheme ==
                                        ColorScheme.light()
                                ? kPrimaryColor
                                : Colors.white),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Početna strana',
                          style: TextStyle(
                              fontSize: 22,
                              color: (!isWeb &&
                                          Theme.of(context).colorScheme ==
                                              ColorScheme.dark()) ||
                                      isWeb
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ))),

            if (korisnikInfo != null) ...[
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 5,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: Theme.of(context).colorScheme == ColorScheme.light()
                    ? tamnoPlava
                    : Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                //  height: 80,
                padding: EdgeInsets.only(left: 15.0),
                child: InkWell(
                    hoverColor: Colors.grey,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                    child: Row(children: [
                      Icon(
                        Icons.control_point,
                        size: 26,
                        color: !isWeb &&
                                Theme.of(context).colorScheme ==
                                    ColorScheme.light()
                            ? kPrimaryColor
                            : Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Dodajte novi proizvod',
                        style: TextStyle(
                            fontSize: 20,
                            color: (!isWeb &&
                                        Theme.of(context).colorScheme ==
                                            ColorScheme.dark()) ||
                                    isWeb
                                ? Colors.white
                                : Colors.black),
                      ),
                    ])),
              ),
            ],
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).colorScheme == ColorScheme.light()
                  ? tamnoPlava
                  : Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(children: [
                  Icon(
                    Icons.label_outline,
                    size: 26,
                    color: !isWeb &&
                            Theme.of(context).colorScheme == ColorScheme.light()
                        ? kPrimaryColor
                        : Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Kategorije:',
                    style: TextStyle(
                        fontSize: 22,
                        color: (!isWeb &&
                                    Theme.of(context).colorScheme ==
                                        ColorScheme.dark()) ||
                                isWeb
                            ? Colors.white
                            : Colors.black),
                  ),
                ])),
            ListView.builder(
              shrinkWrap: true,
              itemCount: noveKategorije.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      //dense: true,
                      title: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // print('ind ' + index.toString());
                                // print('kat ' + noveKategorije[index].id.toString());
                                return ProductByCategory(
                                  //    listaProizvoda:
                                  //       proizvodi.dajProizvodeZaKategoriju(
                                  //             noveKategorije[index].id),
                                  category: '${noveKategorije[index].naziv}',
                                  categoryId: noveKategorije[index].id,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.topLeft,
                            child: Row(children: [
                              Icon(
                                Icons.circle,
                                size: 13,
                                //color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${noveKategorije[index].naziv}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: (!isWeb &&
                                                Theme.of(context).colorScheme ==
                                                    ColorScheme.dark()) ||
                                            isWeb
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ])),
                      ),

                      children: [
                        prikazPotkategorija(index, kategorije, proizvodi),
                        Divider(
                          height: 5,
                          thickness: 4,
                          indent: 20,
                          endIndent: 20,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.light()
                              ? tamnoPlava
                              : Colors.white,
                        ),
                      ],
                    ));
              },
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 15.0),
            // ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).colorScheme == ColorScheme.light()
                  ? tamnoPlava
                  : Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            korisnikInfo != null
                ? Container(
                    //  height: 80,
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
                          Icon(
                            Icons.login_outlined,
                            size: 26,
                            color: !isWeb &&
                                    Theme.of(context).colorScheme ==
                                        ColorScheme.light()
                                ? kPrimaryColor
                                : Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Odjavite se',
                            style: TextStyle(
                                fontSize: 20,
                                color: (!isWeb &&
                                            Theme.of(context).colorScheme ==
                                                ColorScheme.dark()) ||
                                        isWeb
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  )
                : Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.login_rounded,
                              size: 26,
                              color: !isWeb &&
                                      Theme.of(context).colorScheme ==
                                          ColorScheme.light()
                                  ? kPrimaryColor
                                  : Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Prijavite se',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: (!isWeb &&
                                              Theme.of(context).colorScheme ==
                                                  ColorScheme.dark()) ||
                                          isWeb
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ))),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).colorScheme == ColorScheme.light()
                  ? tamnoPlava
                  : Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.brightness_2,
                    size: 26,
                    color: !isWeb &&
                            Theme.of(context).colorScheme == ColorScheme.light()
                        ? kPrimaryColor
                        : Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Tamna tema',
                      style: TextStyle(
                          fontSize: 20,
                          color: (!isWeb &&
                                      Theme.of(context).colorScheme ==
                                          ColorScheme.dark()) ||
                                  isWeb
                              ? Colors.white
                              : Colors.black)),
                  ChangeThemeButton(),
                ],
              ),
            ),
            if (isWeb)
              SizedBox(
                height: 10,
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProductByCategory(
                    // listaProizvoda: proizvodi
                    //     .dajProizvodeZaPotkategoriju(potkategorije[index].id),
                    category: '${potkategorije[index].naziv}',
                    categoryId: potkategorije[index].idRoditelja,
                    potkategorijaId: potkategorije[index].id,
                  );
                },
              ),
            );
          },
          child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.topLeft,
              child: Row(children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                  // color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '  ${potkategorije[index].naziv}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      color: (!isWeb &&
                                  Theme.of(context).colorScheme ==
                                      ColorScheme.dark()) ||
                              isWeb
                          ? Colors.white
                          : Colors.black),
                ),
              ])),
        ),
      );
    },
  );
}
