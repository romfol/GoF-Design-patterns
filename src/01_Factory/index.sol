// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.34;

enum Dish {
    Sushi,
    Pizza
}

contract Factory {
    event Deployed(address indexed instance, Dish dish);

    function init(Dish _dish) external returns (Oven) {
        Oven oven;
        if (_dish == Dish.Sushi) {
            oven = new Sushi();
        } else {
            oven = new Pizza();
        }
        emit Deployed(address(oven), _dish);
        return oven;
    }
}

abstract contract Oven {
    function bake() public pure virtual returns (string memory);
}

contract Sushi is Oven {
    function bake() public pure override returns (string memory) {
        return "yours, sushi";
    }
}

contract Pizza is Oven {
    function bake() public pure override returns (string memory) {
        return "yours, pizza";
    }
}
