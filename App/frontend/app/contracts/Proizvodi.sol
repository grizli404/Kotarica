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
        string slika;
	    string opis;
    }

    uint public brojProizvoda = 0;

    mapping (uint => Proizvod) public proizvodi;
    mapping (uint => uint[]) proizvodiKorisnika;

    function dodajProizvod(uint _idKorisnika, uint _idKategorije, string memory _naziv, uint _kolicina, uint _cena, string memory _slika, string memory _opis) public
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
        proizvodi[_id].kolicina += _promenaKolicine;
    }

    function obrisiProizvod (uint _id) public
    {
        proizvodi[brojProizvoda].id = proizvodi[_id].id;
        proizvodi[_id] = proizvodi[brojProizvoda];
        Proizvod memory p = Proizvod(0, 0, 0, "", 0, 0, "", "");
        proizvodi[brojProizvoda] = p;
        brojProizvoda--;
    }
    
    
    
    function search(string memory substring) public returns(uint[] memory) {

        uint duzina = 0;

        uint[] memory arr = new uint[] (10);
        
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
                    duzina = duzina +1;
                    uint pomId = proizvodi[i].id;
                    arr[duzina] = pomId; 
                    break;
                }
            }
        }
        if(arr.length != 0)
            return arr;
        else
        {
            arr[0] = 0;
            return arr;
        }
    }


    //Funkcija vraca ID-jeve proizvoda ciji je redni broj u odredjenim granicama
    //Koristice se tako sto ce se brojProizvodaPoStrani staviti na primer na 10
    //a broj strane na 1, rezultat ce biti prvih 10 proizvoda
    //broj strane 2, drugih 10 proizvoda
    

    function pagination(uint _brojStrane, uint _brojProizvodaPoStrani) public returns (uint[] memory) 
    {

        uint[] memory produkti = new uint[] (_brojProizvodaPoStrani);

        for(uint i = _brojProizvodaPoStrani * _brojStrane - _brojProizvodaPoStrani; i < _brojProizvodaPoStrani * _brojStrane; i++ ){
            uint idProizvoda = proizvodi[i].id;
            produkti[i] = idProizvoda;
        } 
        return produkti;
    }

    function sortiranjePoCeniRastuce() public returns (uint [] memory)
    {
        uint duzina = brojProizvoda;
        uint[] memory niz = new uint[] (duzina);

        for(uint i=0;i<duzina;i++)
        {
            niz[i] = proizvodi[i].cena;
        }

        for(uint i =0;i<duzina;i++)
        {
            for(uint j =i+1;j<duzina;j++)
            {
                if(niz[i]<niz[j])
                {
                    uint temp= niz[j];
                    niz[j] = niz[i];
                    niz[i] = temp;

                }

            }
        }

        return niz;
    }

    function odDo(uint donjaGranica, uint gornjaGranica) public returns (uint[] memory)
    {
        uint[] memory produkti = new uint[] (10);
        uint br = 0;

        for(uint i = 0; i < brojProizvoda; i++)
        {
            if(proizvodi[i].cena > donjaGranica && proizvodi[i].cena < gornjaGranica)
            {
                br = br + 1;
                produkti[br] = proizvodi[i].id;
            }
        }
        return produkti;
    }
}