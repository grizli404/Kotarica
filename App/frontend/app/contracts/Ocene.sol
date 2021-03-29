// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Ocene{

    struct Ocena
    {
        int id;
        int idKupovine;
        int idKategorije; //ovi podaci o proizvodu se ponavljaju zbog toga sto trenutno trebaju Maji 
        int idProizvoda;  //da bi pocela svoj rad na vreme, bice reseno drugacije kada vidimo koji je najbolji nacin
        int ocena;
        string komentar;
    }

    int public brojOcena = 0;

    mapping (int => Ocena) public ocene;

    function dodajOcenu (int _idKupovine, int _idKategorije, int _idProizvoda, int _ocena, string memory _komentar) public 
    {
        brojOcena++;
        ocene[brojOcena] = Ocena(brojOcena, _idKupovine, _idKategorije, _idProizvoda, _ocena, _komentar);
    }

}