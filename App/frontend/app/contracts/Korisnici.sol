// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Korisnici{

    struct Korisnik{
        uint id;
        string username;
        string password;
        string ime;
        string prezime;
        string mejl;
        uint brojTelefona;
        string adresa;
    }

    uint public brojKorisnika = 0;

    mapping (uint => Korisnik) public korisnici;

    function dodajKorisnika (string memory _username, string memory _password, string memory _ime, string memory _prezime, string memory _mejl, uint _brojTelefona, string memory _adresa) public
    {
        brojKorisnika++;
        korisnici[brojKorisnika] = Korisnik(brojKorisnika, _username, _password, _ime, _prezime, _mejl, _brojTelefona, _adresa);
    }

    function prijavljivanje (string memory _username, string memory _password) public view returns (bool)
    {
        for (uint i = 0; i < brojKorisnika; i++) {
            if(keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(korisnici[i].username)) && keccak256(abi.encodePacked(_password)) == keccak256(abi.encodePacked(korisnici[i].password)))
                return true;
        }
        return false;
    }

    function obrisiKorisnika (uint _id) public
    {
        korisnici[brojKorisnika].id = korisnici[_id].id;
        korisnici[_id] = korisnici[brojKorisnika];
        Korisnik memory k = Korisnik(0, "", "", "", "", "", 0, "");
        korisnici[brojKorisnika] = k;
        brojKorisnika--;
    }
}