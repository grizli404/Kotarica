import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // Future procitajPodatke() async {
    //   var token = await FlutterSession().get('email');
    //   return token.toString();
    // }

    // var token;
    // procitajPodatke().then((value) {
    //   token = value;
    // });

    return AppBar(
      elevation: 0,
      leading: ResponsiveLayout.isIphone(context)
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset('assets/icons/menu.svg'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )
          : null,
      actions: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  text: 'Kotarica',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/home');
                    }),
            ),
            IconButton(
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {
                  if (korisnikInfo != null) {
                    Navigator.pushNamed(context, '/profile');
                  } else {
                    Navigator.pushNamed(context, '/login');
                  }
                }),
            // strana za profil

            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/cart', arguments: {});
              }, // korpa
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
