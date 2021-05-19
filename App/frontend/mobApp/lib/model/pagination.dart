import 'package:app/model/proizvodiModel.dart';

//Proslediti koliko proizvoda zelite da se prikazuje po jednoj strani i listu svih proizvoda
//funkcija vraca koliko ce strana ukupno biti

Future<int> brojStrana(int _brProizvodaPoStrani, List<Proizvod> lista) {
  var brStrana;
  var ukupanBrojProizvoda = lista.length;
  brStrana = ukupanBrojProizvoda / _brProizvodaPoStrani;
  brStrana = brStrana.ceil();
  return brStrana;
}

//Funkciji se prosledjuje broj strane koja treba da bude ucitana, broj proizvoda koji treba da bude prikazan na toj strani
//i listu svih proizvoda
//funkcija vraca listu proizvoda koji treba da budu prikazani na toj strani
//Ukoliko nema dovoljno proizvoda koliko se trazi, bice vraceno onoliko koliko ima

List<Proizvod> paginacija(
    int _brStrane, int _brProizvodaPoStrani, List<Proizvod> lista) {
  List<Proizvod> paginationList = [];
  paginationList.clear();
  var p = _brProizvodaPoStrani * _brStrane;
  if (lista.length > p) {
    for (var i = p - _brProizvodaPoStrani; i < p; i++) {
      paginationList.add(lista[i]);
      print(paginationList[paginationList.length - 1].naziv);
    }
  } else {
    for (var i = p - _brProizvodaPoStrani; i < (lista.length); i++) {
      paginationList.add(lista[i]);
      print(paginationList[paginationList.length - 1].naziv);
    }
  }
  return paginationList;
}
