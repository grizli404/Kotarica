import 'package:app/components/responsive_layout.dart';
import 'package:app/screens/products/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/kategorijeModel.dart';

class ListenToDrawerEvent extends StatefulWidget {
  @override
  ListenToDrawerEventState createState() {
    return new ListenToDrawerEventState();
  }
}

class ListenToDrawerEventState extends State<ListenToDrawerEvent> {
  zatvoriSesiju() async {
    await FlutterSession().set('email', '');
  }

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
  return Container(
    color:
        ResponsiveLayout.isIphone(context) ? kBackgroundColor : kPrimaryColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 120,
          child: DrawerHeader(
            decoration: ResponsiveLayout.isIphone(context)
                ? BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  )
                : BoxDecoration(color: kPrimaryColor),
            child: !ResponsiveLayout.isIphone(context)
                ? (FutureBuilder(
                    future: FlutterSession().get('email'),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData && snapshot.data != ''
                            ? 'Hello, ${snapshot.data.toString()}'
                            : 'Hello',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    },
                  ))
                : (Text(
                    'Kotarica',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30),
                  )),
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
                            category:
                                '${kategorije.trenutnaKategorija[index].naziv}');
                      },
                    ),
                  );
                },
                child: Text(
                  '${kategorije.trenutnaKategorija[index].naziv}',
                  style: TextStyle(
                    fontSize: 20,
                    color: ResponsiveLayout.isIphone(context)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
        Container(
          height: 80,
          padding: EdgeInsets.only(left: 15.0),
          child: InkWell(
            hoverColor: Colors.grey,
            //focusColor: Colors.grey,
            onTap: () {
              //  zatvoriSesiju();
              Navigator.pushNamed(context, '/home');
            },
            child: Row(
              children: [
                Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 20,
                    color: ResponsiveLayout.isIphone(context)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          //color: Colors.white,
          alignment: Alignment.centerLeft,
        ),
      ],
    ),
  );
}
