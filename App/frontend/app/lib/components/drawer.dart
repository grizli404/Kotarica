import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/products/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';
import '../model/kategorijeModel.dart';
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
      kategorije.dajKategoriju(0);
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
  zatvoriSesiju() async {
    korisnikInfo = null;
    await FlutterSession().set('email', '');
  }

  ProizvodiModel proizvodi = ProizvodiModel();
  return Container(
    color: ResponsiveLayout.isIphone(context)
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).primaryColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 120,
          child: DrawerHeader(
            decoration: ResponsiveLayout.isIphone(context)
                ? BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  )
                : BoxDecoration(color: Theme.of(context).primaryColor),
            child: !ResponsiveLayout.isIphone(context)
                ? (korisnikInfo != null
                    ? Text(
                        'Hello, ${korisnikInfo.ime}',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        'Hello',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                : Text(
                    'Kotarica',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30),
                  ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: kategorije.trenutnaKategorija.length,
          itemBuilder: (context, index) {
            return ListTile(
              shape: Border.all(color: Colors.grey),
              title: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductByCategory(
                          listaProizvoda: proizvodi.dajProizvodeZaKategoriju(
                              kategorije.trenutnaKategorija[index].id),
                          category:
                              '${kategorije.trenutnaKategorija[index].naziv}',
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  '${kategorije.trenutnaKategorija[index].naziv}',
                  style: TextStyle(
                    fontSize: 20,
                    // color: ResponsiveLayout.isIphone(context)
                    //     ? Theme.of(context).primaryColor
                    //     : Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          //   child: Container(color: Color(0xFFEBEBEB)
          //  height: 1.0)
        ),
        Container(
          height: 80,
          padding: EdgeInsets.only(left: 15.0),
          child: InkWell(
            hoverColor: Colors.grey,
            //focusColor: Colors.grey,
            onTap: () {
              zatvoriSesiju();
              Navigator.pushNamed(context, '/home');
            },
            child: Row(
              children: [
                Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 20,
                    // color: ResponsiveLayout.isIphone(context)
                    //     ? Colors.black
                    //     : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          //color: Colors.white,
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.only(left: 15.0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('Light/Dark mode',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              ChangeThemeButton(),
            ],
          ),
        )
      ],
    ),
  );
}
