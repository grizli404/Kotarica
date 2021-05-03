// ignore: unused_import
import 'package:app/model/kategorijeModel.dart';
import 'package:app/model/listaZeljaModel.dart';
import 'package:app/model/oceneModel.dart';
import 'package:app/model/personal_data.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/cart/cart_screen.dart';
import 'package:app/screens/checkout/checkout_screen.dart';
import 'package:app/screens/conversation/conversation_screen.dart';
import 'package:app/screens/favorites/favorites_screen.dart';
import 'package:app/screens/home/homeScreen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/signup/signup_screen.dart';
import 'package:app/screens/welcome/welcome_screen.dart';
import 'package:app/theme/themeProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
//import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'model/korisniciModel.dart';
import 'screens/add_product/add_product.dart';
import 'screens/profile/my_profile_screen.dart';

void main() {
  runApp(MyApp());
}

Korisnik korisnikInfo;

bool isWeb;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Future setujSesiju() async {
  //   var token = await FlutterSession().get('email');
  //   if (token == '') await FlutterSession().set('email', '');
  //   return token;
  // }
  
  //KorisniciModel km = KorisniciModel();
  //ListaZeljaModel lzm = new ListaZeljaModel();

  @override
  Widget build(BuildContext context) {
    kIsWeb ? isWeb = true : isWeb = false;
    // print(FlutterSession().get('email').toString());
    var korisnici = KorisniciModel();
    //var kategorije = KategorijeModel();
    //var proizvodi = ProizvodiModel();
    //var ocene = OceneModel();
    //var lista = ListaZeljaModel();
    // setujSesiju();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => KorisniciModel()),
        ChangeNotifierProvider(create: (context) => ProizvodiModel()),
        ChangeNotifierProvider(create: (context) => KategorijeModel()),
        ChangeNotifierProvider(create: (context) => OceneModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ListaZeljaModel()),
      ],
      child: MaterialAppCustom(),
    );
  }
}

class MaterialAppCustom extends StatelessWidget {
  const MaterialAppCustom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      routes: {
        '/login': (context) => LoginScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => MyProfileScreen(),
        '/checkout': (context) => CheckoutScreen(
            korisnik: korisnikInfo,
            personalData: PersonalData(
                adresa: "Novosadska",
                ime: "Nikola",
                kontakt: "0629756150",
                opis: "opis",
                postanskiBroj: "Kragujevac 34000",
                privateKey: "089ywegrxzch-qw9ytpbhgpwe9")),
        '/cart': (context) => CartScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/addProduct': (context) => AddProduct()
      },
      debugShowCheckedModeBanner: false,
      title: 'Kotarica',
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: HomeScreen(),
    );
  }
}
