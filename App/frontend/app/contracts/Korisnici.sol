// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Korisnici{

    struct Korisnik{
        int id;
        string username;
        string password;
        string ime;
        string prezime;
        string mejl;
        string brojTelefona;
        string adresa;
    }

    int public brojKorisnika = 0;

    mapping (int => Korisnik) public korisnici;

    function dodajKorisnika (string memory _username, string memory _password, string memory _ime, string memory _prezime, string memory _mejl, string memory _brojTelefona, string memory _adresa) public returns(int)
    {
        brojKorisnika++;
        korisnici[brojKorisnika] = Korisnik(brojKorisnika, _username, _password, _ime, _prezime, _mejl, _brojTelefona, _adresa);
        return brojKorisnika;
    }

    //Prilikom pravljenja novog naloga moramo da proverimo da li taj korisnik vec postoji
    function proveriUsername(string memory _username) view public returns(int) {
        for (int i = 1; i <= brojKorisnika; i++) {
            if( keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(korisnici[i].username)) ) {
                return 0;
            }
        }
        return 1;
    }

    function prijavljivanje (string memory _username, string memory _password) public view returns (int)
    {
        for (int i = 1; i <= brojKorisnika; i++) {
            if(keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(korisnici[i].username)) && keccak256(abi.encodePacked(_password)) == keccak256(abi.encodePacked(korisnici[i].password)))
                return i;
        }
        return 0;
    }

    function obrisiKorisnika (int _id) public
    {
        korisnici[brojKorisnika].id = korisnici[_id].id;
        korisnici[_id] = korisnici[brojKorisnika];
        Korisnik memory k = Korisnik(0, "", "", "", "", "", "", "");
        korisnici[brojKorisnika] = k;
        brojKorisnika--;
    }

    function izmeniUsername (int _id, string memory _username) public
    {
        korisnici[_id].username = _username;
    }

    function izmeniPassword (int _id, string memory _password) public
    {
        korisnici[_id].password = _password;
    }
}