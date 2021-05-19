import 'package:app/model/proizvodiModel.dart';

List<Proizvod> filterFunction(int min, int max, List<Proizvod> lista) {
  print(min);
  print(max);
  List<Proizvod> filterResults = [];
  filterResults.clear();
  filterResults = lista
      .where((element) => element.cena >= min && element.cena <= max)
      .toList();
  return filterResults;
}
