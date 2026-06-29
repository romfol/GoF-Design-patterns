// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";

import "../src/11_State/index.sol";

contract StatePatternTest is Test {
    Oven oven;

    ColdState cold;
    ReadyState ready;
    OverheatState overheat;

    function setUp() public {
        cold = new ColdState();
        ready = new ReadyState();
        overheat = new OverheatState();

        oven = new Oven(cold, ready, overheat);
    }
    function testInitialStateIsCold() public view {
        assertEq(address(oven.state()), address(cold));
    }

    function testBakeRevertsWhenCold() public {
        vm.expectRevert();

        oven.bake();
    }

    function testColdToReady() public {
        oven.goReady();

        assertEq(address(oven.state()), address(ready));
    }

    function testBakeWorksWhenReady() public {
        oven.goReady();

        string memory dish = oven.bake();

        assertEq(dish, "your's dish on the plate");
    }

    function testReadyToOverheat() public {
        oven.goReady();

        oven.goOverheat();

        assertEq(address(oven.state()), address(overheat));
    }

    function testBakeRevertsWhenOverheated() public {
        oven.goReady();

        oven.goOverheat();

        vm.expectRevert();

        oven.bake();
    }

    function testOverheatToReady() public {
        oven.goReady();

        oven.goOverheat();

        oven.goReady();

        assertEq(address(oven.state()), address(ready));
    }

    function testReadyToCold() public {
        oven.goReady();

        oven.goCold();

        assertEq(address(oven.state()), address(cold));
    }

    function testFullStateCycle() public {
        assertEq(address(oven.state()), address(cold));

        oven.goReady();

        assertEq(address(oven.state()), address(ready));

        oven.goOverheat();

        assertEq(address(oven.state()), address(overheat));

        oven.goCold();

        assertEq(address(oven.state()), address(cold));
    }
}
