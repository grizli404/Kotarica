import 'package:app/components/responsive_layout.dart';
import 'package:app/main.dart';
import 'package:app/model/cart.dart';
import 'package:app/screens/notifications/notification_screen.dart';
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
            if (!isWeb) ...[
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
                  )),
            ],
            !ResponsiveLayout.isIphone(context)
                ? IconButton(
                    icon: Icon(
                      Icons.person_outline,
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
                    Icons.notifications_none_rounded,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NotificationScreen();
                        },
                      ),
                    );
                  }),
            ],
            !ResponsiveLayout.isIphone(context)
                ? IconButton(
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/favorites');
                    })
                : Container(),
            if (isWeb)
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  }),
            if (korisnikInfo != null && ResponsiveLayout.isIphone(context))
              CartIcon(),
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

class CartIcon extends StatefulWidget {
  const CartIcon({
    Key key,
  }) : super(key: key);

  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
        icon: Icon(
          Icons.shopping_cart_outlined,
        ),
        onPressed: () {
          setCartIcon();
          Navigator.of(context).pushNamed('/cart');
        },
      ),
      Positioned(
        right: 7,
        top: 5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey),
          child: Text(
            demoCarts.length.toString(),
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      )
    ]);
  }

  void setCartIcon() {
    setState(() {});
  }
}
