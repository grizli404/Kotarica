// SPDX-License-Identifier: MIT
pragma solidity >=0.4.17 <0.9.0;

contract Predmet{

    uint public taskCount = 0;

    //Struktura koja treba da bude u bazi
    struct Task{
        uint id;
        string naziv;
    }

    //tasks(1)
    mapping(uint => Task) public tasks;

    //createTask("Uradi domaci");
    function createTask(string memory _opis) public{
        taskCount++;

        tasks[taskCount] = Task(taskCount, _opis, false);
    }
    
}