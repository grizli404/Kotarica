// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Proizvodi{

    event smanji(bool);

    struct Proizvod{
        uint id;
        uint idKorisnika;
        string idKategorije; // idKategorije|idPotkategorije
        string naziv;
        uint kolicina;
        string cena; // cena|jedinica
        string slika; //slika|slika|slika
	    string opis;
    }

    uint public brojProizvoda = 0;

    mapping (uint => Proizvod) public proizvodi;
    mapping (uint => uint[]) proizvodiKorisnika;

    function dodajProizvod(uint _idKorisnika, string memory _idKategorije, string memory _naziv, uint _kolicina, string memory _cena, string memory _slika, string memory _opis) public
    {
        brojProizvoda++;
        proizvodi[brojProizvoda] = Proizvod(brojProizvoda, _idKorisnika, _idKategorije, _naziv, _kolicina, _cena, _slika, _opis);
        proizvodiKorisnika[_idKorisnika].push(brojProizvoda);
    }

    function dajProizvodeZaKorisnika(uint korisnikID) view public returns(uint[] memory) {
        return proizvodiKorisnika[korisnikID];
    }

    function izmeniKolicinu(uint _id, uint _promenaKolicine) public
    {
        proizvodi[_id].kolicina = proizvodi[_id].kolicina + _promenaKolicine;
    }

    function obrisiProizvod (uint _id) public
    {
        proizvodi[brojProizvoda].id = proizvodi[_id].id;
        proizvodi[_id] = proizvodi[brojProizvoda];
        Proizvod memory p = Proizvod(0, 0, "", "", 0, "", "", "");
        proizvodi[brojProizvoda] = p;
        brojProizvoda--;
    }
    
    //Ako ima doboljno proizvoda na stanju skine koliko je naruceno i vrati true
    //Ako nema dovoljno proizvoda na stanju samo vrati false
    function smanjiPrilikomKupovine(uint _id, uint _kolicina) public {
        bool moguce = false;
        if(proizvodi[_id].kolicina - _kolicina >= 0) {
            proizvodi[_id].kolicina = proizvodi[_id].kolicina - _kolicina;
            moguce = true;
        }
        
        emit smanji(moguce);
    }
    
}