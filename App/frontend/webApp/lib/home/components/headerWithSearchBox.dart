import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/model/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
    this.displayProducts,
    this.searchController,
    this.proizvodi,
  }) : super(key: key);
  final displayProducts;
  final Size size;
  final TextEditingController searchController;
  final List<Proizvod> proizvodi;
  @override
  Widget build(BuildContext context) {
    return containerWeb(context);
  }

  Widget containerWeb(BuildContext context) {
    List<Proizvod> lista = [];
    return Container(
      //margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // height: ResponsiveLayout.isIphone(context)
      //     ? size.height * 0.2
      //     : size.height * 0.09,
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: 36 + kDefaultPadding,
          ),
          height: 89,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Positioned(
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
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
                      style: TextStyle(color: Colors.black),
                      controller: searchController,
                      onSubmitted: (input) {
                        lista =
                            searchFunction(searchController.text, proizvodi);
                        displayProducts(lista);
                      },
                      onChanged: (input) {},
                      decoration: InputDecoration(
                        hintText: 'Pretraga...',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: SvgPicture.asset('assets/icons/search.svg'),
                    onTap: () {
                      lista = searchFunction(searchController.text, proizvodi);
                      displayProducts(lista);
                    },
                  )
                ],
              )),
        )
      ]),
    );
  }
}
