// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Kategorije {
    
    struct Kategorija
    {
        uint id;
        string naziv;
    }

    uint public brojKategorija = 0;

    mapping(uint => Kategorija) public kategorije;

    function dodajKategoriju(string memory _naziv) public
    {
        brojKategorija++;
        kategorije[brojKategorija] = Kategorija(brojKategorija, _naziv);
    }
}