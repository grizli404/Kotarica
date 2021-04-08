import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class ShippingConfiguration extends StatefulWidget {
  ShippingConfiguration({
    this.personalData,
  });
  PersonalData personalData;

  @override
  _ShippingConfigurationState createState() => _ShippingConfigurationState();
}

class _ShippingConfigurationState extends State<ShippingConfiguration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              RoundedInputField(
                color: Colors.white,
                icon: Icons.person,
                hintText: 'Ime i prezime',
                value: widget.personalData.ime,
                onChanged: (value) {
                  widget.personalData.ime = value;
                },
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.phone,
                hintText: 'Kontakt Telefon',
                value: widget.personalData.kontakt,
                onChanged: (value) {
                  widget.personalData.kontakt = value;
                },
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.location_city_rounded,
                hintText: 'Grad i postanski broj',
                value: widget.personalData.postanskiBroj,
                onChanged: (value) {
                  widget.personalData.postanskiBroj = value;
                },
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.location_on,
                hintText: 'Adresa i broj',
                value: widget.personalData.adresa,
                onChanged: (value) {
                  widget.personalData.adresa = value;
                },
              ),
              RoundedInputField(
                color: Colors.white,
                icon: Icons.superscript,
                hintText: 'Nesto fali, ne znam sta',
                value: widget.personalData.opis,
                onChanged: (value) {
                  widget.personalData.opis = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
