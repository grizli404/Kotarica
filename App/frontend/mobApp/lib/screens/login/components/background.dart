import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme == ColorScheme.dark()
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Theme.of(context).colorScheme == ColorScheme.dark()
                  ? "assets/images/main_top_dark.png"
                  : "assets/images/main_top.png",
              alignment: Alignment.topLeft,
            ),
            width: size.width * 0.35,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              Theme.of(context).colorScheme == ColorScheme.dark()
                  ? "assets/images/login_bottom_dark.png"
                  : "assets/images/login_bottom.png",
              alignment: Alignment.bottomRight,
            ),
            width: size.width * 0.35,
          ),
          child,
        ],
      ),
    );
  }
}
