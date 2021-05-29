//import 'dart:html';

import 'package:app/components/filter.dart';
import 'package:app/components/progress_hud.dart';
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
  List<Proizvod> proizvodi;
  final String category;
  final int categoryId;
  final int potkategorijaId;
  ProizvodiModel pModel;

  Body({this.category, this.proizvodi, this.categoryId, this.potkategorijaId});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //List<Proizvod> listaProizvoda;
  List<Proizvod> listaFilter;
  bool _isSearchState = false;
  int _value;
  bool _isSortChanged = false;
  bool _isFilterChanged = false;
  bool inAsyncCall = true;
  TextEditingController controllerMin = new TextEditingController();
  TextEditingController controllerMax = new TextEditingController();

  Future setupState() async {
    try {
      if (inAsyncCall == false)
        setState(() {
          inAsyncCall = true;
        });

      if (widget.category == null) {
        if (widget.proizvodi != null) widget.proizvodi.clear();
        widget.pModel = Provider.of<ProizvodiModel>(context);
        await widget.pModel.dajSveProizvode();
        widget.proizvodi = widget.pModel.listaProizvoda;
      }
      if (widget.category != null) {
        if (widget.proizvodi != null) widget.proizvodi.clear();
        widget.pModel = Provider.of<ProizvodiModel>(context);

        if (widget.potkategorijaId == null)
          widget.proizvodi =
              widget.pModel.dajProizvodeZaKategoriju(widget.categoryId);
        if (widget.potkategorijaId != null)
          widget.proizvodi =
              widget.pModel.dajProizvodeZaPotkategoriju(widget.potkategorijaId);
      }

      setState(() {
        inAsyncCall = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.proizvodi == null) setupState();
  }

  @override
  void didUpdateWidget(covariant Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    this.widget.proizvodi = oldWidget.proizvodi;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _build(context), inAsyncCall: inAsyncCall);
  }

  Widget _build(BuildContext context) {
    if (inAsyncCall == true || widget.proizvodi == null) {
      return Container();
    } else {
      // var proizvodi = Provider.of<ProizvodiModel>(context);
      Size size = MediaQuery.maybeOf(context).size;
      return Container(
        //height: constraints.maxHeight,
        child: SingleChildScrollView(
          //padding: EdgeInsets.symmetric(horizontal: 200.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //  Text('${widget.category}'),
              HeaderWithSearchBox(
                size: size,
                displayProducts: displayProducts,
                searchController: TextEditingController(),
                proizvodi: widget.proizvodi,
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
                    if (filterError)
                      Text(
                        'Morate uneti maksimalnu cenu.',
                        style: TextStyle(color: Colors.red),
                      )
                    //SizedBox(width: MediaQuery.of(context).size.width - 1000),
                  ],
                ),
              ] else ...[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  napraviPopUpZaMobile(),
                  napraviSort(),
                ]),
              ],
              if (widget.category == null) ...[
                if (_isSearchState == false &&
                    _isSortChanged == false &&
                    _isFilterChanged == false) ...[
                  //SizedBox(height: kDefaultPadding),
                  //ProductView(),
                  ProductContainer(naziv: 'Najnoviji proizvodi'),
                  ProductContainer(naziv: 'Popularni proizvodi'),
                  ProductContainer(naziv: 'Preporuka'),
                  SizedBox(
                    height: isWeb ? 30.0 : 70,
                  ),
                ],
                if (_isSearchState == true) ...[
                  ProductView(
                    listaProizvoda: widget.proizvodi,
                  ),
                ] else if (_isFilterChanged == true &&
                    _isSortChanged == false) ...[
                  ProductView(
                    listaProizvoda: listaFilter,
                  )
                ] else if (_isSortChanged == true &&
                    _isFilterChanged == false) ...[
                  prikaziProizvode(widget.proizvodi)
                ] else if (_isFilterChanged == true &&
                    _isSortChanged == true) ...[
                  prikaziProizvode(listaFilter)
                ]
              ] else if (widget.category != null) ...[
                Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          height: 5,
                          thickness: 4,
                        )),
                        Text(
                          '     ' + widget.category + '      ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27.0),
                        ),
                        Expanded(
                            child: Divider(
                          height: 5,
                          thickness: 4,
                        )),
                      ],
                    )),
                if (_isSearchState == false &&
                    _isSortChanged == false &&
                    _isFilterChanged == false) ...[
                  ProductView(listaProizvoda: widget.proizvodi),
                  SizedBox(height: 30.0),
                ],
                if (_isSearchState == true) ...[
                  ProductView(
                    listaProizvoda: widget.proizvodi,
                  ),
                ] else if (_isFilterChanged == true &&
                    _isSortChanged == false) ...[
                  ProductView(
                    listaProizvoda: listaFilter,
                  )
                ] else if (_isSortChanged == true &&
                    _isFilterChanged == false) ...[
                  prikaziProizvode(widget.proizvodi)
                ] else if (_isFilterChanged == true &&
                    _isSortChanged == true) ...[
                  prikaziProizvode(listaFilter)
                ]
              ]
            ],
          ),
        ),
      );
    }
  }

  void displayProducts(List<Proizvod> displayLista) {
    setState(() {
      _isSearchState = true;
      this.widget.proizvodi = displayLista;
    });
  }

  void displayFilterProducts(List<Proizvod> displayFilterLista) {
    setState(() {
      _isFilterChanged = true;
      this.listaFilter = displayFilterLista;
    });
  }

  Widget prikaziProizvode(List<Proizvod> proizvodi) {
    // print('value ' + _value.toString());
    if (_value == 1) {
      // cena opadajuca
      proizvodi.sort((a, b) => a.cena.compareTo(b.cena));
      Iterable inReverse = proizvodi.reversed;
      var listaReverse = inReverse.toList();
      return ProductView(listaProizvoda: listaReverse);
    } else if (_value == 2) {
      // cena rastuca
      proizvodi.sort((a, b) => a.cena.compareTo(b.cena));
      return ProductView(listaProizvoda: proizvodi);
    } else if (_value == 3) {
      // najnoviji
      return ProductView(listaProizvoda: proizvodi);
    } else if (_value == 4) {
      // najstariji
      Iterable inReverse = proizvodi.reversed;
      var listaReverse = inReverse.toList();
      return ProductView(listaProizvoda: listaReverse);
    }

    return null;
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

  bool filterError = false;

  Widget napraviDugme() {
    return MaterialButton(
      child: Text('Primeni'),
      onPressed: () {
        if (controllerMin.text != '' && controllerMax.text != '') {
          List<Proizvod> lista = filterFunction(
              num.tryParse(controllerMin.text),
              num.tryParse(controllerMax.text),
              widget.proizvodi);
          displayFilterProducts(lista);
        }
        if (controllerMin.text == '' && controllerMax.text != '') {
          controllerMin.text = 0.toString();
          List<Proizvod> lista = filterFunction(
              num.tryParse(controllerMin.text),
              num.tryParse(controllerMax.text),
              widget.proizvodi);
          displayFilterProducts(lista);
        }
        if (controllerMax.text == '' && controllerMin.text != '') {
          setState(() {
            filterError = true;
          });
        }
      },
    );
  }

  Widget dugmePonisti() {
    return MaterialButton(
      onPressed: () {
        setState(() {
          _isFilterChanged = false;
          filterError = false;
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
                    style: TextStyle(color: Colors.black)),
                value: 1),
            DropdownMenuItem(
                child: Text("Cena - rasutuća",
                    style: TextStyle(color: Colors.black)),
                value: 2),
            DropdownMenuItem(
                child: Text("Datum - najnovije",
                    style: TextStyle(color: Colors.black)),
                value: 3),
            DropdownMenuItem(
                child: Text("Datum - najstarije",
                    style: TextStyle(color: Colors.black)),
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
