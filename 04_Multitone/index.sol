// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Multitone is Ownable {
    address[] private instances;

    constructor() Ownable(msg.sender) onlyOwner {
        require(instances.length < 10);
        instances.push(address(this));
    }

    function getInstance(uint256 orderNumber) external view returns (address) {
        return instances[orderNumber];
    }
}
