// Administrator.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Tokens/Token.sol";

contract Administrator{
    
    address __admin;
    mapping(address => Account) __traders; 
    
    struct Account{
        uint256 balance;
        mapping(uint256 => Token) tokens;
        bool isRegistered;
    }
 
    constructor(){
        __admin = msg.sender;
    }
    
    function Register(address trader, uint256 balance) public {
        if(trader!=address(0) && __traders[trader].isRegistered == false){
            __traders[trader].isRegistered = true;
            __traders[trader].balance = balance;
        }
    }
    
    function IsTraderRegistered(address trader) public view returns (bool) {
        if(trader != address(0) && __traders[trader].isRegistered == true){
            return true;
        }
        return false;
    }
    
    function HasTraderEnoughBalance(address trader, uint256 amount) public view returns (bool){
        if(trader != address(0)){
            uint256 balance = __traders[trader].balance;
            if(balance >= amount){
                return true;
            }
        }
        
        return false;
    }

    function TransferFrom(
        address sender, 
        address payable recipient,
        uint256 tokenId,
        uint256 tokenPrice,
        uint256 amount) 
    public{
            require(IsTraderRegistered(sender), "Buyer is not registered");
            require(IsTraderRegistered(recipient), "Seller is not registered");
            require(HasTraderEnoughBalance(sender, amount), "Buyer does not have sufficient balance");
            
            Token token = __traders[recipient].tokens[tokenId];
            recipient.transfer(amount);
            token.transfer(sender, amount* 10^token.decimals());
            
            __traders[sender].tokens[tokenId] = token;
            delete __traders[recipient].tokens[tokenId];
            __traders[sender].balance -= amount* tokenPrice;
            __traders[recipient].balance += amount * tokenPrice;
            
    }
}