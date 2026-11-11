// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/06_Facade/index.sol";

contract FacadeTest is Test {
    AddService addService;
    SubtractService subtractService;
    MultiplyService multiplyService;
    DivideService divideService;
    Facade facade;

    function setUp() public {
        addService = new AddService();
        subtractService = new SubtractService();
        multiplyService = new MultiplyService();
        divideService = new DivideService();

        facade = new Facade(
            address(addService),
            address(subtractService),
            address(multiplyService),
            address(divideService)
        );
    }

    // ─── Add ─────────────────────────────────────────────────────

    function test_AddPositiveNumbers() public view {
        assertEq(facade.add(10, 5), 15);
    }

    function test_AddNegativeNumbers() public view {
        assertEq(facade.add(-10, 5), -5);
    }

    // ─── Subtract ────────────────────────────────────────────────

    function test_SubtractPositiveNumbers() public view {
        assertEq(facade.subtract(10, 5), 5);
    }

    function test_SubtractNegativeNumbers() public view {
        assertEq(facade.subtract(-10, 5), -15);
    }

    // ─── Multiply ────────────────────────────────────────────────

    function test_MultiplyPositiveNumbers() public view {
        assertEq(facade.multiply(10, 5), 50);
    }

    function test_MultiplyNegativeNumbers() public view {
        assertEq(facade.multiply(-10, 5), -50);
    }

    function test_MultiplyByZero() public view {
        assertEq(facade.multiply(10, 0), 0);
    }

    // ─── Divide ──────────────────────────────────────────────────

    function test_DividePositiveNumbers() public view {
        assertEq(facade.divide(20, 5), 4);
    }

    function test_DivideNegativeNumbers() public view {
        assertEq(facade.divide(-20, 5), -4);
    }

    function test_DivideTruncatesResult() public view {
        assertEq(facade.divide(7, 2), 3);
    }

    function test_DivideByZeroReverts() public {
        vm.expectRevert();
        facade.divide(10, 0);
    }
}
