import 'package:app/model/proizvodiModel.dart';

List<Proizvod> searchFunction(String input, List<Proizvod> lista) {
  List<Proizvod> searchResults = [];
  searchResults.clear();
  for (Proizvod index in lista) {
    if (index.naziv.toLowerCase().contains(input.toLowerCase())) {
      searchResults.add(index);
      print(index.naziv);
    }
  }
  for (Proizvod p in searchResults) print("${p.naziv}");
  return searchResults;
}
