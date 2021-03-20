// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Proizvodi{

    struct Proizvod{
        uint id;
        uint idKorisnika;
        uint idKategorije;
        string naziv;
        uint kolicina;
    }

    uint public brojProizvoda = 0;

    mapping (uint => Proizvod) public proizvodi;

    function dodajProizvod(uint _idKorisnika, uint _idKategorije, string memory _naziv, uint _kolicina) public
    {
        brojProizvoda++;
        proizvodi[brojProizvoda] = Proizvod(brojProizvoda, _idKorisnika, _idKategorije, _naziv, _kolicina);
    }

    function dajProizvod (uint _id) public view returns (Proizvod memory)
    {
        return proizvodi[_id];
    }

    function dajProizvode () public view returns (Proizvod[] memory)
    {
        Proizvod[] memory sviProizvodi = new Proizvod[](brojProizvoda);
        for(uint i = 0; i < brojProizvoda; i++)
        {
            Proizvod storage proizvod = proizvodi[i];
            sviProizvodi[i] = proizvod;
        }
        return sviProizvodi;
    }

    function izmeniKolicinu(uint _id, uint _promenaKolicine) public
    {
        proizvodi[_id].kolicina += _promenaKolicine;
    }
}