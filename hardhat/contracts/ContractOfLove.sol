// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract ContractOfLove {
    //ADDRESS OWNER
    address public owner;
    //VALUE FOR EVENT
    uint public cry;
    uint public angry;
    uint public sad;
    uint public funny;
    uint public happy;
    //STRUCT 
    struct activity{
        uint256 balance;
        uint count;
    }
    //ARRAY REPORT
    mapping (address => activity) cryArr;
    mapping (address => activity) angryArr;
    mapping (address => activity) sadArr;
    mapping (address => activity) funnyArr;
    mapping (address => activity) happyArr;
    constructor() {
        owner = msg.sender;
        cry = 1 * 10**18;
        angry = 0.2 * 10**18;
        sad = 0.1 * 10**18;
        funny = 0.00001 * 10**18;
        happy = 0.00002 * 10**18;
    }
    //CHARGE WHEN MADE CRY 
    function chargeForCry() public payable{
        require(msg.value > cry, 'Balance not enough, Continue Sulk');
        cryArr[msg.sender].balance +=msg.value;
        cryArr[msg.sender].count +=1;
    }
    //CHARGE WHEN MADE ANGRY 
    function chargeForAngry() public payable{
        require(msg.value > angry, 'Balance not enough, Continue Sulk');
        angryArr[msg.sender].balance +=msg.value;
        angryArr[msg.sender].count +=1;
    }

    //CHARGE WHEN MADE SAD
    function chargeForSad() public payable{
        require(msg.value > sad, 'Balance not enough, Continue Sulk');
        sadArr[msg.sender].balance +=msg.value;
        sadArr[msg.sender].count +=1;
    }

    //REWARD WHEN MADE FUNNY
    function madeFunny() public {
       funnyArr[msg.sender].balance +=funny;
        funnyArr[msg.sender].count +=1; 
    }

    //REWARD WHEN MADE HAPPY
    function madeHappy() public {
       happyArr[msg.sender].balance +=happy;
        happyArr[msg.sender].count +=1; 
    }

    //WITHDRAW WHEN MADE HAPPY
    function withdrawHappy() public payable{
        uint amount = happyArr[msg.sender].balance;
        uint count = happyArr[msg.sender].count;
        require(count > 0,"Too bad you haven't done something for her yet");
        require(address(this).balance > amount,"Contract balance not enough, Cheer up because you make her so happy");
        happyArr[msg.sender].balance = 0;
        payable(msg.sender).transfer(amount);
    }

    //WITHDRAW WHEN MADE FUNNY
    function withdrawFunny() public payable{
        uint amount = funnyArr[msg.sender].balance;
        uint count = funnyArr[msg.sender].count;
        require(count > 0,"Too bad you haven't done something for her yet");
        require(address(this).balance > amount,"Contract balance not enough, Cheer up because you make her so funny");
        funnyArr[msg.sender].balance = 0;
        payable(msg.sender).transfer(amount);
    }

    //WITHDRAW
    function withdraw() public payable {
        require(msg.sender == owner,"You not owner, Don't try to steal money");
        require(checkContractBalance() > 0, "Contract balance not enough, You are happy");
        payable(owner).transfer(checkContractBalance());
    }

    function checkContractBalance() public view returns(uint) {
    return address(this).balance;
  }
}