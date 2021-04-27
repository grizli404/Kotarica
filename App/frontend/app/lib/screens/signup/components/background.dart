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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme == ColorScheme.dark()
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              alignment: Alignment.topLeft,
            ),
            width: size.width * 0.35,
            height: size.height * 0.35,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              // Theme.of(context).colorScheme == ColorScheme.dark()
              //     ? ""
              //:
              "assets/images/main_bottom.png",
              alignment: Alignment.bottomLeft,
            ),
            width: size.width * 0.35,
            height: size.height * 0.35,
          ),
          child,
        ],
      ),
    );
  }
}
