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
          : new Container(),
      actions: [
        Row(
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                'Kotarica',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            !ResponsiveLayout.isIphone(context)
                ? IconButton(
                    icon: Icon(
                      Icons.person,
                    ),
                    onPressed: () {
                      if (korisnikInfo != null) {
                        Navigator.pushNamed(context, '/profile');
                      } else {
                        Navigator.pushNamed(context, '/login');
                      }
                    })
                : Container(),
            if (korisnikInfo != null && isWeb) ...[
              IconButton(
                  icon: Icon(
                    Icons.notifications_rounded,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }),
            ],
            !ResponsiveLayout.isIphone(context)
                ? IconButton(
                    icon: Icon(
                      Icons.favorite_rounded,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/favorites');
                    })
                : Container(),
            !ResponsiveLayout.isIphone(context)
                ? IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart', arguments: {});
                    }, // korpa
                  )
                : Container(),
            !ResponsiveLayout.isIphone(context)
                ? SizedBox(
                    width: 15,
                  )
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
