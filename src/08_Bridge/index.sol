// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

interface ICuisineImpl {
    function makeFirst() external pure returns (string memory);
    function makeSecond() external pure returns (string memory);
    function makeThird() external pure returns (string memory);
    function makeDessert() external pure returns (string memory);
}

contract JapaneseCuisine is ICuisineImpl {
    function makeFirst() external pure returns (string memory) {
        return "Miso Soup";
    }

    function makeSecond() external pure returns (string memory) {
        return "Ramen";
    }

    function makeThird() external pure returns (string memory) {
        return "Mochi";
    }

    function makeDessert() external pure returns (string memory) {
        return "Matcha Ice Cream";
    }
}

contract AmericanCuisine is ICuisineImpl {
    function makeFirst() external pure returns (string memory) {
        return "Clam Chowder";
    }

    function makeSecond() external pure returns (string memory) {
        return "Burger";
    }

    function makeThird() external pure returns (string memory) {
        return "Apple Pie";
    }

    function makeDessert() external pure returns (string memory) {
        return "Cheesecake";
    }
}

contract UkrainianCuisine is ICuisineImpl {
    function makeFirst() external pure returns (string memory) {
        return "Borshch";
    }

    function makeSecond() external pure returns (string memory) {
        return "Varenyky";
    }

    function makeThird() external pure returns (string memory) {
        return "Medivnyk";
    }

    function makeDessert() external pure returns (string memory) {
        return "Pampushky";
    }
}

abstract contract Dish {
    ICuisineImpl internal impl;

    constructor(ICuisineImpl _impl) {
        impl = _impl;
    }

    function setImpl(ICuisineImpl _impl) external {
        impl = _impl;
    }

    function prepare() external virtual returns (string memory);
}

contract FirstDish is Dish {
    constructor(ICuisineImpl _impl) Dish(_impl) {}

    function prepare() external view override returns (string memory) {
        return impl.makeFirst();
    }
}

contract SecondDish is Dish {
    constructor(ICuisineImpl _impl) Dish(_impl) {}

    function prepare() external view override returns (string memory) {
        return impl.makeSecond();
    }
}

contract ThirdDish is Dish {
    constructor(ICuisineImpl _impl) Dish(_impl) {}

    function prepare() external view override returns (string memory) {
        return impl.makeThird();
    }
}

contract Dessert is Dish {
    constructor(ICuisineImpl _impl) Dish(_impl) {}

    function prepare() external view override returns (string memory) {
        return impl.makeDessert();
    }
}

// client

contract Cafe {
    function prepareComplexDinner(FirstDish _first, SecondDish _second, ThirdDish _third, Dessert _dessert)
        external
        view
        returns (string[4] memory menu)
    {
        menu[0] = _first.prepare();
        menu[1] = _second.prepare();
        menu[2] = _third.prepare();
        menu[3] = _dessert.prepare();
    }
}
