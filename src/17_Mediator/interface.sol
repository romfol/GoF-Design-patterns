// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

enum ServiceType {
    TAXI,
    HOME_REPAIR,
    FLOWERS
}

interface IMediator {
    function requestService(ServiceType serviceType, address customer) external;
    function notifyCustomer(address customer, string calldata message) external;
}

interface IService {
    function setMediator(IMediator mediator) external;
    function perform(address customer) external;
}
