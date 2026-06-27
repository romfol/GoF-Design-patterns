// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";

import "../src/13_ChainOfResponsibility/index.sol";

contract ChainOfResponsibilityTest is Test {
    EmergencyDispatcher dispatcher;

    FireDepartment fireDepartment;
    Police police;
    MedicalService medicalService;

    function setUp() public {
        fireDepartment = new FireDepartment();
        police = new Police();
        medicalService = new MedicalService();

        dispatcher = new EmergencyDispatcher(
            IEmergencyService(address(fireDepartment)),
            IEmergencyService(address(police)),
            IEmergencyService(address(medicalService))
        );
    }

    function testDispatchFireDepartment() public {
        string memory response = dispatcher.dispatch(EmergencyType.FIRE);

        assertEq(response, "Fire department dispatched");
    }

    function testDispatchPolice() public {
        string memory response = dispatcher.dispatch(EmergencyType.CRIME);

        assertEq(response, "Police dispatched");
    }

    function testDispatchMedicalService() public {
        string memory response = dispatcher.dispatch(EmergencyType.MEDICAL);

        assertEq(response, "Medical service dispatched");
    }
}
