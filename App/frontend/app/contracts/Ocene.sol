// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Ocene{

    struct Ocena
    {
        int id;
        int idKupovine;
        int idProdavca;
        int idKategorije; //ovi podaci o proizvodu se ponavljaju zbog toga sto trenutno trebaju Maji 
                          //da bi pocela svoj rad na vreme, bice reseno drugacije kada vidimo koji je najbolji nacin
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
    function prosecnaOcenaZaProizvod (int _idProizvoda) public view returns (int)
    {
        int br = 0;
        int sum = 0;
        for (int i = 1; i <= brojOcena; i++) {
            if(_idProizvoda == ocene[i].idProizvoda)
            {
                sum += ocene[i].ocena;
                br++;
            }
        }
        sum *= 100;
        if(sum != 0 && br != 0)
        {
            int avg = sum/br;
            return avg;
        }
        return 0;
    }


    //Funkcija vraca prosecnu ocenu svih ocena koje su date proizvodima odredjenog prodavca
    //U flutter-u se rezultat mora podeliti sa 100
    function prosecnaOcenaZaProdavca (int _idProdavca) public view returns (int)
    {
        int br = 0;
        int sum = 0;
        for (int i = 1; i <= brojOcena; i++) {
            if(_idProdavca == ocene[i].idProdavca)
            {
                sum += ocene[i].ocena;
                br++;
            }
        }
        sum *= 100;
        if(sum != 0 && br != 0)
        {
            int avg = sum/br;
            return avg;
        }
        return 0;
    }
}






