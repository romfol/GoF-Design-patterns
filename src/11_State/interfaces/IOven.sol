// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./IOvenState.sol";
interface IOven {
    function state() external view returns (IOvenState);
    function setState(IOvenState newState) external;
    function bake() external returns (string memory);
    function goReady() external;
    function goCold() external;
    function goOverheat() external;
}
