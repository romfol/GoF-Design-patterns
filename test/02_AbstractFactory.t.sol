// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/02_AbstractFactory/index.sol";

contract AbstractFactoryTest is Test {
    CuisineFactory factory;
    Cafe cafe;

    function setUp() public {
        factory = new CuisineFactory();
        cafe = new Cafe(factory);
    }

    // ─── create() ────────────────────────────────────────────────

    function test_CreateJapaneseCuisine() public {
        AbstractFactory cuisine = factory.create(Cuisine.Japanese);

        assertGt(address(cuisine).code.length, 0);
        assertEq(cuisine.prepareFirstDish(), "Your's Miso");
        assertEq(cuisine.prepareSecondDish(), "Your's Ramen");
        assertEq(cuisine.prepareDessert(), "Your's Mochi");
    }

    function test_CreateAmericanCuisine() public {
        AbstractFactory cuisine = factory.create(Cuisine.American);

        assertGt(address(cuisine).code.length, 0);
        assertEq(cuisine.prepareFirstDish(), "Your's clam chowder");
        assertEq(cuisine.prepareSecondDish(), "Your's Burger");
        assertEq(cuisine.prepareDessert(), "Your's Apple Pie");
    }

    function test_CreateUkrainianCuisine() public {
        AbstractFactory cuisine = factory.create(Cuisine.Ukrainian);

        assertGt(address(cuisine).code.length, 0);
        assertEq(cuisine.prepareFirstDish(), "Your's Borshch");
        assertEq(cuisine.prepareSecondDish(), "Your's Varenyky");
        assertEq(cuisine.prepareDessert(), "Your's Medivnyk");
    }

    function test_EachCreateDeploysNewInstance() public {
        AbstractFactory first = factory.create(Cuisine.Japanese);
        AbstractFactory second = factory.create(Cuisine.Japanese);

        assertTrue(address(first) != address(second));
    }

    // ─── Cafe (client) ───────────────────────────────────────────

    function test_CafePreparesEveryCuisine() public {
        cafe.prepareComplexDinner(Cuisine.Japanese);
        cafe.prepareComplexDinner(Cuisine.American);
        cafe.prepareComplexDinner(Cuisine.Ukrainian);
    }
}
