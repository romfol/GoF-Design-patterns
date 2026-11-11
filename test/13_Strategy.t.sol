// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/13_Strategy/index.sol";

contract StrategyTest is Test {
    Sorter sorter;

    BubbleSort bubble;
    QuickSort quick;

    function setUp() public {
        bubble = new BubbleSort();
        quick = new QuickSort();

        sorter = new Sorter(ISortStrategy(address(bubble)));
    }

    function testBubbleSort() public {
        uint256[] memory data = new uint256[](5);

        data[0] = 5;
        data[1] = 1;
        data[2] = 4;
        data[3] = 2;
        data[4] = 3;

        uint256[] memory result = sorter.sort(data);

        assertEq(result[0], 1);
        assertEq(result[1], 2);
        assertEq(result[2], 3);
        assertEq(result[3], 4);
        assertEq(result[4], 5);
    }

    function testQuickSort() public {
        sorter.setStrategy(ISortStrategy(address(quick)));

        uint256[] memory data = new uint256[](5);

        data[0] = 5;
        data[1] = 1;
        data[2] = 4;
        data[3] = 2;
        data[4] = 3;

        uint256[] memory result = sorter.sort(data);

        assertEq(result[0], 1);
        assertEq(result[1], 2);
        assertEq(result[2], 3);
        assertEq(result[3], 4);
        assertEq(result[4], 5);
    }

    function testChangeStrategy() public {
        assertEq(address(sorter.strategy()), address(bubble));

        sorter.setStrategy(ISortStrategy(address(quick)));

        assertEq(address(sorter.strategy()), address(quick));
    }
}
