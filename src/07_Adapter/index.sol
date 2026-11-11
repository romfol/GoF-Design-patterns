// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

contract DeutscherRechner {
    function addieren(int256 a, int256 b) external pure returns (int256) {
        return a + b;
    }

    function multiplizieren(int256 a, int256 b) external pure returns (int256) {
        return a * b;
    }
}

interface ICalculator {
    function add(int256 a, int256 b) external returns (int256);
    function multiply(int256 a, int256 b) external returns (int256);
}

contract Adapter is ICalculator {
    DeutscherRechner private immutable _rechner;

    constructor(address rechner_) {
        _rechner = DeutscherRechner(rechner_);
    }

    function add(int256 a, int256 b) external view returns (int256) {
        return _rechner.addieren(a, b);
    }

    function multiply(int256 a, int256 b) external view returns (int256) {
        return _rechner.multiplizieren(a, b);
    }
}
