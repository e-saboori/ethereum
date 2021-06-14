// Administrator.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Administrator{

    struct Account{
        uint256 balance; // this can be the token!
        bool isRegistered;
    }
    
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
}