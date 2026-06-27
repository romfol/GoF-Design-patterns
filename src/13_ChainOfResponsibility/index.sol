// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./interface.sol";

contract FireDepartment is IEmergencyService {
    function handleEmergency() external pure returns (string memory) {
        return "Fire department dispatched";
    }
}

contract Police is IEmergencyService {
    function handleEmergency() external pure returns (string memory) {
        return "Police dispatched";
    }
}

contract MedicalService is IEmergencyService {
    function handleEmergency() external pure returns (string memory) {
        return "Medical service dispatched";
    }
}

contract EmergencyDispatcher {
    mapping(EmergencyType => IEmergencyService) public services;

    constructor(
        IEmergencyService fire,
        IEmergencyService police,
        IEmergencyService medical
    ) {
        services[EmergencyType.FIRE] = fire;
        services[EmergencyType.CRIME] = police;
        services[EmergencyType.MEDICAL] = medical;
    }

    function dispatch(
        EmergencyType emergencyType
    ) external returns (string memory) {
        IEmergencyService service = services[emergencyType];

        if (address(service) == address(0)) {
            revert UnknownEmergency();
        }

        return service.handleEmergency();
    }
}
