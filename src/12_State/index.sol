// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./interfaces/IOven.sol";
import "./interfaces/IOvenState.sol";

contract Oven is IOven {
    IOvenState public state;

    constructor(IOvenState cold, IOvenState ready, IOvenState overheat) {
        cold.setStates(ready, overheat);
        ready.setStates(cold, overheat);
        overheat.setStates(ready, cold);

        state = cold;
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
    IOvenState public ready;
    IOvenState public overheat;

    function setStates(IOvenState _ready, IOvenState _overheat) external {
        ready = _ready;
        overheat = _overheat;
    }

    function bake(address) external pure returns (string memory) {
        revert OvenIsCold();
    }

    function goReady(address oven) external {
        Oven(oven).setState(ready);
    }

    function goCold(address) external {
        emit AlreadyCold();
    }

    function goOverheat(address oven) external {
        Oven(oven).setState(overheat);
    }
}

contract ReadyState is IOvenState {
    IOvenState public cold;
    IOvenState public overheat;

    function setStates(IOvenState _cold, IOvenState _overheat) external {
        cold = _cold;
        overheat = _overheat;
    }

    function bake(address) external pure returns (string memory dish) {
        dish = "your's dish on the plate";
    }

    function goReady(address) external {
        emit AlreadyReady();
    }

    function goCold(address oven) external {
        Oven(oven).setState(cold);
    }

    function goOverheat(address oven) external {
        Oven(oven).setState(overheat);
    }
}

contract OverheatState is IOvenState {
    IOvenState public ready;
    IOvenState public cold;

    function setStates(IOvenState _ready, IOvenState _cold) external {
        ready = _ready;
        cold = _cold;
    }

    function bake(address) external pure returns (string memory) {
        revert OvenOverheated();
    }

    function goReady(address oven) external {
        Oven(oven).setState(ready);
    }

    function goCold(address oven) external {
        Oven(oven).setState(cold);
    }

    function goOverheat(address) external {
        emit AlreadyOverheated();
    }
}
