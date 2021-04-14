// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Korisnici{

    event LoginAttempt(address sender, string challenge);

    struct Korisnik{
        int id;
        string mejl;
        string password;
        string ime;
        string prezime;
        string brojTelefona;
        string adresa;
    }

    int public brojKorisnika = 0;

    mapping (int => Korisnik) public korisnici;
    mapping (string => Korisnik) public korisniciMail;

    function dodajKorisnika (string memory _mejl, string memory _password, string memory _ime, string memory _prezime, string memory _brojTelefona, string memory _adresa) public returns(int)
    {
        brojKorisnika++;
        korisnici[brojKorisnika] = Korisnik(brojKorisnika, _mejl, _password, _ime, _prezime, _brojTelefona, _adresa);
        korisniciMail[_mejl] = Korisnik(brojKorisnika, _mejl, _password, _ime, _prezime, _brojTelefona, _adresa);
        return brojKorisnika;
    }

    //Prilikom pravljenja novog naloga moramo da proverimo da li taj korisnik vec postoji
    function proveriUsername(string memory _username) view public returns(int) {
        for (int i = 1; i <= brojKorisnika; i++) {
            if( keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(korisnici[i].mejl)) ) {
                return 0;
            }
        }
        return 1;
    }

    function prijavljivanje (string memory _username, string memory _password) public view returns (int)
    {
        bool nasao = false;
        for (int i = 1; i <= brojKorisnika; i++) {
            if(keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(korisnici[i].mejl)) && keccak256(abi.encodePacked(_password)) == keccak256(abi.encodePacked(korisnici[i].password))) {
                nasao = true;
            }
        }

        if(nasao){
            emit LoginAttempt(msg.sender, _password);
            return 1;
        }
        return 0;
    }

    //da se zavrsi
    /*function izmeniPassword (int _id, string memory _stariPassword, string memory _noviPassword) public
    {
        korisnici[_id].password = _password;
    }*/

    function izmeniKorisnika (int _id, string memory _ime, string memory _prezime, string memory _broj, string memory _adresa) public
    {
        korisnici[_id].ime = _ime;
        korisnici[_id].prezime = _prezime;
        korisnici[_id].brojTelefona = _broj;
        korisnici[_id].adresa = _adresa;
    }
}