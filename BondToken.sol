// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BondToken is ERC20 {
    uint256 public unlockTime;

    constructor(
        string memory name,
        string memory symbol,
        uint256 supply,
        uint256 _unlockTime
    ) ERC20(name, symbol) {
        unlockTime = _unlockTime;
        _mint(msg.sender, supply * 10 ** decimals());
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        require(block.timestamp >= unlockTime, "Token is locked");
        return super.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        require(block.timestamp >= unlockTime, "Token is locked");
        return super.transferFrom(from, to, amount);
    }
}