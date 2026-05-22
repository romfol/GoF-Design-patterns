// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.34;

enum Dish {
    Sushi,
    Pizza
}

error NonSupportedDish();

interface IFactory {
    function init(Dish _dish) external;
    function cook(Dish _dish) external view returns (string memory);
}

contract Factory is IFactory {
    Sushi sushi;
    Pizza pizza;

    function init(Dish _dish) external {
        Dish dish = _dish;

        if (dish == Dish.Sushi) {
            sushi = new Sushi();
        } else {
            pizza = new Pizza();
        }
    }

    function cook(Dish _dish) external view returns (string memory) {
        Dish dish = _dish;

        if (dish == Dish.Sushi) {
            return sushi.bake();
        } else {
            return pizza.bake();
        }
    }
}

abstract contract Oven {
    function bake() external pure virtual returns (string memory);
}

contract Sushi is Oven {
    function bake() external pure override returns (string memory dish) {
        dish = "your's sushi";
    }
}

contract Pizza is Oven {
    function bake() external pure override returns (string memory dish) {
        dish = "your's pizza";
    }
}
