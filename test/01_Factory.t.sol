// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/01_Factory/index.sol";

contract FactoryTest is Test {
    event Deployed(address indexed instance, Dish dish);

    Factory factory;

    function setUp() public {
        factory = new Factory();
    }

    // ─── init() ──────────────────────────────────────────────────

    function test_InitSushiReturnsSushi() public {
        Oven oven = factory.init(Dish.Sushi);

        assertGt(address(oven).code.length, 0);
        assertEq(oven.bake(), "yours, sushi");
    }

    function test_InitPizzaReturnsPizza() public {
        Oven oven = factory.init(Dish.Pizza);

        assertGt(address(oven).code.length, 0);
        assertEq(oven.bake(), "yours, pizza");
    }

    function test_EachInitDeploysNewInstance() public {
        Oven first = factory.init(Dish.Sushi);
        Oven second = factory.init(Dish.Sushi);

        assertTrue(address(first) != address(second));
    }

    function test_SushiAndPizzaAreDifferentContracts() public {
        Oven sushi = factory.init(Dish.Sushi);
        Oven pizza = factory.init(Dish.Pizza);

        assertTrue(address(sushi) != address(pizza));
    }

    // ─── Deployed event ──────────────────────────────────────────

    function test_InitEmitsDeployedForSushi() public {
        address expected = vm.computeCreateAddress(address(factory), vm.getNonce(address(factory)));

        vm.expectEmit(true, true, true, true, address(factory));
        emit Deployed(expected, Dish.Sushi);

        factory.init(Dish.Sushi);
    }

    function test_InitEmitsDeployedForPizza() public {
        address expected = vm.computeCreateAddress(address(factory), vm.getNonce(address(factory)));

        vm.expectEmit(true, true, true, true, address(factory));
        emit Deployed(expected, Dish.Pizza);

        factory.init(Dish.Pizza);
    }
}
