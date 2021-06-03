import 'package:app/model/cart.dart';
import 'package:app/model/proizvodiModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NumberSelector extends StatefulWidget {
  @override
  final Proizvod proizvod;

  NumberSelector({this.proizvod});

  State<StatefulWidget> createState() {
    return TestState(proizvod: proizvod);
  }
}

class TestState extends State<NumberSelector> {
  int counter = 1;
  final Proizvod proizvod;

  TestState({
    this.proizvod,
  });

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Carts>(context, listen: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //if (!added) ...[
                Icon(Icons.shopping_basket,
                    color: Theme.of(context).iconTheme.color, size: 12.0),
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    cart.dodajProizvod(proizvod, counter);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: counter != 1
                            ? Text("Dodata " +
                                counter.toString() +
                                " proizvoda u korpu")
                            : Text("Dodat " +
                                counter.toString() +
                                " proizvod u korpu"),
                        duration: const Duration(milliseconds: 1500),
                        width: MediaQuery.of(context).size.width *
                            0.9, // Width of the SnackBar.
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              8.0, // Inner padding for SnackBar content.
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  },
                  child: Text('Dodaj u korpu',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 14.0)),
                ),
                //  ],
                // if (added) ...[

                // ]
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color:
                  counter > 1 ? Theme.of(context).iconTheme.color : Colors.grey,
              onPressed: counter > 1
                  ? () {
                      setState(() {
                        --counter;
                      });
                    }
                  : () {},
              icon: Icon(
                Icons.remove_circle_outline,
                size: 12.0,
              ),
            ),
            Text(
              counter.toString(),
              style: TextStyle(
                  fontFamily: 'Varela',
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
            IconButton(
              color: counter < widget.proizvod.kolicina
                  ? Theme.of(context).iconTheme.color
                  : Colors.grey,
              onPressed: counter < widget.proizvod.kolicina
                  ? () {
                      setState(() {
                        counter++;
                      });
                    }
                  : () {},
              icon: Icon(
                Icons.add_circle_outline,
                size: 12.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}
