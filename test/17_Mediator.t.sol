// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/17_Mediator/index.sol";

contract MediatorPatternTest is Test {
    IService taxi;
    IService repair;
    IService flowers;
    IMediator concierge;

    Customer customer;

    function setUp() public {
        taxi = new TaxiService();
        repair = new HomeRepairService();
        flowers = new FlowerDeliveryService();
        concierge = new Concierge(taxi, repair, flowers);

        customer = new Customer(concierge);
    }

    function testTaxiRequest() public {
        vm.expectEmit();
        emit Concierge.CustomerNotified(
            address(customer),
            "Taxi is on the way"
        );

        customer.callTaxi();
    }

    function testRepairRequest() public {
        vm.expectEmit(true, false, false, true);
        emit Concierge.CustomerNotified(
            address(customer),
            "Repair master is coming"
        );

        customer.callRepair();
    }

    function testFlowerRequest() public {
        vm.expectEmit(true, false, false, true);
        emit Concierge.CustomerNotified(
            address(customer),
            "Flowers are on the way"
        );

        customer.orderFlowers();
    }
}
