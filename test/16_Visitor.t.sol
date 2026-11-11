// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/16_Visitor/index.sol";

contract VisitorPatternTest is Test {
    Pizza pizza;
    RecipeVisitor visitor;
    Cheese cheese;
    Bacon bacon;
    Pineapple pineapple;
    Mushroom mushroom;
    Seafood seafood;

    function setUp() public {
        pizza = new Pizza();
        visitor = new RecipeVisitor();
        cheese = new Cheese();
        bacon = new Bacon();
        pineapple = new Pineapple();
        mushroom = new Mushroom();
        seafood = new Seafood();
    }

    function testSingleIngredient() public {
        pizza.addIngredient(cheese);
        pizza.accept(visitor);
        string[] memory recipe = visitor.getRecipe();

        assertEq(recipe.length, 1);
        assertEq(recipe[0], "Cheese");
    }

    function testCustomRecipe() public {
        pizza.addIngredient(cheese);
        pizza.addIngredient(bacon);
        pizza.addIngredient(mushroom);
        pizza.accept(visitor);
        string[] memory recipe = visitor.getRecipe();

        assertEq(recipe.length, 3);
        assertEq(recipe[0], "Cheese");
        assertEq(recipe[1], "Bacon");
        assertEq(recipe[2], "Mushroom");
    }

    function testAllIngredients() public {
        pizza.addIngredient(cheese);
        pizza.addIngredient(bacon);
        pizza.addIngredient(pineapple);
        pizza.addIngredient(mushroom);
        pizza.addIngredient(seafood);
        pizza.accept(visitor);

        string[] memory recipe = visitor.getRecipe();

        assertEq(recipe.length, 5);
        assertEq(recipe[0], "Cheese");
        assertEq(recipe[1], "Bacon");
        assertEq(recipe[2], "Pineapple");
        assertEq(recipe[3], "Mushroom");
        assertEq(recipe[4], "Seafood");
    }

    function testEmptyPizza() public {
        pizza.accept(visitor);

        string[] memory recipe = visitor.getRecipe();

        assertEq(recipe.length, 0);
    }
}
