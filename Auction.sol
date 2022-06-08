//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Auction {
    address public owner;
    address payable public beneficiary;
    //its not safe to use block.timestamp as a timer since the miner can spoof the block timestamp
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;

    enum State{
        Started,
        Running, 
        Ended,
        Canceled
    }
    State public auctionState;

    uint public highestBindingBid;
    address payable public highestBidder;

    mapping(address => uint) public bids;
    uint bidIncrement;

    constructor(address payable _beneficiary){
        owner = msg.sender;
        beneficiary = _beneficiary;
        auctionState = State.Ended;
    }

    //can only start new bid when the old one are already Ended
    //assuming we want to run the auction once per week 
    //the it'll be (60s * 60m *24h *7d)/15s. 1 block in ethereum are generated per 15s
    function startNewBid() public onlyOwner onlyEnded{
        startBlock = block.number;
        endBlock = startBlock + 4032;
        auctionState = State.Started;
    }

    modifier onlyEnded(){
        require (auctionState == State.Ended);
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    struct Item{
        string id;
        string iName;
        uint iPrice;
        uint iQty;
    }

    struct User{
        string Name;
        bool active;
        Item[] cart;
    }

    mapping(address => User) public UsersCart;
}