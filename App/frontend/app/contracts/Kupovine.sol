// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Kupovine{

    struct Kupovina
    {
        int id;
        int idProdavca;
        int idKupca;
        int idProizvoda;
        int kolicina;
    }

    int public brojKupovina = 0;

    mapping (int => Kupovina) public kupovine;

    function dodajKupovinu (int _idProdavca, int _idKupca, int _idProizvoda, int _kolicina) public 
    {
        brojKupovina++;
        kupovine[brojKupovina] = Kupovina(brojKupovina, _idProdavca, _idKupca, _idProizvoda, _kolicina);
    }

    //Pre davanja ocene za proizvod, mora se proveriti da li postoji kupovina tog proizvoda od strane onog koji hoce da da ocenu
    function daLiPostojiKupovina (int _idKupca, int _idProdavca, int _idProizvoda) public view returns (int)
    {
        for (int i = 1; i <= brojKupovina; i++) {
            if(_idKupca == kupovine[i].idKupca && _idProdavca == kupovine[i].idProdavca && _idProizvoda == kupovine[i].idProizvoda)
                return i;
        }
        return 0;
    }

    //Pre davanja ocene za prodavca, mora se proveriti da li postoji kupovina nekog proizvoda od strane onog koji hoce da da ocenu
    //od onog kome zeli da da ocenu
    function daLiPostojiKupovina (int _idKupca, int _idProdavca) public view returns (int)
    {
        for (int i = 1; i <= brojKupovina; i++) {
            if(_idKupca == kupovine[i].idKupca && _idProdavca == kupovine[i].idProdavca)
                return i;
        }
        return 0;
    }


}