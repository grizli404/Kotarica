import 'package:app/components/filter.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/components/productContainer.dart';
import 'package:app/screens/home/components/productView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//import '../../../constants.dart';
import '../../../main.dart';
import 'headerWithSearchBox.dart';

class Body extends StatefulWidget {
  final proizvodi = ProizvodiModel().listaProizvoda;
  @override
  _Body createState() => _Body(listaProizvoda: proizvodi);
}

class _Body extends State<Body> {
  _Body({this.listaProizvoda});
  List<Proizvod> listaProizvoda;
  List<Proizvod> listaFilter;
  bool _isSearchState = false;
  int _value;
  bool _isSortChanged = false;
  bool _isFilterChanged = false;
  TextEditingController controllerMin = new TextEditingController();
  TextEditingController controllerMax = new TextEditingController();
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
            if (isWeb) ...[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  napraviSort(),
                  SizedBox(width: 30),
                  opsegCeneText(),
                  napraviFilter(),
                  napraviDugme(),
                  Text('/'),
                  dugmePonisti(),

                  //SizedBox(width: MediaQuery.of(context).size.width - 1000),
                ],
              ),
            ] else ...[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                napraviPopUpZaMobile(),
                napraviSort(),
              ]),
            ],
            if (_isSearchState == false &&
                _isSortChanged == false &&
                _isFilterChanged == false) ...[
              //SizedBox(height: kDefaultPadding),
              //ProductView(),
              ProductContainer(naziv: 'Najnoviji proizvodi'),
              ProductContainer(naziv: 'Popularni proizvodi'),
              ProductContainer(naziv: 'Preporuka'),
              SizedBox(
                height: 30.0,
              ),
            ] else if (_isSearchState == true) ...[
              ProductView(
                listaProizvoda: listaProizvoda,
              ),
            ] else if (_isSortChanged == true) ...[
              prikaziProizvode()
            ] else if (_isFilterChanged == true) ...[
              ProductView(
                listaProizvoda: listaFilter,
              )
            ]
          ],
        ),
      ),
    );
  }

  void displayProducts(List<Proizvod> displayLista) {
    setState(() {
      _isSearchState = true;
      this.listaProizvoda = displayLista;
    });
  }

  void displayFilterProducts(List<Proizvod> displayFilterLista) {
    setState(() {
      _isFilterChanged = true;
      this.listaFilter = displayFilterLista;
    });
  }

  Widget prikaziProizvode() {
    if (_value == 1) {
      return null;
    } else if (_value == 2) {
      return null;
    } else if (_value == 3) {
      // najnoviji
      return ProductView(listaProizvoda: listaProizvoda);
    } else if (_value == 4) {
      // najstariji
      Iterable inReverse = listaProizvoda.reversed;
      var listaReverse = inReverse.toList();
      return ProductView(listaProizvoda: listaReverse);
    }
  }

  Widget napraviPopUpZaMobile() {
    return IconButton(
      icon: Icon(Icons.filter_alt),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Filter cene'),
              content: SingleChildScrollView(),
              actions: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    opsegCeneText(),
                    SizedBox(
                      height: 5,
                    ),
                    napraviFilter(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    napraviDugme(),
                    Text('  /  '),
                    dugmePonisti(),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget napraviDugme() {
    return MaterialButton(
      child: Text('Primeni'),
      onPressed: () {
        if (controllerMax.text != null && controllerMin.text != null) {
          List<Proizvod> lista = filterFunction(
              num.tryParse(controllerMin.text),
              num.tryParse(controllerMax.text),
              listaProizvoda);
          displayFilterProducts(lista);
        }
      },
    );
  }

  Widget dugmePonisti() {
    return MaterialButton(
      onPressed: () {
        setState(() {
          _isFilterChanged = false;
          controllerMax.clear();
          controllerMin.clear();
        });
      },
      child: Text('Poništi'),
    );
  }

  Widget opsegCeneText() {
    return Text(
      'Opseg cene:   ',
      style: TextStyle(fontSize: 17),
    );
  }

  Widget napraviFilter() {
    return Row(
      mainAxisAlignment:
          !isWeb ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
      children: [
        isWeb ? SizedBox(width: 15) : Container(),
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Theme.of(context).primaryColor.withOpacity(0.23),
              ),
            ],
          ),
          width: 100,
          //child: Expanded(
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            controller: controllerMin,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {},
            decoration: InputDecoration(
              //  hintText: 'Pretraga',
              //  hintStyle: TextStyle(color: Theme.of(context).indicatorColor),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            //    ),
          ),
        ),
        Text('   -   '),
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Theme.of(context).primaryColor.withOpacity(0.23),
              ),
            ],
          ),
          width: 100,
          //child: Expanded(
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            controller: controllerMax,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {},
            decoration: InputDecoration(
              //  hintText: 'Pretraga',
              //  hintStyle: TextStyle(color: Theme.of(context).indicatorColor),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            //    ),
          ),
        ),
      ],
    );
  }

  Widget napraviSort() {
    return Container(
      height: 25,
      margin: ResponsiveLayout.isIphone(context)
          ? EdgeInsets.symmetric(horizontal: 20, vertical: 15)
          : EdgeInsets.only(left: 0),
      padding: EdgeInsets.only(left: 8),
      //alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Theme.of(context).primaryColor),
      ),
      child: DropdownButton(
          value: _value,
          underline: SizedBox(),
          hint: Text('Sortiranje',
              style: TextStyle(
                color: Theme.of(context).indicatorColor,
              )),
          items: [
            DropdownMenuItem(
                child: Text("Cena - opadajuća",
                    style: TextStyle(color: Theme.of(context).hoverColor)),
                value: 1),
            DropdownMenuItem(
                child: Text("Cena - rasutuća",
                    style: TextStyle(color: Theme.of(context).hoverColor)),
                value: 2),
            DropdownMenuItem(
                child: Text("Datum - najnovije",
                    style: TextStyle(color: Theme.of(context).hoverColor)),
                value: 3),
            DropdownMenuItem(
                child: Text("Datum - najstarije",
                    style: TextStyle(color: Theme.of(context).hoverColor)),
                value: 4)
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
              _isSortChanged = true;
            });
          }),
    );
  }
}
