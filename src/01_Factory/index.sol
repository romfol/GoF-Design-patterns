// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.34;

enum Dish {
    Sushi,
    Pizza
}

contract Factory {
    function init(Dish _dish) external returns (address) {
        Dish dish = _dish;

        if (dish == Dish.Sushi) {
            return address(new Sushi());
        } else {
            return address(new Pizza());
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
