// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract GovernanceToken is ERC20Votes {
  uint256 public maxSupply = 10000000000;

  constructor() ERC20("Blockseater", "BE") ERC20Permit("Blockseater") {
    _mint(msg.sender, maxSupply);
  }

  // The functions below are overrides required by Solidity.
  // all functions are overridden,so that we can call functions  of erc720 ...
  // to get snapshots of tokens at different blocks. 

  function _afterTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal override(ERC20Votes) {
    super._afterTokenTransfer(from, to, amount);
  }
  function _mint(address to, uint256 amount) internal override(ERC20Votes) {
    super._mint(to, amount);
  }

  function _burn(address account, uint256 amount) internal override(ERC20Votes) {
    super._burn(account, amount);
  }
}
