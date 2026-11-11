// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

abstract contract FileWriter {
    string public fileContent;

    function write() external {
        fileContent = "";

        writeDate();
        writeTime();
    }

    function writeDate() internal virtual;

    function writeTime() internal virtual;
}

contract DateWriter is FileWriter {
    function writeDate() internal override {
        fileContent = string.concat(fileContent, "DATE\n");
    }

    function writeTime() internal override {}
}

contract TimeWriter is FileWriter {
    function writeDate() internal override {}

    function writeTime() internal override {
        fileContent = string.concat(fileContent, "TIME\n");
    }
}

contract DateTimeWriter is FileWriter {
    function writeDate() internal override {
        fileContent = string.concat(fileContent, "DATE\n");
    }

    function writeTime() internal override {
        fileContent = string.concat(fileContent, "TIME\n");
    }
}
