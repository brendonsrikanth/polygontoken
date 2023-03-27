// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract XYZTokenSale is Ownable {
    uint256 public constant TOKEN_PRICE = 100000000000000000; // 0.1 matic per token
    uint256 public constant TOTAL_SUPPLY = 1000000000 * (10 ** 18); // 1 billion tokens
    uint256 public tokensSold;

    IERC20 public token;

    event Sold(address buyer, uint256 amount);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == _numberOfTokens * TOKEN_PRICE, "Invalid amount of Matic sent");
        require(tokensSold + _numberOfTokens <= TOTAL_SUPPLY, "Not enough tokens available");

        tokensSold += _numberOfTokens;
        token.transfer(msg.sender, _numberOfTokens * (10 ** 18));
        emit Sold(msg.sender, _numberOfTokens);
    }

    function withdrawMatic() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function withdrawTokens() public onlyOwner {
        uint256 unsoldTokens = TOTAL_SUPPLY - tokensSold;
        token.transfer(owner(), unsoldTokens);
    }
}
