// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/04_Builder/index.sol";

contract BuilderPatternTest is Test {
    Builder builder;

    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        builder = new Builder();
    }

    function testBuildDefaultPizza() public {
        Pizza pizza = Pizza(builder.build());

        assertEq(pizza.name(), "MEDIUM");
        assertFalse(pizza.cheese());
        assertFalse(pizza.bacon());
        assertFalse(pizza.pineapple());
        assertFalse(pizza.mushrooms());
        assertFalse(pizza.seafood());
    }

    function testBuildTopPizza() public {
        Pizza pizza = Pizza(builder.addCheese().addBacon().build());

        assertEq(pizza.name(), "TOP");
        assertTrue(pizza.cheese());
        assertTrue(pizza.bacon());
        assertFalse(pizza.pineapple());
        assertFalse(pizza.mushrooms());
        assertFalse(pizza.seafood());
    }

    function testBuildCustomPizza() public {
        Pizza pizza = Pizza(builder.addCheese().addMushrooms().addSeafood().build());

        assertEq(pizza.name(), "MEDIUM");
        assertTrue(pizza.cheese());
        assertFalse(pizza.bacon());
        assertFalse(pizza.pineapple());
        assertTrue(pizza.mushrooms());
        assertTrue(pizza.seafood());
    }

    function testBuilderResetsAfterBuild() public {
        builder.addCheese().addBacon().build();

        Pizza pizza = Pizza(builder.build());

        assertEq(pizza.name(), "MEDIUM");
        assertFalse(pizza.cheese());
        assertFalse(pizza.bacon());
        assertFalse(pizza.pineapple());
        assertFalse(pizza.mushrooms());
        assertFalse(pizza.seafood());
    }

    function testDifferentUsersHaveIndependentBuilders() public {
        vm.startPrank(alice);
        builder.addCheese();
        vm.stopPrank();

        vm.startPrank(bob);
        Pizza bobPizza = Pizza(builder.addBacon().build());
        vm.stopPrank();

        assertFalse(bobPizza.cheese());
        assertTrue(bobPizza.bacon());

        vm.startPrank(alice);
        Pizza alicePizza = Pizza(builder.build());
        vm.stopPrank();

        assertTrue(alicePizza.cheese());
        assertFalse(alicePizza.bacon());
    }
}
