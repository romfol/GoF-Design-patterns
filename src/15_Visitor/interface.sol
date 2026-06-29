// SPDX-License-Identifier: MIT

pragma solidity 0.8.34;

interface IPizzaVisitor {
    function visit(address ingredient) external;
}

interface IIngredient {
    function accept(IPizzaVisitor visitor) external;
    function name() external pure returns (string memory);
}
