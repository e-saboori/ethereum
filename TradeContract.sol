// TradeContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Administrator.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract TradeContract {
    Administrator private admin;
    
    function Buy(address recipient, uint256 amount) public{
        require(admin.IsTraderRegistered(msg.sender), "Buyer is not registered");
        require(admin.IsTraderRegistered(recipient), "Seller is not registered");
        require(admin.TraderHasEnoughBalance(msg.sender, amount), "Buyer does not have sufficient balance");
        
        
    }
}

