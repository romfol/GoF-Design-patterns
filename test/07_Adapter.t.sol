// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/07_Adapter/index.sol";

contract AdapterTest is Test {
    DeutscherRechner rechner;
    Adapter adapter;

    function setUp() public {
        rechner = new DeutscherRechner();
        adapter = new Adapter(address(rechner));
    }

    // ─── Deployment ──────────────────────────────────────────────

    function test_RechnerIsDeployed() public view {
        assertTrue(address(rechner) != address(0));
        assertTrue(address(rechner).code.length > 0);
    }

    function test_AdapterIsDeployed() public view {
        assertTrue(address(adapter) != address(0));
        assertTrue(address(adapter).code.length > 0);
    }

    // ─── Add ─────────────────────────────────────────────────────

    function test_AddPositiveNumbers() public view {
        assertEq(adapter.add(10, 5), 15);
    }

    function test_AddNegativeNumbers() public view {
        assertEq(adapter.add(-10, 5), -5);
    }

    function test_AddTwoNegativeNumbers() public view {
        assertEq(adapter.add(-10, -5), -15);
    }

    function test_AddZero() public view {
        assertEq(adapter.add(42, 0), 42);
    }

    // ─── Multiply ────────────────────────────────────────────────

    function test_MultiplyPositiveNumbers() public view {
        assertEq(adapter.multiply(10, 5), 50);
    }

    function test_MultiplyNegativeNumbers() public view {
        assertEq(adapter.multiply(-10, 5), -50);
    }

    function test_MultiplyTwoNegativeNumbers() public view {
        assertEq(adapter.multiply(-10, -5), 50);
    }

    function test_MultiplyByZero() public view {
        assertEq(adapter.multiply(123, 0), 0);
    }

    // ─── Interface Compatibility ────────────────────────────────

    function test_CanUseAdapterThroughInterface() public {
        ICalculator calculator = ICalculator(address(adapter));

        assertEq(calculator.add(20, 30), 50);
        assertEq(calculator.multiply(6, 7), 42);
    }

    // ─── Verify Delegation ──────────────────────────────────────

    function test_AdapterMatchesGermanCalculatorForAdd() public view {
        int256 expected = rechner.addieren(15, 25);
        int256 actual = adapter.add(15, 25);

        assertEq(actual, expected);
    }

    function test_AdapterMatchesGermanCalculatorForMultiply() public view {
        int256 expected = rechner.multiplizieren(8, 9);
        int256 actual = adapter.multiply(8, 9);

        assertEq(actual, expected);
    }
}
