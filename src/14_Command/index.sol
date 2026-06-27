// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

interface ICommand {
    function execute() external;
}

contract Pizza {
    string[] public ingredients;

    function addIngredient(string memory ingredient) external {
        ingredients.push(ingredient);
    }

    function getIngredients() external view returns (string[] memory) {
        return ingredients;
    }
}

contract AddCheeseCommand is ICommand {
    Pizza public pizza;

    constructor(Pizza _pizza) {
        pizza = _pizza;
    }

    function execute() external {
        pizza.addIngredient("Cheese");
    }
}

contract AddBaconCommand is ICommand {
    Pizza public pizza;

    constructor(Pizza _pizza) {
        pizza = _pizza;
    }

    function execute() external {
        pizza.addIngredient("Bacon");
    }
}

contract AddPineappleCommand is ICommand {
    Pizza public pizza;

    constructor(Pizza _pizza) {
        pizza = _pizza;
    }

    function execute() external {
        pizza.addIngredient("Pineapple");
    }
}

contract AddMushroomCommand is ICommand {
    Pizza public pizza;

    constructor(Pizza _pizza) {
        pizza = _pizza;
    }

    function execute() external {
        pizza.addIngredient("Mushroom");
    }
}

contract AddSeafoodCommand is ICommand {
    Pizza public pizza;

    constructor(Pizza _pizza) {
        pizza = _pizza;
    }

    function execute() external {
        pizza.addIngredient("Seafood");
    }
}

contract PizzaOrder {
    function executeCommand(ICommand command) external {
        command.execute();
    }
}
