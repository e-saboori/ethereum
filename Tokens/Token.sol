// Token.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    string __name;
    constructor(uint256 initialSupply) ERC20("token", "TNK") {
        _mint(msg.sender, initialSupply);
    }
    
    function SetName(string memory name) public{
        __name = name;
    }
    
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }
}