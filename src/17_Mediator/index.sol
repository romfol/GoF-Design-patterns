// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "./interface.sol";

contract Concierge is IMediator {
    IService public immutable taxi;
    IService public immutable repair;
    IService public immutable flowers;

    event CustomerNotified(address indexed customer, string message);

    constructor(IService _taxi, IService _repair, IService _flowers) {
        taxi = _taxi;
        repair = _repair;
        flowers = _flowers;

        taxi.setMediator(this);
        repair.setMediator(this);
        flowers.setMediator(this);
    }

    function requestService(ServiceType serviceType, address customer) external override {
        if (serviceType == ServiceType.TAXI) {
            taxi.perform(customer);
        } else if (serviceType == ServiceType.HOME_REPAIR) {
            repair.perform(customer);
        } else {
            flowers.perform(customer);
        }
    }

    function notifyCustomer(address customer, string calldata message) external {
        emit CustomerNotified(customer, message);
    }
}

contract TaxiService is IService {
    IMediator public mediator;

    function setMediator(IMediator _mediator) external {
        mediator = _mediator;
    }

    function perform(address customer) external {
        mediator.notifyCustomer(customer, "Taxi is on the way");
    }
}

contract HomeRepairService is IService {
    IMediator public mediator;

    function setMediator(IMediator _mediator) external {
        mediator = _mediator;
    }

    function perform(address customer) external {
        mediator.notifyCustomer(customer, "Repair master is coming");
    }
}

contract FlowerDeliveryService is IService {
    IMediator public mediator;

    function setMediator(IMediator _mediator) external override {
        mediator = _mediator;
    }

    function perform(address customer) external override {
        mediator.notifyCustomer(customer, "Flowers are on the way");
    }
}

contract Customer {
    IMediator public mediator;

    constructor(IMediator _mediator) {
        mediator = _mediator;
    }

    function callTaxi() external {
        mediator.requestService(ServiceType.TAXI, address(this));
    }

    function callRepair() external {
        mediator.requestService(ServiceType.HOME_REPAIR, address(this));
    }

    function orderFlowers() external {
        mediator.requestService(ServiceType.FLOWERS, address(this));
    }
}
