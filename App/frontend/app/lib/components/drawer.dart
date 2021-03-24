import 'package:app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/kategorijeModel.dart';

class ListenToDrawerEvent extends StatefulWidget {
  @override
  ListenToDrawerEventState createState() {
    return new ListenToDrawerEventState(
      items: List<String>.generate(5, (i) => "Item $i"),
    );
  }
}

class ListenToDrawerEventState extends State<ListenToDrawerEvent> {
  final List<String> items;
  
  ListenToDrawerEventState({Key key, @required this.items});
  @override
  Widget build(BuildContext context) {
    KategorijeModel kategorije = Provider.of<KategorijeModel>(context);
    if(kategorije.isLoading == false){
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
          ],
        ),
      ),
    );
  }
}
