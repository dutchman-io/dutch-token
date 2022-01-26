// SPDX-License-Identifier: GPL-3.0

//my first cryptocurrency
pragma solidity >=0.0.5;

contract dutchman{
    address public minter;
    mapping(address => uint) public balances;


    //allows client to react to a specific contract declared
    event Sent (address from, address to, uint amount);
    
    //this is run whan the contract is created
    constructor(){
        minter = msg.sender;
    }
    //a function to send a newly created coin to an address
    // and can only be called by the contract creator
    function mint(address receiver, uint amount) public{
        require(msg.sender ==minter);
        balances[receiver]+= amount;

    }

    //information as to why the opperation failed when tey are returned to the caller of the function
    error InsufficientBalance(uint requested, uint available);
    

    //send an existing coin from the caller to an address
    function send(address receiver, uint amount) public{
        if (amount > balances[msg.sender])
        revert InsufficientBalance({
            requested:amount,
            available: balances[msg.sender]
        });
        balances[msg.sender]-=amount;
        balances[receiver] +=amount;
        emit Sent(msg.sender,receiver, amount);
    }
}