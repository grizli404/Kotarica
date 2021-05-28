import 'package:app/components/product_card.dart';
import 'package:app/components/progress_hud.dart';
import 'package:app/screens/home/components/productView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../model/listaZeljaModel.dart';
import '../../../model/proizvodiModel.dart';

class FavoritesBody extends StatefulWidget {
  List<Proizvod> listaOmiljenihProizvoda;
  List<int> listaIndeksaOmiljenihProizvoda;
  ProizvodiModel pModel;
  ListaZeljaModel lz;
  //ListaZeljaModel lzModel;
  @override
  State<FavoritesBody> createState() => _FavoritesBodyState();
}

class _FavoritesBodyState extends State<FavoritesBody> {
  bool inAsyncCall = true;
  Future setup() async {
    print("here1");

    try {
      if (inAsyncCall == false)
        setState(() {
          inAsyncCall = true;
        });
      if (widget.listaIndeksaOmiljenihProizvoda != null)
        widget.listaIndeksaOmiljenihProizvoda.clear();
      if (widget.listaIndeksaOmiljenihProizvoda != null)
        widget.listaOmiljenihProizvoda.clear();
      widget.listaOmiljenihProizvoda = [];
      widget.listaIndeksaOmiljenihProizvoda = [];

      if (widget.pModel == null)
        widget.pModel = Provider.of<ProizvodiModel>(context);
      if (widget.lz == null) widget.lz = Provider.of<ListaZeljaModel>(context);
      await widget.lz.dajLajkove(korisnikInfo.id);
      widget.listaIndeksaOmiljenihProizvoda =
          widget.lz.listaLajkovanihProizvoda;
      print('indeks ' + widget.listaIndeksaOmiljenihProizvoda[0].toString());
      for (int i = 0; i < widget.listaIndeksaOmiljenihProizvoda.length; i++) {
        // if (widget.listaIndeksaOmiljenihProizvoda[i] != null) {
        // Proizvod p = widget.pModel
        //     .dajProizvodZaId(widget.listaIndeksaOmiljenihProizvoda[i]);
        // if (p != null) {
        print("pre proizvoda");
        Proizvod p = new Proizvod();
        p = widget.pModel
            .dajProizvodZaId(widget.listaIndeksaOmiljenihProizvoda[i]);
        print("posle proizvoda " + p.naziv);
        widget.listaOmiljenihProizvoda.add(p);
        print('proizvod ' + p.naziv);
        print("dodat");
        // }
      }

      for (int i = 0; i < widget.listaOmiljenihProizvoda.length; i++) {
        for (int j = i + 1; j < widget.listaOmiljenihProizvoda.length; j++) {
          if (widget.listaOmiljenihProizvoda[i].id ==
              widget.listaOmiljenihProizvoda[j].id) {
            print("uklanjam " + widget.listaOmiljenihProizvoda[j].naziv);
            widget.listaOmiljenihProizvoda
                .remove(widget.listaOmiljenihProizvoda[j]);
            j--;
          }
        }
      }
      print("proso omiljene");
      setState(() {
        inAsyncCall = false;
      });
    } catch (e) {
      print(e);
    }
    // print(listaOmiljenihProizvoda[i].naziv);
  }

//  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.listaOmiljenihProizvoda == null ||
        widget.lz == null ||
        widget.pModel == null ||
        widget.listaIndeksaOmiljenihProizvoda == null) setup();
  }

  @override
  void didUpdateWidget(covariant FavoritesBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    this.widget.listaOmiljenihProizvoda = oldWidget.listaOmiljenihProizvoda;
    this.widget.lz = oldWidget.lz;
    this.widget.pModel = oldWidget.pModel;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _build(context), inAsyncCall: inAsyncCall);
  }

  Widget _build(BuildContext context) {
    if (inAsyncCall == true ||
        widget.lz == null ||
        widget.pModel == null ||
        widget.listaIndeksaOmiljenihProizvoda == null ||
        widget.listaOmiljenihProizvoda == null) {
      return Container();
    } else {
      return Container(
          //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //  child: Wrap(
          child: ProductView(listaProizvoda: widget.listaOmiljenihProizvoda));
//));
    }
  }
}
