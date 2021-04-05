import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class ShippingConfiguration extends StatelessWidget {
  ShippingConfiguration({
    this.setInfo,
    this.setPayment,
    this.personalData,
  });
  final _formKey = GlobalKey<FormState>();
  final Function setInfo;
  final Function setPayment;
  PersonalData personalData;
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                color: Colors.white,
                icon: Icons.person,
                hintText: 'Ime i prezime',
                value: personalData.ime,
                onChanged: (value) => {personalData.ime = value},
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.phone,
                hintText: 'Kontakt Telefon',
                value: personalData.kontakt,
                onChanged: (value) => {personalData.kontakt = value},
              ),
              if (size.width > 800) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RoundedInputField(
                        color: Colors.white,
                        icon: Icons.location_city_rounded,
                        hintText: 'Grad i postanski broj',
                        value: personalData.postanskiBroj,
                        onChanged: (value) =>
                            {personalData.postanskiBroj = value},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RoundedInputField(
                        color: Colors.white,
                        icon: Icons.location_on,
                        hintText: 'Adresa i broj',
                        value: personalData.adresa,
                        onChanged: (value) => {personalData.adresa = value},
                      ),
                    ),
                  ],
                ),
              ] else ...[
                RoundedInputField(
                  color: Colors.white,
                  icon: Icons.location_city_rounded,
                  hintText: 'Grad i postanski broj',
                  value: personalData.postanskiBroj,
                  onChanged: (value) => {personalData.postanskiBroj = value},
                ),
                RoundedInputField(
                  color: Colors.white,
                  icon: Icons.location_on,
                  hintText: 'Adresa i broj',
                  value: personalData.adresa,
                  onChanged: (value) => {personalData.adresa = value},
                ),
              ],
              RoundedInputField(
                color: Colors.white,
                icon: Icons.superscript,
                hintText: 'Nesto fali, ne znam sta',
                value: personalData.opis,
                onChanged: (value) => {personalData.opis = value},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: null,
                    disabledColor: Colors.grey,
                    child: Row(children: [
                      Icon(Icons.arrow_back_rounded),
                      Text("Nazad")
                    ]),
                    color: Colors.purple,
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    onPressed: () {
                      setInfo(
                        ime: personalData.ime,
                        kontakt: personalData.kontakt,
                        adresa: personalData.adresa,
                        postanskiBroj: personalData.postanskiBroj,
                        opis: personalData.opis,
                      );
                      setPayment(true);
                    },
                    child: Row(children: [
                      Text("Dalje"),
                      Icon(Icons.arrow_forward_rounded)
                    ]),
                    color: Colors.purple,
                    textColor: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
