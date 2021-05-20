// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Kategorije {
    
    struct Kategorija
    {
        int id;
        int idRoditelja;
        string naziv;
    }

    int public brojKategorija = 0;

    mapping(int => Kategorija) public kategorije;

    function dodajKategoriju(int _idRoditelja, string memory _naziv) public {
        brojKategorija++;
        kategorije[brojKategorija] = Kategorija(brojKategorija, _idRoditelja, _naziv);
    }
}