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
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                FutureBuilder(
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
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {}, // funkcija za pretragu
                      decoration: InputDecoration(
                        hintText: 'Pretraga',
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: SvgPicture.asset('assets/icons/search.svg'),
                    onTap: () {
                      List<Proizvod> lista =
                          searchFunction(searchController.text, proizvodi);
                      displayProducts(lista);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
