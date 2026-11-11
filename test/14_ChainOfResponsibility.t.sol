// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";

import "../src/14_ChainOfResponsibility/index.sol";

contract ChainOfResponsibilityTest is Test {
    EmergencyDispatcher dispatcher;

    FireDepartment fireDepartment;
    Police police;
    MedicalService medicalService;

    function setUp() public {
        fireDepartment = new FireDepartment();
        police = new Police();
        medicalService = new MedicalService();

        fireDepartment.setNext(police);
        police.setNext(medicalService);

        dispatcher = new EmergencyDispatcher(fireDepartment);
    }

    function testFireEmergency() public {
        string memory result = dispatcher.dispatch(EmergencyType.FIRE);

        assertEq(result, "Fire department dispatched");
    }

    function testPoliceEmergency() public {
        string memory result = dispatcher.dispatch(EmergencyType.CRIME);

        assertEq(result, "Police dispatched");
    }

    function testMedicalEmergency() public {
        string memory result = dispatcher.dispatch(EmergencyType.MEDICAL);

        assertEq(result, "Medical service dispatched");
    }

    function testEmergencyNotHandled() public {
        police.setNext(IEmergencyHandler(address(0)));

        vm.expectRevert();
        dispatcher.dispatch(EmergencyType.MEDICAL);
    }
}
