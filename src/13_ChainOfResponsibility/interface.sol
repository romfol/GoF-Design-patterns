// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

enum EmergencyType {
    FIRE,
    CRIME,
    MEDICAL
}

error UnknownEmergency();

interface IEmergencyService {
    function handleEmergency() external returns (string memory);
}
