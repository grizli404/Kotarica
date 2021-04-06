// ignore: unused_import
import 'package:app/model/kategorijeModel.dart';
import 'package:app/model/oceneModel.dart';
import 'package:app/model/personal_data.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/cart/cart_screen.dart';
import 'package:app/screens/checkout/checkout_screen.dart';
import 'package:app/screens/home/homeScreen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/signup/signup_screen.dart';
import 'package:app/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
//import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'model/korisniciModel.dart';
import 'screens/profile/my_profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future setujSesiju() async {
    var token = await FlutterSession().get('email');
    if (token != '') await FlutterSession().set('email', '');
  }

  @override
  Widget build(BuildContext context) {
    setujSesiju();
    // print(FlutterSession().get('email').toString());
    //var korisnici = KorisniciModel();
    //var kategorije = KategorijeModel();
    //var proizvodi = ProizvodiModel();
    //var ocene = OceneModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => KorisniciModel()),
        ChangeNotifierProvider(create: (context) => ProizvodiModel()),
        ChangeNotifierProvider(create: (context) => KategorijeModel()),
      ],
      child: MaterialApp(
        routes: {
          '/login': (context) => LoginScreen(),
          '/welcome': (context) => WelcomeScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => MyProfileScreen(),
          '/checkout': (context) => CheckoutScreen(
              personalData: PersonalData(
                  adresa: "Novosadska",
                  ime: "Nikola",
                  kontakt: "0629756150",
                  opis: "opis",
                  postanskiBroj: "Kragujevac 34000",
                  privateKey: "089ywegrxzch-qw9ytpbhgpwe9")),
          '/cart': (context) => CartScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Kotarica',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryLightColor,
          // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
