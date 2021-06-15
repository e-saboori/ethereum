// SmartContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract SmartContract is Ownable, ERC20{
    constructor () ERC20("SmartContract", "SM"){}
    
    mapping(uint256=>address) private _tokenOwner;
    mapping(address=>uint256) private _onwerBalance;
    
    function transferFrom(
        address sender, 
        address recipient, 
        uint256 tokenId,
        uint256 amount
    ) public onlyOwner{
        // amount value should be coming from Oracel and be stored here in block
        _onwerBalance[sender] -= amount;
        _tokenOwner[tokenId] = sender;
        _onwerBalance[recipient] += amount;
    }
    
    function balanceOf(address trader) public view override returns (uint256){
        require(trader!=address(0));
        return _onwerBalance[trader];
    }
}