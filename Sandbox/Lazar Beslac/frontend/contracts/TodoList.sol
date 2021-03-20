// SPDX-License-Identifier: MIT
pragma solidity >=0.4.17 <0.9.0;

contract TodoList{
    //Da bi mogli da procitamo vrednost ove promenljive moramo da stavimo public
    uint public taskCount = 0;

    //Ova struktura predstavlja model(kao za bazu)
    struct Task{
        //Ovo ce da bude neka forma gde ce moci da se unese opis za todo listu
        //i da se cekira kada se odradi
        uint id;
        string content; // text
        bool completed; // chackbox
    }
    
    //U Solidity-ju ne postoji vise vidljivost za konstruktor
    /*constructor(){
        createTask("Nauciti Ethereum");
    }*/

    //mapping je kao neka vrsta niza
    //ovo ce za nas predstavljati bazu podataka gde je tabela Task
    mapping(uint => Task) public tasks;

    //ova f-ja ce da dodaje nove stvari u memoriju
    //tasks nam predstavlja listu svih stvari u bazi i svakom elementu se pristupa preko njegovog id-a
    function createTask(string memory _content) public{
        taskCount ++;
        tasks[taskCount] = Task(taskCount, _content, false);
    }
}