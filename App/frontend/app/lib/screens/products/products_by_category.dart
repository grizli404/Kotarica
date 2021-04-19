import 'dart:collection';

import 'package:app/components/customAppBar.dart';
import 'package:app/components/drawer.dart';
import 'package:app/components/product_card.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/model/search.dart';
import 'package:app/screens/home/components/productContainer.dart';
import 'package:app/screens/home/components/productView.dart';
import 'package:flutter_svg/svg.dart';

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
  int _value = 3;
  bool _isSortChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
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
                            child: Text("Cena - opadajuća"), value: 1),
                        DropdownMenuItem(
                            child: Text("Cena - rasutuća"), value: 2),
                        DropdownMenuItem(
                            child: Text("Datum - najnovije"), value: 3),
                        DropdownMenuItem(
                            child: Text("Datum - najstarije"), value: 4)
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
            if (_isSortChanged == false) ...[
              Expanded(
                  child: ProductView(
                listaProizvoda: widget.listaProizvoda,
              ))
            ] else if (_isSortChanged == true) ...[
              Expanded(
                  child: ProductContainer(
                naziv: 'nesto',
              ))
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
        ),
      ),
      drawer: ResponsiveLayout.isIphone(context) ? ListenToDrawerEvent() : null,
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
