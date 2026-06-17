// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "@openzeppelin/contracts/proxy/Clones.sol";

contract Car {
    enum CarType {
        Sedan,
        Truck,
        Minivan
    }

    CarType public carType;
    string public color;
    uint256 public number;

    bool private initialized;

    constructor(CarType _type) {
        carType = _type;
        initialized = true;
    }

    function init(string memory _color, uint256 _number) external {
        require(!initialized, "Already initialized");

        color = _color;
        number = _number;

        initialized = true;
    }
}

contract CarFactory {
    using Clones for address;

    address public immutable sedanPrototype;
    address public immutable truckPrototype;
    address public immutable minivanPrototype;

    constructor() {
        sedanPrototype = address(new Car(Car.CarType.Sedan));
        truckPrototype = address(new Car(Car.CarType.Truck));
        minivanPrototype = address(new Car(Car.CarType.Minivan));
    }

    function createSedan(
        string memory _color,
        uint256 _number
    ) external returns (address) {
        address clone = sedanPrototype.clone();

        Car(clone).init(_color, _number);

        return clone;
    }

    function createTruck(
        string memory _color,
        uint256 _number
    ) external returns (address) {
        address clone = truckPrototype.clone();

        Car(clone).init(_color, _number);

        return clone;
    }

    function createMinivan(
        string memory _color,
        uint256 _number
    ) external returns (address) {
        address clone = minivanPrototype.clone();

        Car(clone).init(_color, _number);

        return clone;
    }
}
