// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Notifications {

    struct Notification{
        uint id;
        uint idKorisnika;
        uint idProizvoda;
        string nazivProizvoda;
        uint kolicina;
        string ime; //Ime osobe koja je narucila proizvod
        string brojTelefona; // telefon osobe koja je narucila
        string adresa; // adresa gde treba da se isporuci
    }

    uint public brojPorudzbina = 0;

    mapping (uint => Notification) public notifikacije;

    function dodajNotifikaciju(uint _idKorisnika, uint  _idProizvoda, string memory _nazivProizvoda,
                                uint _kolicina, string memory _ime, string memory _telefon, string memory _adresa) public {
        brojPorudzbina++;
        notifikacije[brojPorudzbina] = Notification(
            brojPorudzbina,
            _idKorisnika,
            _idProizvoda,
            _nazivProizvoda,
            _kolicina,
            _ime,
            _telefon,
            _adresa
        );
    }

}