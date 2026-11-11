// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

error UnknownEmergency();

enum EmergencyType {
    FIRE,
    CRIME,
    MEDICAL
}

interface IEmergencyHandler {
    function setNext(IEmergencyHandler next) external;
    function handle(EmergencyType emergencyType) external returns (string memory);
}
