// Administrator.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Administrator{

    struct Account{
        uint256 balance;
        bool isRegistered;
    }
    
    //mapping(uint256=>address) _tokensOwner;
    mapping(address=>Account) _traders;
    
    function Register(address trader, uint256 balance) public {
        if(trader!=address(0) && _traders[trader].isRegistered == false){
            _traders[trader].isRegistered = true;
            _traders[trader].balance = balance;
        }
    }
    
    function IsTraderRegistered(address trader) public view returns (bool) {
        if(trader != address(0) && _traders[trader].isRegistered == true){
            return true;
        }
        return false;
    }
    
    function TraderHasEnoughBalance(address trader, uint256 amount) public view returns (bool){
        if(trader != address(0)){
            uint256 balance = _traders[trader].balance;
            if(balance >= amount){
                return true;
            }
        }
        
        return false;
    }
    
    function TransferFrom(address sender, address recipient, uint256 amount) public{
        if(sender!=address(0) && recipient!= address(0))
        {
            require(IsTraderRegistered(msg.sender), "Buyer is not registered");
            require(IsTraderRegistered(recipient), "Seller is not registered");
            require(TraderHasEnoughBalance(msg.sender, amount), "Buyer does not have sufficient balance");
            
            _traders[sender].balance -= amount;
            _traders[recipient].balance += amount;
        }
        
    }
}