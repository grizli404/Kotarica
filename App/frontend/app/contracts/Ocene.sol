// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Ocene{

    struct Ocena
    {
        int id;
        int idKupovine;
        int idProdavca;
        int idKategorije; //ovi podaci o proizvodu se ponavljaju zbog toga sto trenutno trebaju Maji 
        int idProizvoda;  
        int ocena;
    }

    int public brojOcena = 0;

    mapping (int => Ocena) public ocene;

    function dodajOcenu (int _idKupovine, int _idProdavca,int _idKategorije, int _idProizvoda, int _ocena) public 
    {
        brojOcena++;
        ocene[brojOcena] = Ocena(brojOcena, _idKupovine, _idProdavca,_idKategorije, _idProizvoda, _ocena);
    }


    //Funkcija vraca prosecnu ocenu za jedan proizvod
    //U flutter-u se rezultat mora podeliti sa 100
    //Npr. ako je prosek ocena 4.72 bice vracen rezultat 472
    function prosecnaOcenaZaProizvod (int _idProizvoda) public view returns (int)
    {
        int br = 0;
        int suma = 0;
        for (int i = 1; i <= brojOcena; i++) {
            if(_idProizvoda == ocene[i].idProizvoda)
            {
                suma += ocene[i].ocena;
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






