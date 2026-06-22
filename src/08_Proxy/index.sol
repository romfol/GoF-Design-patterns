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

interface ICalculator {
    function add(int256 a, int256 b) external returns (int256);
    function subtract(int256 a, int256 b) external returns (int256);
    function multiply(int256 a, int256 b) external returns (int256);
    function divide(int256 a, int256 b) external returns (int256);
}

contract Calculator is ICalculator {
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

    function add(int256 a, int256 b) external view override returns (int256) {
        return _add.add(a, b);
    }
    function subtract(
        int256 a,
        int256 b
    ) external view override returns (int256) {
        return _sub.subtract(a, b);
    }
    function multiply(
        int256 a,
        int256 b
    ) external view override returns (int256) {
        return _mul.multiply(a, b);
    }
    function divide(
        int256 a,
        int256 b
    ) external view override returns (int256) {
        return _div.divide(a, b);
    }
}

contract Cache is ICalculator {
    ICalculator private immutable calculator;

    mapping(bytes32 => int256) private cachedResults;

    mapping(bytes32 => bool) private exists;

    constructor(address _calculator) {
        calculator = ICalculator(_calculator);
    }

    function add(int256 a, int256 b) external override returns (int256) {
        bytes32 key = _key("add", a, b);

        if (exists[key]) {
            return cachedResults[key];
        }

        int256 result = calculator.add(a, b);

        cachedResults[key] = result;

        exists[key] = true;

        return result;
    }

    function subtract(int256 a, int256 b) external override returns (int256) {
        bytes32 key = _key("subtract", a, b);

        if (exists[key]) {
            return cachedResults[key];
        }

        int256 result = calculator.subtract(a, b);

        cachedResults[key] = result;

        exists[key] = true;

        return result;
    }

    function multiply(int256 a, int256 b) external override returns (int256) {
        bytes32 key = _key("multiply", a, b);

        if (exists[key]) {
            return cachedResults[key];
        }

        int256 result = calculator.multiply(a, b);

        cachedResults[key] = result;

        exists[key] = true;

        return result;
    }

    function divide(int256 a, int256 b) external override returns (int256) {
        bytes32 key = _key("divide", a, b);

        if (exists[key]) {
            return cachedResults[key];
        }

        int256 result = calculator.divide(a, b);

        cachedResults[key] = result;

        exists[key] = true;

        return result;
    }

    function _key(
        string memory operation,
        int256 a,
        int256 b
    ) internal pure returns (bytes32) {
        return keccak256(abi.encode(operation, a, b));
    }
}
