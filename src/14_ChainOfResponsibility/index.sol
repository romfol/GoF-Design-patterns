// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./interface.sol";

abstract contract EmergencyHandler is IEmergencyHandler {
    IEmergencyHandler public nextHandler;
    EmergencyType public immutable supportedType;

    constructor(EmergencyType _supportedType) {
        supportedType = _supportedType;
    }

    function setNext(IEmergencyHandler next) external override {
        nextHandler = next;
    }

    function handle(EmergencyType emergencyType) external returns (string memory) {
        if (emergencyType == supportedType) {
            return process();
        }

        if (address(nextHandler) == address(0)) {
            revert UnknownEmergency();
        }

        return nextHandler.handle(emergencyType);
    }

    function process() internal virtual returns (string memory);
}

contract FireDepartment is EmergencyHandler {
    constructor() EmergencyHandler(EmergencyType.FIRE) {}

    function process() internal pure override returns (string memory) {
        return "Fire department dispatched";
    }
}

contract Police is EmergencyHandler {
    constructor() EmergencyHandler(EmergencyType.CRIME) {}

    function process() internal pure override returns (string memory) {
        return "Police dispatched";
    }
}

contract MedicalService is EmergencyHandler {
    constructor() EmergencyHandler(EmergencyType.MEDICAL) {}

    function process() internal pure override returns (string memory) {
        return "Medical service dispatched";
    }
}

contract EmergencyDispatcher {
    IEmergencyHandler public firstHandler;

    constructor(IEmergencyHandler _firstHandler) {
        firstHandler = _firstHandler;
    }

    function dispatch(EmergencyType emergencyType) external returns (string memory) {
        return firstHandler.handle(emergencyType);
    }
}
