// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

interface ISortStrategy {
    function sort(
        uint256[] memory data
    ) external pure returns (uint256[] memory);
}

contract Sorter {
    ISortStrategy public strategy;

    constructor(ISortStrategy initialStrategy) {
        strategy = initialStrategy;
    }

    function setStrategy(ISortStrategy newStrategy) external {
        strategy = newStrategy;
    }

    function sort(
        uint256[] memory data
    ) external view returns (uint256[] memory) {
        return strategy.sort(data);
    }
}

contract BubbleSort is ISortStrategy {
    function sort(
        uint256[] memory data
    ) external pure returns (uint256[] memory) {
        uint256 length = data.length;

        for (uint256 i; i < length; i++) {
            for (uint256 j; j < length - i - 1; j++) {
                if (data[j] > data[j + 1]) {
                    (data[j], data[j + 1]) = (data[j + 1], data[j]);
                }
            }
        }

        return data;
    }
}

contract QuickSort is ISortStrategy {
    function sort(
        uint256[] memory data
    ) external pure returns (uint256[] memory) {
        if (data.length > 1) {
            quickSort(data, int256(0), int256(data.length - 1));
        }

        return data;
    }

    function quickSort(
        uint256[] memory arr,
        int256 left,
        int256 right
    ) internal pure {
        int256 i = left;
        int256 j = right;

        if (i >= j) {
            return;
        }

        uint256 pivot = arr[uint256(left + (right - left) / 2)];

        while (i <= j) {
            while (arr[uint256(i)] < pivot) {
                i++;
            }

            while (arr[uint256(j)] > pivot) {
                j--;
            }

            if (i <= j) {
                (arr[uint256(i)], arr[uint256(j)]) = (
                    arr[uint256(j)],
                    arr[uint256(i)]
                );

                i++;
                j--;
            }
        }

        if (left < j) {
            quickSort(arr, left, j);
        }

        if (i < right) {
            quickSort(arr, i, right);
        }
    }
}
