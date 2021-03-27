import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/kategorijeModel.dart';

class ListenToDrawerEvent extends StatefulWidget {
  @override
  ListenToDrawerEventState createState() {
    return new ListenToDrawerEventState(
        // items: List<String>.generate(5, (i) => "Item $i"),
        );
  }
}

class ListenToDrawerEventState extends State<ListenToDrawerEvent> {
  //final List<String> items;

  //dynamic token = FlutterSession().get('email');
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
    return Drawer(
      // child: //SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Text(
                  'Kotarica',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: kategorije.trenutnaKategorija.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return null;
                        },
                      ),
                    );*/
                  },
                  child: ListTile(
                    shape: Border.all(color: Colors.grey),
                    title: Text(
                      //'${items[index]}',
                      '${kategorije.trenutnaKategorija[index].naziv}',
                      style: TextStyle(
                        fontSize: 20,
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
                  zatvoriSesiju();
                  Navigator.pushNamed(context, '/home');
                },
                child: Row(
                  children: [
                    Text(
                      'Log out',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              //color: Colors.white,
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      ),
    );
  }
}
