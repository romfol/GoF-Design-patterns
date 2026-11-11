// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

enum WarningLevel {
    LOW,
    MEDIUM,
    HIGH
}

error MaxObserversReached();

interface IStormWarningService {
    function add(address observer) external;
    function remove(address observer) external;
    function notifyObservers(WarningLevel level) external;
}

contract StormWarningService is IStormWarningService {
    uint256 public constant MAX_OBSERVERS = 100;
    address[] public observers;

    event StormAlertSent(WarningLevel level);

    function add(address observer) external {
        require(observers.length < MAX_OBSERVERS, MaxObserversReached());
        observers.push(observer);
    }

    function remove(address observer) external {
        uint256 length = observers.length;

        for (uint256 i; i < length; i++) {
            if (observers[i] == observer) {
                observers[i] = observers[length - 1];
                observers.pop();
                return;
            }
        }
    }

    function notifyObservers(WarningLevel level) external {
        uint256 length = observers.length;

        for (uint256 i; i < length; i++) {
            IStormObserver(observers[i]).notify(level);
        }

        emit StormAlertSent(level);
    }
}

interface IStormObserver {
    function notify(WarningLevel level) external;
}

contract School is IStormObserver {
    WarningLevel public lastWarning;
    bool public closed;

    event SchoolClosed();

    function notify(WarningLevel level) external override {
        lastWarning = level;

        if (level == WarningLevel.HIGH) {
            closed = true;
            emit SchoolClosed();
        }
    }
}

contract Airport is IStormObserver {
    WarningLevel public lastWarning;
    bool public flightsDelayed;

    event FlightsDelayed();

    function notify(WarningLevel level) external override {
        lastWarning = level;

        if (level >= WarningLevel.MEDIUM) {
            flightsDelayed = true;
            emit FlightsDelayed();
        }
    }
}

contract RoadService is IStormObserver {
    WarningLevel public lastWarning;
    bool public crewsDispatched;

    event CrewsDispatched();

    function notify(WarningLevel level) external override {
        lastWarning = level;

        crewsDispatched = true;

        emit CrewsDispatched();
    }
}
