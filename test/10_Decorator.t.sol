// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol";

import "../src/10_Decorator/index.sol";

contract DecoratorTest is Test {
    function testPlainPizza() public {
        IPizza pizza = new Pizza();

        assertEq(pizza.getDescription(), "Pizza with ");
    }

    function testPizzaWithCheese() public {
        IPizza pizza = new Pizza();

        CheeseDecorator cheese = new CheeseDecorator(pizza);

        assertEq(cheese.getDescription(), "Pizza with Cheese,");
    }

    function testPizzaWithCheeseAndBacon() public {
        IPizza pizza = new Pizza();

        CheeseDecorator cheese = new CheeseDecorator(pizza);

        BaconDecorator bacon = new BaconDecorator(cheese);

        assertEq(bacon.getDescription(), "Pizza with Cheese,Bacon,");
    }

    function testFullCustomPizza() public {
        SeafoodDecorator seafood =
            new SeafoodDecorator(new MushroomDecorator(new BaconDecorator(new CheeseDecorator(new Pizza()))));

        assertEq(seafood.getDescription(), "Pizza with Cheese,Bacon,Mushroom,Seafood,");
    }

    function testDifferentOrderProducesDifferentResult() public {
        IPizza pizza = new Pizza();

        SeafoodDecorator seafood = new SeafoodDecorator(pizza);

        CheeseDecorator cheese = new CheeseDecorator(seafood);

        assertEq(cheese.getDescription(), "Pizza with Seafood,Cheese,");
    }
}
