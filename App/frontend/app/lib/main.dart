// ignore: unused_import
import 'package:app/model/kategorijeModel.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:app/screens/home/homeScreen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/profile/profile_screen.dart';
import 'package:app/screens/signup/signup_screen.dart';
import 'package:app/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
//import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'model/korisniciModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //var korisnici = KorisniciModel();
    //var kategorije = KategorijeModel();
    //var proizvodi = ProizvodiModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProizvodiModel()),
        ChangeNotifierProvider(create: (context) => KategorijeModel()),
      ],
      child: MaterialApp(
        routes: {
          '/login': (context) => LoginScreen(),
          '/welcome': (context) => WelcomeScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
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
