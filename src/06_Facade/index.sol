// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

contract AddService {
    function add(int256 a, int256 b) external pure returns (int256) {
        return a + b;
    }
}

contract SubtractService {
    function subtract(int256 a, int256 b) external pure returns (int256) {
        return a - b;
    }
}

contract MultiplyService {
    function multiply(int256 a, int256 b) external pure returns (int256) {
        return a * b;
    }
}

contract DivideService {
    function divide(int256 a, int256 b) external pure returns (int256) {
        return a / b;
    }
}

contract Facade {
    AddService private immutable _add;
    SubtractService private immutable _sub;
    MultiplyService private immutable _mul;
    DivideService private immutable _div;

    constructor(address add_, address sub_, address mul_, address div_) {
        _add = AddService(add_);
        _sub = SubtractService(sub_);
        _mul = MultiplyService(mul_);
        _div = DivideService(div_);
    }

    function add(int256 a, int256 b) external view returns (int256) {
        return _add.add(a, b);
    }

    function subtract(int256 a, int256 b) external view returns (int256) {
        return _sub.subtract(a, b);
    }

    function multiply(int256 a, int256 b) external view returns (int256) {
        return _mul.multiply(a, b);
    }

    function divide(int256 a, int256 b) external view returns (int256) {
        return _div.divide(a, b);
    }
}
