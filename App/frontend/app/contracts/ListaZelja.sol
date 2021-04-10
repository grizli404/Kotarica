// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ListaZelja {
    
    struct Zelja
    {
        int id;
        int idPotencijalnogKupca;
        int idProizvoda;
    }

    int public brojZelja = 0;

    mapping(int => Zelja) public zelje;

    function dodajZelju(int _idPotencijalnogKupca, int _idProizvoda) public {
        brojZelja++;
        zelje[brojZelja] = Zelja(brojZelja, _idPotencijalnogKupca, _idProizvoda);
    }
}