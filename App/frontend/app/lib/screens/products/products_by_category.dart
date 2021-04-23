import 'dart:collection';
//import 'dart:html';
import 'dart:io';

import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/product_card.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/model/search.dart';
import 'package:app/screens/home/components/productContainer.dart';
import 'package:app/screens/home/components/productView.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

import 'package:flutter/material.dart';

class ProductByCategory extends StatefulWidget {
  final String category;
  final List<Proizvod> listaProizvoda;
  final displayProducts;
  final TextEditingController searchController;

  ProductByCategory({
    Key key,
    @required this.category,
    this.listaProizvoda,
    this.displayProducts,
    this.searchController,
  }) : super(key: key);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  maxCena() {
    if (widget.listaProizvoda.length > 0) {
      int max = 0;
      for (var i = 0; i < widget.listaProizvoda.length; i++) {
        if (widget.listaProizvoda[i].cena > max)
          max = widget.listaProizvoda[i].cena;
      }
      return max.toDouble();
    }
    return 5000.0;
  }

  double _currentSliderValue = 0;
  minCena() {
    if (widget.listaProizvoda.length > 0) {
      int min = widget.listaProizvoda[0].cena;
      for (var i = 0; i < widget.listaProizvoda.length; i++) {
        if (widget.listaProizvoda[i].cena < min)
          min = widget.listaProizvoda[i].cena;
      }
      return min.toDouble();
    }
    //print(min.toString());
    //_currentSliderValue = min.toDouble();
  }

  int _value = 3;
  bool _isSortChanged = false;
  bool _isFilterChanged = false;

  @override
  Widget build(BuildContext context) {
    if (widget.listaProizvoda != null)
      return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  height: 25,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  padding: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                      value: _value,
                      underline: SizedBox(),
                      items: [
                        DropdownMenuItem(
                            child: Text("Cena - opadajuća",
                                style: TextStyle(
                                    color: Theme.of(context).hoverColor)),
                            value: 1),
                        DropdownMenuItem(
                            child: Text("Cena - rasutuća",
                                style: TextStyle(
                                    color: Theme.of(context).hoverColor)),
                            value: 2),
                        DropdownMenuItem(
                            child: Text("Datum - najnovije",
                                style: TextStyle(
                                    color: Theme.of(context).hoverColor)),
                            value: 3),
                        DropdownMenuItem(
                            child: Text("Datum - najstarije",
                                style: TextStyle(
                                    color: Theme.of(context).hoverColor)),
                            value: 4)
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          _isSortChanged = true;
                        });
                      }),
                ),
              ],
            ),
            // slider
            Row(
              children: [
                SizedBox(width: 25),
                Text('Cena:'),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 25),
                //Text(minCena.toString() + ' RSD'),
                Text('0.0 RSD - ' + maxCena().toString() + ' RSD'),
                // SizedBox(
                //   width: 200,
                // ),
              ],
            ),
            Slider(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).primaryColor.withOpacity(0.5),
              value: _currentSliderValue,
              min: 0.0,
              max: maxCena(),
              divisions: 10,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _isFilterChanged = true;
                  _currentSliderValue = value;
                });
              },
            ),

            if (_isSortChanged == false) ...[
              ProductView(
                listaProizvoda: widget.listaProizvoda,
              )
            ] else if (_isSortChanged == true) ...[
              ProductContainer(
                naziv: 'nesto',
              )
            ]
            // Pretraga(
            //     searchController: searchController,
            //     listaProizvoda: listaProizvoda,
            //     displayProducts: displayProducts),
            // Expanded(
            //     child: ProductView(
            //   listaProizvoda: widget.listaProizvoda,
            // ))
          ],
        )),
        drawer:
            ResponsiveLayout.isIphone(context) ? ListenToDrawerEvent() : null,
      );
  }
}

class Pretraga extends StatelessWidget {
  const Pretraga({
    Key key,
    @required this.searchController,
    @required this.listaProizvoda,
    @required this.displayProducts,
  }) : super(key: key);

  final TextEditingController searchController;
  final List<Proizvod> listaProizvoda;
  final displayProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left: kDefaultPadding, right: kDefaultPadding, top: 20, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Theme.of(context).primaryColor.withOpacity(0.23),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Pretraga',
                hintStyle: TextStyle(color: Theme.of(context).indicatorColor),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            child: SvgPicture.asset('assets/icons/search.svg'),
            onTap: () {
              List<Proizvod> lista =
                  searchFunction(searchController.text, listaProizvoda);
              displayProducts(lista);
            },
          )
        ],
      ),
    );
  }
}
