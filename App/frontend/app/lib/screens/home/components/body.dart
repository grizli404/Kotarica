import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/productContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

//import '../../../constants.dart';
import 'headerWithSearchBox.dart';

class Body extends StatefulWidget {
  final proizvodi = ProizvodiModel().listaProizvoda;
  @override
  _Body createState() => _Body(listaProizvoda: proizvodi);
}

class _Body extends State<Body> {
  _Body({this.listaProizvoda});
  List<Proizvod> listaProizvoda;
  @override
  Widget build(BuildContext context) {
    var proizvodi = Provider.of<ProizvodiModel>(context);
    Size size = MediaQuery.maybeOf(context).size;
    return Container(
      //height: constraints.maxHeight,
      child: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(horizontal: 200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HeaderWithSearchBox(
              size: size,
              displayProducts: displayProducts,
              searchController: TextEditingController(),
              proizvodi: proizvodi.listaProizvoda,
            ),
            //SizedBox(height: kDefaultPadding),
            //ProductView(),
            ProductContainer(naziv: 'Najnoviji proizvodi'),
            ProductContainer(naziv: 'Popularni proizvodi'),
            ProductContainer(naziv: 'Preporuka'),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }

  void displayProducts(List<Proizvod> displayLista) {
    setState(() {
      this.listaProizvoda = displayLista;
    });
  }
}
