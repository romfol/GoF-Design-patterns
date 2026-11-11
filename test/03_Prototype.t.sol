// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/03_Prototype/index.sol";

contract PrototypeTest is Test {
    CarFactory factory;

    function setUp() public {
        factory = new CarFactory();
    }

    // ─── Prototypes ──────────────────────────────────────────────

    function test_PrototypesAreDeployedWithCorrectType() public view {
        assertEq(uint256(Car(factory.sedanPrototype()).carType()), uint256(Car.CarType.Sedan));
        assertEq(uint256(Car(factory.truckPrototype()).carType()), uint256(Car.CarType.Truck));
        assertEq(uint256(Car(factory.minivanPrototype()).carType()), uint256(Car.CarType.Minivan));
    }

    function test_PrototypeCannotBeInitialized() public {
        address prototype = factory.sedanPrototype();

        vm.expectRevert("Already initialized");
        Car(prototype).init(Car.CarType.Truck, "red", 1);
    }

    // ─── createSedan() ───────────────────────────────────────────

    function test_CreateSedanInitializesFields() public {
        Car car = Car(factory.createSedan("red", 123));

        assertEq(uint256(car.carType()), uint256(Car.CarType.Sedan));
        assertEq(car.color(), "red");
        assertEq(car.number(), 123);
    }

    // ─── createTruck() ───────────────────────────────────────────

    function test_CreateTruckInitializesFields() public {
        Car car = Car(factory.createTruck("blue", 456));

        assertEq(uint256(car.carType()), uint256(Car.CarType.Truck));
        assertEq(car.color(), "blue");
        assertEq(car.number(), 456);
    }

    // ─── createMinivan() ─────────────────────────────────────────

    function test_CreateMinivanInitializesFields() public {
        Car car = Car(factory.createMinivan("green", 789));

        assertEq(uint256(car.carType()), uint256(Car.CarType.Minivan));
        assertEq(car.color(), "green");
        assertEq(car.number(), 789);
    }

    // ─── Cloning behaviour ───────────────────────────────────────

    function test_ClonesAreIndependent() public {
        Car sedan = Car(factory.createSedan("red", 1));
        Car truck = Car(factory.createTruck("blue", 2));

        assertTrue(address(sedan) != address(truck));
        assertEq(sedan.color(), "red");
        assertEq(truck.color(), "blue");
    }

    function test_CloneCannotBeInitializedTwice() public {
        Car car = Car(factory.createSedan("red", 1));

        vm.expectRevert("Already initialized");
        car.init(Car.CarType.Truck, "blue", 2);
    }
}
