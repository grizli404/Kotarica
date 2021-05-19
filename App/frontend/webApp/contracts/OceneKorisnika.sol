// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract OceneKorisnika{

    struct Ocena2
    {
        int id;
        int idKupca;
        int idProdavca;
        int ocena;
    }

    int public brojOcena = 0;

    mapping (int => Ocena2) public ocene2;

    function dodajOcenu (int _idKupca, int _idProdavca, int _ocena) public 
    {
        brojOcena++;
        ocene2[brojOcena] = Ocena2(brojOcena, _idKupca, _idProdavca, _ocena);
    }


    //Funkcija vraca prosecnu ocenu svih ocena koje su date odredjenom prodavcu
    //U flutter-u se rezultat mora podeliti sa 100
    //Npr. ako je prosek ocena 4.72 bice vracen rezultat 472
    function prosecnaOcenaZaProdavca (int _idProdavca) public view returns (int)
    {
        int br = 0;
        int suma = 0;
        for (int i = 1; i <= brojOcena; i++) {
            if(_idProdavca == ocene2[i].idProdavca)
            {
                suma += ocene2[i].ocena;
                br++;
            }
        }
        suma = suma * 100;
        if(suma != 0 && br != 0)
        {
            int prosek = suma/br;
            return prosek;
        }
        return 0;
    }
}






