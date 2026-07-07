// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/17_Memento/index.sol";

contract MementoPatternTest is Test {
    TextEditor editor;

    function setUp() public {
        editor = new TextEditor();
    }

    function testSaveFirstVersion() public {
        editor.save("Hello");

        assertEq(editor.document(), "Hello");
        assertEq(editor.versionsCount(), 1);
    }

    function testSaveMultipleVersions() public {
        editor.save("Version 1");
        editor.save("Version 2");
        editor.save("Version 3");

        assertEq(editor.document(), "Version 3");
        assertEq(editor.versionsCount(), 3);
    }

    function testRestoreFirstVersion() public {
        editor.save("Version 1");
        editor.save("Version 2");

        editor.restore(0);

        assertEq(editor.document(), "Version 1");
    }

    function testRestoreMiddleVersion() public {
        editor.save("A");
        editor.save("B");
        editor.save("C");

        editor.restore(1);

        assertEq(editor.document(), "B");
    }

    function testRestoreLatestVersion() public {
        editor.save("Old");
        editor.save("New");

        editor.restore(1);

        assertEq(editor.document(), "New");
    }

    function testRestoreDoesNotDeleteHistory() public {
        editor.save("A");
        editor.save("B");
        editor.save("C");

        editor.restore(0);

        assertEq(editor.document(), "A");
        assertEq(editor.versionsCount(), 3);
    }

    function testCanRestoreAfterMultipleRestores() public {
        editor.save("First");
        editor.save("Second");
        editor.save("Third");

        editor.restore(0);
        assertEq(editor.document(), "First");

        editor.restore(2);
        assertEq(editor.document(), "Third");

        editor.restore(1);
        assertEq(editor.document(), "Second");
    }

    function testRestoreInvalidVersionReverts() public {
        editor.save("Only version");

        vm.expectRevert();
        editor.restore(1);
    }
}
