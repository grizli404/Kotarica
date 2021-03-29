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
        //moguce da ce trebati datum
    }

    int public brojKupovina = 0;

    mapping (int => Kupovina) public kupovine;

    function dodajKupovinu (int _idProdavca, int _idKupca, int _idProizvoda, int _kolicina) public 
    {
        brojKupovina++;
        kupovine[brojKupovina] = Kupovina(brojKupovina, _idProdavca, _idKupca, _idProizvoda, _kolicina);
    }


}