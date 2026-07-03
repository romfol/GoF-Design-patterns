// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/18_TemplateMethod/index.sol";

contract TemplateMethodTest is Test {
    DateWriter dateWriter;
    TimeWriter timeWriter;
    DateTimeWriter dateTimeWriter;

    function setUp() public {
        dateWriter = new DateWriter();
        timeWriter = new TimeWriter();
        dateTimeWriter = new DateTimeWriter();
    }

    function testDateWriter() public {
        dateWriter.write();

        assertEq(dateWriter.fileContent(), "DATE\n");
    }

    function testTimeWriter() public {
        timeWriter.write();

        assertEq(timeWriter.fileContent(), "TIME\n");
    }

    function testDateTimeWriter() public {
        dateTimeWriter.write();

        assertEq(dateTimeWriter.fileContent(), "DATE\nTIME\n");
    }
}
