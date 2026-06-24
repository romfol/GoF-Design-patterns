// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/10_Observer/index.sol";

contract ObserverTest is Test {
    StormWarningService service;
    School school;
    Airport airport;
    RoadService roadService;

    function setUp() public {
        service = new StormWarningService();

        school = new School();
        airport = new Airport();
        roadService = new RoadService();
    }

    function testAddObservers() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        assertEq(service.observers(0), address(school));
        assertEq(service.observers(1), address(airport));
        assertEq(service.observers(2), address(roadService));
    }

    function testLowWarning() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        service.notifyObservers(WarningLevel.LOW);

        assertEq(uint256(school.lastWarning()), uint256(WarningLevel.LOW));
        assertEq(uint256(airport.lastWarning()), uint256(WarningLevel.LOW));
        assertEq(uint256(roadService.lastWarning()), uint256(WarningLevel.LOW));

        assertFalse(school.closed());
        assertFalse(airport.flightsDelayed());
        assertTrue(roadService.crewsDispatched());
    }

    function testMediumWarning() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        service.notifyObservers(WarningLevel.MEDIUM);

        assertFalse(school.closed());
        assertTrue(airport.flightsDelayed());
        assertTrue(roadService.crewsDispatched());
    }

    function testHighWarning() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        service.notifyObservers(WarningLevel.HIGH);

        assertTrue(school.closed());
        assertTrue(airport.flightsDelayed());
        assertTrue(roadService.crewsDispatched());
    }

    function testRemoveObserver() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        service.remove(address(airport));

        service.notifyObservers(WarningLevel.HIGH);

        assertTrue(school.closed());
        assertTrue(roadService.crewsDispatched());

        // Airport should never receive notification
        assertNotEq(uint256(airport.lastWarning()), uint256(WarningLevel.HIGH));
        assertFalse(airport.flightsDelayed());
    }

    function testRemoveFirstObserver() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        service.remove(address(school));

        service.notifyObservers(WarningLevel.HIGH);

        assertFalse(school.closed());

        assertTrue(airport.flightsDelayed());
        assertTrue(roadService.crewsDispatched());
    }

    function testRemoveLastObserver() public {
        service.add(address(school));
        service.add(address(airport));
        service.add(address(roadService));

        service.remove(address(roadService));

        service.notifyObservers(WarningLevel.HIGH);

        assertTrue(school.closed());
        assertTrue(airport.flightsDelayed());

        assertFalse(roadService.crewsDispatched());
    }
}
