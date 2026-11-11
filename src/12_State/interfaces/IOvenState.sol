// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

interface IOvenState {
    event AlreadyCold();
    event AlreadyReady();
    event AlreadyOverheated();

    error OvenIsCold();
    error OvenOverheated();

    function setStates(IOvenState _ready, IOvenState _cold) external;
    function bake(address oven) external returns (string memory);
    function goReady(address oven) external;
    function goCold(address oven) external;
    function goOverheat(address oven) external;
}
