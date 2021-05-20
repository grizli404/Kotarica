import 'package:app/components/rounded_input_field.dart';
import 'package:app/main.dart';
import 'package:app/model/korisniciModel.dart';
import 'package:flutter/material.dart';

class ShippingConfiguration extends StatefulWidget {
  ShippingConfiguration({
    this.korisnik,
    this.formKey,
  });
  Korisnik korisnik;
  final formKey;
  @override
  _ShippingConfigurationState createState() => _ShippingConfigurationState();
}

class _ShippingConfigurationState extends State<ShippingConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: <Widget>[
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
                          validator: (input) => !(input.contains(RegExp(
                                  r"([^0-9\.\,\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+)")))
                              ? "Unesite regularno ime"
                              : null,
                          value: korisnikInfo.ime,
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
                          validator: (input) => !(input.contains(RegExp(
                                  r"([^0-9\.\,\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+)")))
                              ? "Unesite regularno prezime"
                              : null,
                          hintText: 'Prezime',
                          value: korisnikInfo.prezime,
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
                    value: korisnikInfo.ime,
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
                    value: korisnikInfo.prezime,
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
                  validator: (input) => !(input.contains(RegExp(
                          r"^\s*(?:\+?(\d{1,3}))?([-. (]*(\d{3})[-. )]*)?((\d{3})[-. ]*(\d{2,4})(?:[-.x ]*(\d+))?)\s*$")))
                      ? "Najmanje 5 cifara ili više"
                      : null,
                  value: korisnikInfo.brojTelefona,
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
                  validator: (input) => !(input.contains(RegExp(
                          r"(\w{1,}(\s|,){1,}[0-9]{1,}(\s|,){1,}[0-9]{5})")))
                      ? "Ulica, broj, postanski broj"
                      : null,
                  value: korisnikInfo.adresa,
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
