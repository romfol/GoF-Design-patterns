// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./interface.sol";

contract Cheese is IIngredient {
    function accept(IPizzaVisitor visitor) external {
        visitor.visit(address(this));
    }

    function name() external pure returns (string memory) {
        return "Cheese";
    }
}

contract Bacon is IIngredient {
    function accept(IPizzaVisitor visitor) external {
        visitor.visit(address(this));
    }

    function name() external pure returns (string memory) {
        return "Bacon";
    }
}

contract Pineapple is IIngredient {
    function accept(IPizzaVisitor visitor) external {
        visitor.visit(address(this));
    }

    function name() external pure returns (string memory) {
        return "Pineapple";
    }
}

contract Mushroom is IIngredient {
    function accept(IPizzaVisitor visitor) external {
        visitor.visit(address(this));
    }

    function name() external pure returns (string memory) {
        return "Mushroom";
    }
}

contract Seafood is IIngredient {
    function accept(IPizzaVisitor visitor) external {
        visitor.visit(address(this));
    }

    function name() external pure returns (string memory) {
        return "Seafood";
    }
}

contract Pizza {
    IIngredient[] public ingredients;

    function addIngredient(IIngredient ingredient) external {
        ingredients.push(ingredient);
    }

    function accept(IPizzaVisitor visitor) external {
        uint256 length = ingredients.length;

        for (uint256 i; i < length; i++) {
            ingredients[i].accept(visitor);
        }
    }
}

contract RecipeVisitor is IPizzaVisitor {
    string[] public recipe;

    function visit(address ingredient) external {
        recipe.push(IIngredient(ingredient).name());
    }

    function getRecipe() external view returns (string[] memory) {
        return recipe;
    }
}
