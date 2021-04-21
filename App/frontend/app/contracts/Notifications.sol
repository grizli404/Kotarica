// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Notifications {

    struct Notification{
        int id;
        int idKorisnika;
        int idProizvoda;
        string poruka;
        bool procitana;
    }

    int public brojNotifikacija = 0;

    mapping (int => Notification) public notifikacije;

    function dodajNotifikaciju(int _idKorisnika,int  _idProizvoda, string memory _poruka) public returns(int) {
        brojNotifikacija++;
        notifikacije[brojNotifikacija] = Notification(brojNotifikacija, _idKorisnika, _idProizvoda, _poruka, false);
        return brojNotifikacija;
    }

}