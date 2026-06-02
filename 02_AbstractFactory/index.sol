// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.34;

enum Cuisine {
    Japanese,
    American,
    Ukrainian
}

abstract contract AbstractFactory {
    function prepareFirstDish() external pure virtual returns (string memory);

    function prepareSecondDish() external pure virtual returns (string memory);

    function prepareDessert() external pure virtual returns (string memory);
}

contract JapaneseCuisine is AbstractFactory {
    function prepareFirstDish() external pure override returns (string memory) {
        return "Your's Miso";
    }

    function prepareSecondDish()
        external
        pure
        override
        returns (string memory)
    {
        return "Your's Ramen";
    }

    function prepareDessert() external pure override returns (string memory) {
        return "Your's Mochi";
    }
}

contract AmericanCuisine is AbstractFactory {
    function prepareFirstDish() external pure override returns (string memory) {
        return "Your's clam chowder";
    }

    function prepareSecondDish()
        external
        pure
        override
        returns (string memory)
    {
        return "Your's Burger";
    }

    function prepareDessert() external pure override returns (string memory) {
        return "Your's Apple Pie";
    }
}

contract UkrainianCuisine is AbstractFactory {
    function prepareFirstDish() external pure override returns (string memory) {
        return "Your's Borshch";
    }

    function prepareSecondDish()
        external
        pure
        override
        returns (string memory)
    {
        return "Your's Varenyky";
    }

    function prepareDessert() external pure override returns (string memory) {
        return "Your's Medivnyk";
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

    function prepareComplexDinner(Cuisine _cuisine) external {
        AbstractFactory cuisine = factory.create(_cuisine);
        cuisine.prepareFirstDish();
        cuisine.prepareSecondDish();
        cuisine.prepareDessert();
    }
}
