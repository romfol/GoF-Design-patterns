// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

interface IPizza {
    function getDescription() external view returns (string memory);
}

contract Pizza is IPizza {
    function getDescription() external pure override returns (string memory) {
        return "Pizza with ";
    }
}

abstract contract PizzaDecorator is IPizza {
    IPizza internal pizza;

    constructor(IPizza _pizza) {
        pizza = _pizza;
    }
}

contract CheeseDecorator is PizzaDecorator {
    constructor(IPizza _pizza) PizzaDecorator(_pizza) {}

    function getDescription() external view override returns (string memory) {
        return string.concat(pizza.getDescription(), "Cheese,");
    }
}

contract BaconDecorator is PizzaDecorator {
    constructor(IPizza _pizza) PizzaDecorator(_pizza) {}

    function getDescription() external view override returns (string memory) {
        return string.concat(pizza.getDescription(), "Bacon,");
    }
}

contract PineappleDecorator is PizzaDecorator {
    constructor(IPizza _pizza) PizzaDecorator(_pizza) {}

    function getDescription() external view override returns (string memory) {
        return string.concat(pizza.getDescription(), "Pineapple,");
    }
}

contract MushroomDecorator is PizzaDecorator {
    constructor(IPizza _pizza) PizzaDecorator(_pizza) {}

    function getDescription() external view override returns (string memory) {
        return string.concat(pizza.getDescription(), "Mushroom,");
    }
}

contract SeafoodDecorator is PizzaDecorator {
    constructor(IPizza _pizza) PizzaDecorator(_pizza) {}

    function getDescription() external view override returns (string memory) {
        return string.concat(pizza.getDescription(), "Seafood,");
    }
}
