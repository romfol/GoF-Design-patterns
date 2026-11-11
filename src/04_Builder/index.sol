// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

contract Pizza {
    string public name;
    bool public cheese;
    bool public bacon;
    bool public pineapple;
    bool public mushrooms;
    bool public seafood;

    constructor(string memory _name, bool _cheese, bool _bacon, bool _pineapple, bool _mushrooms, bool _seafood) {
        name = _name;
        cheese = _cheese;
        bacon = _bacon;
        pineapple = _pineapple;
        mushrooms = _mushrooms;
        seafood = _seafood;
    }
}

contract Builder {
    struct PizzaConfig {
        bool cheese;
        bool bacon;
        bool pineapple;
        bool mushrooms;
        bool seafood;
    }

    mapping(address => PizzaConfig) private configs;

    function addCheese() external returns (Builder) {
        configs[msg.sender].cheese = true;
        return this;
    }

    function addBacon() external returns (Builder) {
        configs[msg.sender].bacon = true;
        return this;
    }

    function addPineapple() external returns (Builder) {
        configs[msg.sender].pineapple = true;
        return this;
    }

    function addMushrooms() external returns (Builder) {
        configs[msg.sender].mushrooms = true;
        return this;
    }

    function addSeafood() external returns (Builder) {
        configs[msg.sender].seafood = true;
        return this;
    }

    function build() external returns (address) {
        PizzaConfig storage config = configs[msg.sender];

        string memory name = "MEDIUM";
        if (config.cheese && config.bacon) {
            name = "TOP";
        }

        Pizza pizza = new Pizza(name, config.cheese, config.bacon, config.pineapple, config.mushrooms, config.seafood);

        delete configs[msg.sender];

        return address(pizza);
    }
}
