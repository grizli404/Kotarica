// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Proizvodi{

    struct Proizvod{
        int id;
        int idKorisnika;
        int idKategorije;
        string naziv;
        uint kolicina;
        uint cena;
    }

    int public brojProizvoda = 0;

    mapping (int => Proizvod) public proizvodi;
    mapping (int => int[]) proizvodiKorisnika;

    function dodajProizvod(int _idKorisnika, int _idKategorije, string memory _naziv, uint _kolicina, uint _cena) public
    {
        brojProizvoda++;
        proizvodi[brojProizvoda] = Proizvod(brojProizvoda, _idKorisnika, _idKategorije, _naziv, _kolicina, _cena);
        proizvodiKorisnika[_idKorisnika].push(brojProizvoda);
    }

    function dajProizvodeZaKorisnika(int korisnikID) view public returns(int[] memory) {
        return proizvodiKorisnika[korisnikID];
    }

    function izmeniKolicinu(int _id, uint _promenaKolicine) public
    {
        proizvodi[_id].kolicina += _promenaKolicine;
    }
}