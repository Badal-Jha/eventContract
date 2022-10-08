// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HotelRoom{
    //what we will learn
    //Ether- Pay smart contract
    //modifiers
    //visiblity
    //Events
    //Enums
    address payable public owner;
    //Events allow logging to the Ethereum blockchain. Some use cases for events are:
    enum Statuses {Vacant,Occupied}

    Statuses currentStatus;
    event Occupy(address _occupant,uint _value);

    constructor() {
        // msg.sender is the user who calls this function ->etherium address
        owner=payable (msg.sender);
        currentStatus=Statuses.Vacant;
    }
    
    //Modifiers
    // Modifiers are code that can be run before and / or after a function call.

    // Modifiers can be used to:

    // Restrict access
    // Validate inputs
    // Guard against reentrancy hack

    modifier onlyWhileVacant() {
          require(currentStatus==Statuses.Vacant,"Currently Occupied");
          _;// this line execute function body
    }

    modifier cost(uint _amount){
         require(msg.value >=_amount,"Not enough ether provide");
         _;
    }
    // function book() payable public onlyWhileVacant cost(2 ether){
    //receive() is a external function executed when we pay somehting 
      receive() external payable onlyWhileVacant cost(2 ether){  
        //transfer payment to owner to book hotel room
        //check price
        //check status
        //if first line of require is true then further lines will run else "currently Occupied" runs
         //check status
    
        //require(currentStatus==Statuses.Vacant,"Currently Occupied");//we used modifier so commented

        //check price
     //   require(msg.value >= 2 ether,"Not enough ether provide");

        currentStatus= Statuses.Occupied;
        owner.transfer(msg.value);
       emit Occupy(msg.sender, msg.value);
     }

}