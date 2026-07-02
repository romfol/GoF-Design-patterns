// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

contract TextEditor {
    struct Memento {
        string content;
    }

    string public document;
    Memento[] private history;

    function save(string calldata text) external {
        document = text;
        history.push(Memento(text));
    }

    function restore(uint256 version) external {
        document = history[version].content;
    }

    function versionsCount() external view returns (uint256) {
        return history.length;
    }
}
