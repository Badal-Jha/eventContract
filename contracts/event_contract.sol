// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EventContract {
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemaining;
    }

    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint))public tickets;
    uint public nextId;

    function createEvent(string memory name,uint date,uint price,uint ticketCount) external{
        require(date>block.timestamp,"event date should be more than current date!");
        require(ticketCount>0,"ticket count should ne more than one");

        events[nextId]=Event(msg.sender,name,date,price,ticketCount,ticketCount);
        nextId++;
    }

    function buyTickets(uint id,uint quantity) external payable {
                 require(events[id].date!=0,"this event does not exxist!");
                 require(events[id].date>block.timestamp,"events has be finished");

                 Event storage _event=events[0];
                 require(msg.value==(_event.price*quantity),"Not enough ether to buy");
                 require(_event.ticketRemaining>=quantity,"not enough ticket remaining!");

                 _event.ticketRemaining-=quantity;
                 tickets[msg.sender][id]+=quantity;
               }
  
    function transferTicker(uint id,uint quantity,address to) external{
          require(events[id].date!=0,"this event does not exxist!");
          require(events[id].date>block.timestamp,"events has be finished");
          require(tickets[msg.sender][id]>=quantity,"you do not have much tickets to send");
          tickets[msg.sender][id]-=quantity;
          tickets[to][id]+=quantity;
    }

}