// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

enum CarType {
    Sedan,
    Truck,
    Minivan
}

contract Car {
    CarType public immutable carType;
    uint256 public immutable engineVolume;
    uint8 public immutable seats;
    uint256 public immutable payload;
    string public color;
    uint256 public number;

    constructor(CarType _carType, string memory _color, uint256 _number) {
        carType = _carType;
        color = _color;
        number = _number;

        if (_carType == CarType.Sedan) {
            engineVolume = 2500;
            seats = 5;
            payload = 0;
        } else if (_carType == CarType.Truck) {
            engineVolume = 5000;
            seats = 2;
            payload = 1500;
        } else {
            engineVolume = 3500;
            seats = 8;
            payload = 300;
        }
    }

    function update(string memory _color, uint256 _number) external {
        color = _color;
        number = _number;
    }
}

contract CarFabric {
    // the only entry points for client
    function createSedan(
        string memory _color,
        uint256 _number
    ) external returns (address) {
        return _clone(CarType.Sedan, _color, _number);
    }

    function createTruck(
        string memory _color,
        uint256 _number
    ) external returns (address) {
        return _clone(CarType.Truck, _color, _number);
    }

    function createMinivan(
        string memory _color,
        uint256 _number
    ) external returns (address) {
        return _clone(CarType.Minivan, _color, _number);
    }

    function updateCar(
        address _carAddress,
        string memory _color,
        uint256 _number
    ) external {
        Car(_carAddress).update(_color, _number);
    }

    function _clone(
        CarType _type,
        string memory _color,
        uint256 _number
    ) private returns (address) {
        Car car = new Car(_type, _color, _number);
        return address(car);
    }
}
