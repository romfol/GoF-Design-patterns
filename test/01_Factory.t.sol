// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/01_Factory/index.sol";

contract FactoryTest is Test {
    Factory factory;

    function setUp() public {
        factory = new Factory();
    }

    // ─── init() ──────────────────────────────────────────────────

    function test_InitSushiReturnsSushi() public {
        address dish = factory.init(Dish.Sushi);

        assertGt(dish.code.length, 0);
        assertEq(Oven(dish).bake(), "your's sushi");
    }

    function test_InitPizzaReturnsPizza() public {
        address dish = factory.init(Dish.Pizza);

        assertGt(dish.code.length, 0);
        assertEq(Oven(dish).bake(), "your's pizza");
    }

    function test_EachInitDeploysNewInstance() public {
        address first = factory.init(Dish.Sushi);
        address second = factory.init(Dish.Sushi);

        assertTrue(first != second);
    }

    function test_SushiAndPizzaAreDifferentContracts() public {
        address sushi = factory.init(Dish.Sushi);
        address pizza = factory.init(Dish.Pizza);

        assertTrue(sushi != pizza);
    }
}
