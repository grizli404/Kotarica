// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ListaZelja {
    
    struct Zelja {
        uint brojZelja;
        uint[] p;
    } 
    mapping ( uint => Zelja) public zelje;
 
    function lajkovanje(uint idKorisnika, uint idProizvoda) public {
        zelje[idKorisnika].brojZelja += 1;
        zelje[idKorisnika].p.push(idProizvoda);
    }
 
    function dislajkovanje(uint idKorisnika, uint idProizvoda) public {
        for(uint i = 0; i < zelje[idKorisnika].brojZelja; i++) {
            if(zelje[idKorisnika].p[i] ==  idProizvoda) {
                for(uint j = i; j < zelje[idKorisnika].brojZelja - 1; j++) {
                    zelje[idKorisnika].p[j] = zelje[idKorisnika].p[j + 1];
                }
                zelje[idKorisnika].p[zelje[idKorisnika].brojZelja - 1] = 0;
                zelje[idKorisnika].brojZelja -= 1;
                return;
            }
        }
    }

    function dajLajkove(uint idKorisnika) public view returns(uint[] memory){
        return zelje[idKorisnika].p;
    }
 
}