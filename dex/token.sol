pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


// This is an example ERC20 contract that mints 1000 tokens to the account that deploys it.
// You can personalize your own token name and symbol by changing "MyToken", "MTK"
contract MyToken is ERC20 {
  constructor() ERC20("MyToken", "MTK") {
      _mint(msg.sender, 1000*10**18);
  }
}