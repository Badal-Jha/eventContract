// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Lottary{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager=msg.sender;//global variable
     }
     
     //as we know receive() is a special type of function that can be used only once in a contract used and it will always be external
     //it will be called when anyone transact ether
     receive() external payable {
         require(msg.value==1 ether,"Need More Ether");
         participants.push(payable (msg.sender));
     }

     function getBalance() public view returns(uint){
         require(msg.sender==manager,"Participants cant view balance");
         return address(this).balance;
     }
     function random() public view returns(uint){

        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

     }

     function selectWinner() public{
         require(msg.sender==manager,"should be manager");
         require(participants.length>=3);
         uint r=random();
         address payable winner;
         uint index = r%participants.length;
         winner=participants[index];
         //transfer ether to  winner
         winner.transfer(getBalance());
         //reset participant to 0 size
         participants=new address payable[](0);

     }
}