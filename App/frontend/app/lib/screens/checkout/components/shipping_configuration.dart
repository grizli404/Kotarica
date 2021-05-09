import 'package:app/components/rounded_input_field.dart';
import 'package:app/constants.dart';
import 'package:app/main.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:app/model/personal_data.dart';
import 'package:flutter/material.dart';

class ShippingConfiguration extends StatefulWidget {
  ShippingConfiguration({
    this.personalData,
    this.korisnik,
  });
  PersonalData personalData;
  Korisnik korisnik;

  @override
  _ShippingConfigurationState createState() => _ShippingConfigurationState();
}

class _ShippingConfigurationState extends State<ShippingConfiguration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('ISPORUKA:'),
                if (isWeb == true) ...[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedInputField(
                          sizeQ: 0.39,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.dark()
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          icon: Icons.person,
                          hintText: 'Ime',
                          value: widget.korisnik.ime,
                          onChanged: (value) {
                            widget.korisnik.ime = value;
                          },
                        ),
                        RoundedInputField(
                          sizeQ: 0.39,
                          color: Theme.of(context).colorScheme ==
                                  ColorScheme.dark()
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          icon: Icons.person,
                          hintText: 'Prezime',
                          value: widget.korisnik.prezime,
                          onChanged: (value) {
                            widget.korisnik.prezime = value;
                          },
                        ),
                      ],
                    ),
                  )
                ] else ...[
                  RoundedInputField(
                    color: Theme.of(context).colorScheme == ColorScheme.dark()
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    icon: Icons.person,
                    hintText: 'Ime',
                    value: widget.korisnik.ime,
                    onChanged: (value) {
                      widget.korisnik.ime = value;
                    },
                  ),
                  RoundedInputField(
                    color: Theme.of(context).colorScheme == ColorScheme.dark()
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    icon: Icons.person,
                    hintText: 'Prezime',
                    value: widget.korisnik.prezime,
                    onChanged: (value) {
                      widget.korisnik.prezime = value;
                    },
                  ),
                ],
                RoundedInputField(
                  color: Theme.of(context).colorScheme == ColorScheme.dark()
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  icon: Icons.phone,
                  hintText: 'Kontakt Telefon',
                  value: widget.korisnik.brojTelefona,
                  onChanged: (value) {
                    widget.korisnik.brojTelefona = value;
                  },
                ),
                RoundedInputField(
                  color: Theme.of(context).colorScheme == ColorScheme.dark()
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  icon: Icons.location_city_rounded,
                  hintText: 'Grad i postanski broj',
                  value: widget.korisnik.adresa,
                  onChanged: (value) {
                    widget.korisnik.adresa = value;
                  },
                ),
                // RoundedInputField(
                //   color: Theme.of(context).colorScheme == ColorScheme.dark()
                //       ? Theme.of(context).primaryColor
                //       : Colors.white,
                //   icon: Icons.superscript,
                //   hintText: 'Nesto fali, ne znam sta',
                //   value: widget.personalData.opis,
                //   onChanged: (value) {
                //     widget.personalData.opis = value;
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
