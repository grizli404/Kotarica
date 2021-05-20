// ignore: unused_import
import 'dart:io';

import 'package:app/model/kupovineModel.dart';
import 'package:app/screens/chats/chats_screen.dart';
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
import 'package:provider/provider.dart';
// ignore: unused_import
//import 'package:google_fonts/google_fonts.dart';

import 'model/cart.dart';
import 'model/korisniciModel.dart';
import 'model/notification_model.dart';
import 'screens/add_product/add_product.dart';
import 'screens/profile/my_profile_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

ListaZeljaModel listaZeljaModelMain = new ListaZeljaModel();
Korisnik korisnikInfo;
String url = '';
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
    if (kIsWeb) {
      url = 'http://147.91.204.116:11094/';
    } else {
      url = 'http://147.91.204.116:11094/';
    }
    kIsWeb ? isWeb = true : isWeb = false;
    // print(FlutterSession().get('email').toString());
    var korisnici = KorisniciModel();
    //var kategorije = KategorijeModel();
    var proizvodi = ProizvodiModel();
    //var ocene = OceneModel();
    //var lista = NotifikacijeModel();
    // setujSesiju();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Carts()),
        ChangeNotifierProvider(
          create: (context) => KorisniciModel(),
          lazy: true,
        ),
        ChangeNotifierProvider(create: (context) => ProizvodiModel()),
        ChangeNotifierProvider(create: (context) => KategorijeModel()),
        ChangeNotifierProvider(create: (context) => KupovineModel()),
        ChangeNotifierProvider(create: (context) => OceneModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ListaZeljaModel()),
      ],
      child: MaterialAppCustom(),
    );
  }
}

KorisniciModel korisniciModel = new KorisniciModel();
ProizvodiModel proizvodiModel = new ProizvodiModel();
KorisniciModel getKorisniciModel() {
  return korisniciModel;
}

ProizvodiModel getProizvodiModel() {
  return proizvodiModel;
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
        '/checkout': (context) => CheckoutScreen(),
        '/cart': (context) => CartScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/addProduct': (context) => AddProduct(),
        '/chats': (context) => ChatsScreen(),
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
