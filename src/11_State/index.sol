// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./interfaces/IOven.sol";
import "./interfaces/IOvenState.sol";

contract Oven is IOven {
    IOvenState public state;

    constructor(IOvenState initialState) {
        state = initialState;
    }

    function setState(IOvenState newState) external {
        state = newState;
    }

    function bake() external returns (string memory) {
        return state.bake(address(this));
    }

    function goReady() external {
        state.goReady(address(this));
    }

    function goCold() external {
        state.goCold(address(this));
    }

    function goOverheat() external {
        state.goOverheat(address(this));
    }
}

contract ColdState is IOvenState {
    address public ready;
    address public overheat;

    bool public initialized;

    function setStates(address _ready, address _overheat) external {
        ready = _ready;
        overheat = _overheat;
    }

    function bake(address) external pure returns (string memory) {
        revert OvenIsCold();
    }

    function goReady(address oven) external {
        Oven(oven).setState(IOvenState(ready));
    }

    function goCold(address) external {
        emit AlreadyCold();
    }

    function goOverheat(address oven) external {
        Oven(oven).setState(IOvenState(overheat));
    }
}

contract ReadyState is IOvenState {
    address public cold;
    address public overheat;

    bool public initialized;

    function setStates(address coldState, address overheatState) external {
        cold = coldState;
        overheat = overheatState;
    }

    function bake(address) external pure returns (string memory dish) {
        dish = "your's dish on the plate";
    }

    function goReady(address) external {
        emit AlreadyReady();
    }

    function goCold(address oven) external {
        Oven(oven).setState(IOvenState(cold));
    }

    function goOverheat(address oven) external {
        Oven(oven).setState(IOvenState(overheat));
    }
}

contract OverheatState is IOvenState {
    address public ready;
    address public cold;

    bool public initialized;

    function setStates(address _ready, address _cold) external {
        ready = _ready;
        cold = _cold;
    }

    function bake(address) external pure returns (string memory) {
        revert OvenOverheated();
    }

    function goReady(address oven) external {
        Oven(oven).setState(IOvenState(ready));
    }

    function goCold(address oven) external {
        Oven(oven).setState(IOvenState(cold));
    }

    function goOverheat(address) external {
        emit AlreadyOverheated();
    }
}
