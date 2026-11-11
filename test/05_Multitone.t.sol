// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/05_Multitone/index.sol";

contract MultitoneTest is Test {
    Multitone multitone;
    address owner = makeAddr("owner");
    address stranger = makeAddr("stranger");

    function setUp() public {
        vm.prank(owner);
        multitone = new Multitone();
    }

    // ─── Ownership ───────────────────────────────────────────────

    function test_OwnerIsSetOnDeploy() public view {
        assertEq(multitone.owner(), owner);
    }

    function test_StrangerCannotCallInit() public {
        vm.prank(stranger);
        vm.expectRevert();
        multitone.init(1, "hello");
    }

    // ─── init() ──────────────────────────────────────────────────

    function test_InitCreatesInstance() public {
        vm.prank(owner);
        multitone.init(42, "alpha");

        address inst = multitone.getInstance(0);
        assertTrue(inst != address(0));
    }

    function test_InitIncrementsInstances() public {
        vm.startPrank(owner);
        multitone.init(1, "one");
        multitone.init(2, "two");
        multitone.init(3, "three");
        vm.stopPrank();

        // each index returns a distinct address
        assertTrue(multitone.getInstance(0) != multitone.getInstance(1));
        assertTrue(multitone.getInstance(1) != multitone.getInstance(2));
    }

    function test_CanCreateExactlyTenInstances() public {
        vm.startPrank(owner);
        for (uint256 i = 0; i < 10; i++) {
            multitone.init(i, "x");
        }
        vm.stopPrank();

        // all 10 slots filled with non-zero addresses
        for (uint256 i = 0; i < 10; i++) {
            assertTrue(multitone.getInstance(i) != address(0));
        }
    }

    function test_InitRevertsAfterTenInstances() public {
        vm.startPrank(owner);
        for (uint256 i = 0; i < 10; i++) {
            multitone.init(i, "x");
        }
        vm.expectRevert();
        multitone.init(11, "overflow");
        vm.stopPrank();
    }

    // ─── getInstance() ───────────────────────────────────────────

    function test_GetInstanceRevertsOnOutOfBounds() public {
        vm.expectRevert();
        multitone.getInstance(0); // empty array → index out of bounds
    }

    function test_GetInstanceReturnsCorrectAddress() public {
        vm.prank(owner);
        multitone.init(99, "check");

        address inst = multitone.getInstance(0);
        assertTrue(inst.code.length > 0); // is a deployed contract
    }
}
