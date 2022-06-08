//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

import "./Auction.sol";

contract Creator {
    address public ownerCreator;

    constructor(){
        ownerCreator = msg.sender;
    }

    function deployAuction() public{
        Auction new_Auction_Address = new Auction();
    }

}