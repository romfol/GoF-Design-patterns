// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/09_Proxy/index.sol";

contract CacheTest is Test {
    AddService addService;
    SubtractService subtractService;
    MultiplyService multiplyService;
    DivideService divideService;

    Calculator calculator;
    Cache cache;

    function setUp() public {
        addService = new AddService();
        subtractService = new SubtractService();
        multiplyService = new MultiplyService();
        divideService = new DivideService();

        calculator = new Calculator(
            address(addService), address(subtractService), address(multiplyService), address(divideService)
        );

        cache = new Cache(address(calculator));
    }

    // ─── Deployment ──────────────────────────────────────────────

    function test_CalculatorIsDeployed() public view {
        assertTrue(address(calculator).code.length > 0);
    }

    function test_CacheIsDeployed() public view {
        assertTrue(address(cache).code.length > 0);
    }

    // ─── Add ─────────────────────────────────────────────────────

    function test_Add() public {
        assertEq(cache.add(10, 5), 15);
    }

    function test_AddNegativeNumbers() public {
        assertEq(cache.add(-10, 5), -5);
    }

    function test_AddCachedResult() public {
        int256 first = cache.add(100, 50);
        int256 second = cache.add(100, 50);

        assertEq(first, second);
        assertEq(second, 150);
    }

    // ─── Subtract ────────────────────────────────────────────────

    function test_Subtract() public {
        assertEq(cache.subtract(20, 5), 15);
    }

    function test_SubtractCachedResult() public {
        int256 first = cache.subtract(20, 5);
        int256 second = cache.subtract(20, 5);

        assertEq(first, second);
        assertEq(second, 15);
    }

    // ─── Multiply ────────────────────────────────────────────────

    function test_Multiply() public {
        assertEq(cache.multiply(10, 5), 50);
    }

    function test_MultiplyByZero() public {
        assertEq(cache.multiply(999, 0), 0);
    }

    function test_MultiplyCachedResult() public {
        int256 first = cache.multiply(7, 8);
        int256 second = cache.multiply(7, 8);

        assertEq(first, second);
        assertEq(second, 56);
    }

    // ─── Divide ──────────────────────────────────────────────────

    function test_Divide() public {
        assertEq(cache.divide(20, 5), 4);
    }

    function test_DivideTruncatesResult() public {
        assertEq(cache.divide(7, 2), 3);
    }

    function test_DivideCachedResult() public {
        int256 first = cache.divide(100, 4);
        int256 second = cache.divide(100, 4);

        assertEq(first, second);
        assertEq(second, 25);
    }

    function test_DivideByZeroReverts() public {
        vm.expectRevert();
        cache.divide(10, 0);
    }

    // ─── Different Keys ──────────────────────────────────────────

    function test_DifferentArgumentsProduceDifferentResults() public {
        assertEq(cache.add(10, 5), 15);
        assertEq(cache.add(10, 6), 16);
    }

    function test_DifferentOperationsUseDifferentCacheKeys() public {
        assertEq(cache.add(10, 5), 15);
        assertEq(cache.subtract(10, 5), 5);
        assertEq(cache.multiply(10, 5), 50);
        assertEq(cache.divide(10, 5), 2);
    }

    // ─── Interface Compatibility ────────────────────────────────

    function test_CanUseCacheThroughInterface() public {
        ICalculator calc = ICalculator(address(cache));

        assertEq(calc.add(1, 2), 3);
        assertEq(calc.subtract(5, 2), 3);
        assertEq(calc.multiply(3, 4), 12);
        assertEq(calc.divide(8, 2), 4);
    }
}
