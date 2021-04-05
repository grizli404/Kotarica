import 'package:app/constants.dart';
import 'package:app/model/cart.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class ConfirmConfiguration extends StatelessWidget {
  ConfirmConfiguration(
      {this.personalData, this.setPayment, this.setProgressHud});
  Function setProgressHud;
  PersonalData personalData;
  Function setPayment;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: kPrimaryColor),
              bottom: BorderSide(color: kPrimaryColor),
              left: BorderSide(color: kPrimaryColor),
              right: BorderSide(color: kPrimaryColor)),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (personalData.ime != '') ...[
              Text("Ime i prezime: ${personalData.ime}")
            ],
            if (personalData.kontakt != '') ...[
              Text("Kontakt telefon: ${personalData.kontakt}")
            ],
            if (personalData.postanskiBroj != '') ...[
              Text("Postanski broj: ${personalData.postanskiBroj}")
            ],
            if (personalData.adresa != '') ...[
              Text("Adresa: ${personalData.adresa}")
            ],
            if (personalData.opis != '') ...[
              Text("Opis: ${personalData.opis}")
            ],
            if (personalData.privateKey != '') ...[
              Text("Personal Key: ${personalData.privateKey}")
            ],
            SizedBox(
              height: 30,
            ),
            for (var index in demoCarts) ...[
              Text("Artikli: ${index.product.naziv} x ${index.numOfItems}"),
            ],
            Text("TOTAL: ${sumTotal(demoCarts)} RSD",
                style: TextStyle(fontWeight: FontWeight.w800)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {
                    setPayment(true);
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: Row(
                    children: [Icon(Icons.arrow_back_rounded), Text("Nazad")],
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      setProgressHud(true);
                    },
                    color: Colors.purple,
                    textColor: Colors.white,
                    child: Row(
                      children: [Text("Poruci"), Icon(Icons.check)],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
