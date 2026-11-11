// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/15_Command/index.sol";

contract CommandPatternTest is Test {
    Pizza pizza;
    PizzaOrder order;

    AddCheeseCommand cheese;
    AddBaconCommand bacon;
    AddPineappleCommand pineapple;
    AddMushroomCommand mushroom;
    AddSeafoodCommand seafood;

    function setUp() public {
        pizza = new Pizza();
        order = new PizzaOrder();

        cheese = new AddCheeseCommand(pizza);
        bacon = new AddBaconCommand(pizza);
        pineapple = new AddPineappleCommand(pizza);
        mushroom = new AddMushroomCommand(pizza);
        seafood = new AddSeafoodCommand(pizza);
    }

    function testAddCheese() public {
        order.executeCommand(cheese);

        string[] memory ingredients = pizza.getIngredients();

        assertEq(ingredients.length, 1);
        assertEq(ingredients[0], "Cheese");
    }

    function testAddSeveralIngredients() public {
        order.executeCommand(cheese);
        order.executeCommand(bacon);
        order.executeCommand(mushroom);

        string[] memory ingredients = pizza.getIngredients();

        assertEq(ingredients.length, 3);

        assertEq(ingredients[0], "Cheese");
        assertEq(ingredients[1], "Bacon");
        assertEq(ingredients[2], "Mushroom");
    }

    function testCustomRecipe() public {
        order.executeCommand(pineapple);
        order.executeCommand(seafood);
        order.executeCommand(cheese);

        string[] memory ingredients = pizza.getIngredients();

        assertEq(ingredients.length, 3);

        assertEq(ingredients[0], "Pineapple");
        assertEq(ingredients[1], "Seafood");
        assertEq(ingredients[2], "Cheese");
    }

    function testAllIngredients() public {
        order.executeCommand(cheese);
        order.executeCommand(bacon);
        order.executeCommand(pineapple);
        order.executeCommand(mushroom);
        order.executeCommand(seafood);

        string[] memory ingredients = pizza.getIngredients();

        assertEq(ingredients.length, 5);

        assertEq(ingredients[0], "Cheese");
        assertEq(ingredients[1], "Bacon");
        assertEq(ingredients[2], "Pineapple");
        assertEq(ingredients[3], "Mushroom");
        assertEq(ingredients[4], "Seafood");
    }

    function testCommandsUseSameReceiver() public {
        assertEq(address(cheese.pizza()), address(pizza));
        assertEq(address(bacon.pizza()), address(pizza));
        assertEq(address(pineapple.pizza()), address(pizza));
        assertEq(address(mushroom.pizza()), address(pizza));
        assertEq(address(seafood.pizza()), address(pizza));
    }
}
