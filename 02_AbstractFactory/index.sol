// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.34;

enum Cuisine {
    Japanese,
    American,
    Ukrainian
}

abstract contract AbstractFactory {
    function prepareComplexDinner()
        external
        pure
        virtual
        returns (string memory);
}

contract JapaneseCuisine is AbstractFactory {
    function prepareComplexDinner()
        external
        pure
        override
        returns (string memory)
    {
        return "Your's Japanese dinner";
    }
}

contract AmericanCuisine is AbstractFactory {
    function prepareComplexDinner()
        external
        pure
        override
        returns (string memory)
    {
        return "Your's American dinner";
    }
}

contract UkrainianCuisine is AbstractFactory {
    function prepareComplexDinner()
        external
        pure
        override
        returns (string memory)
    {
        return "Your's Ukrainian dinner";
    }
}

contract CuisineFactory {
    function create(Cuisine _cuisine) external returns (AbstractFactory) {
        if (_cuisine == Cuisine.Japanese) return new JapaneseCuisine();
        if (_cuisine == Cuisine.American) return new AmericanCuisine();
        return new UkrainianCuisine();
    }
}

// Client

contract Cafe {
    CuisineFactory private factory;

    constructor(CuisineFactory _factory) {
        factory = _factory;
    }

    function prepareComplexDinner(
        Cuisine _cuisine
    ) external returns (string memory) {
        AbstractFactory cuisine = factory.create(_cuisine);
        return cuisine.prepareComplexDinner();
    }
}
