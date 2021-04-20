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
        uint cena;
        string opis;
    }

    uint public brojProizvoda = 0;

    mapping (uint => Proizvod) public proizvodi;
    mapping (uint => uint[]) proizvodiKorisnika;

    function dodajProizvod(uint _idKorisnika, uint _idKategorije, string memory _naziv, uint _kolicina, uint _cena, string memory _opis) public
    {
        brojProizvoda++;
        proizvodi[brojProizvoda] = Proizvod(brojProizvoda, _idKorisnika, _idKategorije, _naziv, _kolicina, _cena, _opis);
        proizvodiKorisnika[_idKorisnika].push(brojProizvoda);
    }

    function dajProizvodeZaKorisnika(uint korisnikID) view public returns(uint[] memory) {
        return proizvodiKorisnika[korisnikID];
    }

    function izmeniKolicinu(uint _id, uint _promenaKolicine) public
    {
        proizvodi[_id].kolicina += _promenaKolicine;
    }

    function obrisiProizvod (uint _id) public
    {
        proizvodi[brojProizvoda].id = proizvodi[_id].id;
        proizvodi[_id] = proizvodi[brojProizvoda];
        Proizvod memory p = Proizvod(0, 0, 0, "", 0, 0, "");
        proizvodi[brojProizvoda] = p;
        brojProizvoda--;
    }


    uint[] arr;

    function search(string memory substring) public returns(uint[] memory) {

        bytes memory whatBytes = bytes (substring);

        for (uint i = 1; i <= brojProizvoda; i++) {
            bytes memory whereBytes = bytes (proizvodi[i].naziv);

            bool found = false;
            for (uint j = 0; j < (whereBytes.length - whatBytes.length); j++) {
                bool flag = true;
                for (uint k = 0; k < whatBytes.length; k++)
                    if(whereBytes [j + k] != whatBytes[k]) {
                        flag = false;
                        break;
                    }
                
                if(flag) {
                    found = true;
                    uint pomId = proizvodi[i].id;
                    arr.push(pomId); 
                    break;
                }
            }
        }
        if(arr.length != 0)
            return arr;
        else
        {
            arr.push(0);
            return arr;
        }
    }


    //Funkcija vraca ID-jeve proizvoda ciji je redni broj u odredjenim granicama
    //Koristice se tako sto ce se brojProizvodaPoStrani staviti na primer na 10
    //a broj strane na 1, rezultat ce biti prvih 10 proizvoda
    //broj strane 2, drugih 10 proizvoda
    uint[] public produkti;

    function pagination(uint _brojStrane, uint _brojProizvodaPoStrani) public returns (uint[] memory) {

        for(uint i = _brojProizvodaPoStrani * _brojStrane - _brojProizvodaPoStrani; i < _brojProizvodaPoStrani * _brojStrane; i++ ){
            uint idProizvoda = proizvodi[i].id;
            produkti.push(idProizvoda);
        } 
        return produkti;
    }
}