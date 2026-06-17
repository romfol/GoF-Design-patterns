// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Multitone is Ownable {
    address[] private instances;

    constructor() Ownable(msg.sender) {}

    function init(uint256 _data1, string calldata _data2) external onlyOwner {
        require(instances.length < 10);
        instances.push(address(new Instance(_data1, _data2)));
    }

    function getInstance(uint256 orderNumber) external view returns (address) {
        return instances[orderNumber];
    }
}

contract Instance {
    uint256 immutable data;
    string data2;

    constructor(uint256 _data1, string memory _data2) {
        data = _data1;
        data2 = _data2;
    }
}
