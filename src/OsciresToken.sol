// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from 'lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol';
import { ERC20Burnable } from 'lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol';
import { ERC20Permit } from 'lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol';
import { ERC20Votes } from 'lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Votes.sol';
import {Nonces} from "lib/openzeppelin-contracts/contracts/utils/Nonces.sol";
/**
 * @title Oscires
 * @dev Extends ERC20, ERC20Burnable, ERC20Permit, ERC20Votes contracts from OpenZeppelin.
 * @notice This contract implements a basic ERC20 token with burn, permit, and voting capabilities.
 */
contract Oscires is ERC20, ERC20Burnable, ERC20Permit, ERC20Votes {
    uint256 public immutable INITIAL_SUPPLY = 1_000_000_000 * 10 ** decimals();

    /**
     * @dev Constructor that initializes the  Oscires token with an initial supply and transfers it to the deployer.
     */
    constructor() ERC20('Oscires', 'OSC') ERC20Permit('Oscires Spindle') {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /**
     * @dev Overrides the nonces function to return the nonce for permit signature verification.
     * @param owner The address for which the nonce is queried.
     * @return The current nonce associated with the owner address.
     */
    function nonces(
        address owner
    ) public view override(ERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }

    /**
     * @dev Overrides the _update function to ensure compatibility with ERC20Votes.
     * @param from The address from which tokens are transferred.
     * @param to The address to which tokens are transferred.
     * @param value The amount of tokens transferred.
     */
    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, ERC20Votes) {
        super._update(from, to, value);
    }
}
