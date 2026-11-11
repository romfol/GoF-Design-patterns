# Design Patterns in Solidity

[![CI](https://github.com/romfol/GoF-Design-patterns/actions/workflows/ci.yml/badge.svg)](https://github.com/romfol/GoF-Design-patterns/actions/workflows/ci.yml)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.34-363636?logo=solidity)](https://soliditylang.org/)
[![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFDB1C)](https://getfoundry.sh/)
[![Tests](https://img.shields.io/badge/tests-140%20passing-brightgreen)](#testing)
[![Coverage](https://img.shields.io/badge/coverage-97%25-brightgreen)](#testing)
[![Patterns](https://img.shields.io/badge/patterns-19-blue)](#patterns)
[![GitHub stars](https://img.shields.io/github/stars/romfol/GoF-Design-patterns?style=social)](https://github.com/romfol/GoF-Design-patterns)

The Gang of Four (GoF) design patterns, implemented in **Solidity** with **Foundry** and **OpenZeppelin** — one folder per pattern, one test suite per pattern, no fluff.

Most design-pattern resources are written in Java, C#, or TypeScript. This repository shows what those patterns actually look like on-chain: contracts, interfaces, storage, clones, access control, and gas-aware composition. Every pattern is small enough to read in one sitting and tested so you can see the behaviour, not just the UML.

If you learn something here, a star helps others find it.

## Why this repository

- **19 patterns**, each isolated in its own numbered folder.
- **140 passing tests** covering happy paths, edge cases, and reverts.
- **Real Solidity**, not pseudocode — enums, immutables, interfaces, modifiers, clones, and OpenZeppelin primitives.
- **Consistent structure** so you can compare patterns side by side.
- **Small contracts** you can copy into your own project and adapt.

## Patterns

| # | Pattern | Category | Example in this repo |
|---|---------|----------|----------------------|
| 01 | [Factory](src/01_Factory/index.sol) | Creational | `Factory.init(Dish)` deploys a `Sushi` or `Pizza` oven |
| 02 | [Abstract Factory](src/02_AbstractFactory/index.sol) | Creational | `CuisineFactory` creates Japanese, American, or Ukrainian menus |
| 03 | [Prototype](src/03_Prototype/index.sol) | Creational | `CarFactory` clones prototypes with OpenZeppelin `Clones` |
| 04 | [Builder](src/04_Builder/index.sol) | Creational | Fluent per-user pizza builder with `addCheese().addBacon().build()` |
| 05 | [Multitone](src/05_Multitone/index.sol) | Creational | Owner-controlled registry capped at 10 instances |
| 06 | [Facade](src/06_Facade/index.sol) | Structural | One calculator facade over add/subtract/multiply/divide services |
| 07 | [Adapter](src/07_Adapter/index.sol) | Structural | `DeutscherRechner` adapted to the `ICalculator` interface |
| 08 | [Bridge](src/08_Bridge/index.sol) | Structural | Cuisine implementations bridged with dish abstractions |
| 09 | [Proxy](src/09_Proxy/index.sol) | Structural | Caching proxy around the calculator |
| 10 | [Decorator](src/10_Decorator/index.sol) | Structural | Stackable pizza toppings |
| 11 | [Observer](src/11_Observer/index.sol) | Behavioural | Storm warnings pushed to a school, airport, and road service |
| 12 | [State](src/12_State/index.sol) | Behavioural | Oven transitions between cold, ready, and overheat states |
| 13 | [Strategy](src/13_Strategy/index.sol) | Behavioural | Swappable bubble-sort and quick-sort strategies |
| 14 | [Chain of Responsibility](src/14_ChainOfResponsibility/index.sol) | Behavioural | Emergency dispatcher routes fire, police, and medical events |
| 15 | [Command](src/15_Command/index.sol) | Behavioural | Pizza order built from command objects |
| 16 | [Visitor](src/16_Visitor/index.sol) | Behavioural | `RecipeVisitor` walks pizza ingredients |
| 17 | [Mediator](src/17_Mediator/index.sol) | Behavioural | Concierge coordinating taxi, repair, and flower services |
| 18 | [Memento](src/18_Memento/index.sol) | Behavioural | `TextEditor` with versioned snapshots and restore |
| 19 | [Template Method](src/19_TemplateMethod/index.sol) | Behavioural | File writers sharing a fixed `write()` algorithm |

### Learning path

1. **Creational** (`01`–`05`) — how objects and contract instances are created.
2. **Structural** (`06`–`10`) — how contracts are composed and wrapped.
3. **Behavioural** (`11`–`19`) — how contracts communicate and delegate behaviour.

## Repository structure

```text
.
├── src/
│   ├── 01_Factory/index.sol
│   ├── 02_AbstractFactory/index.sol
│   ├── 03_Prototype/index.sol
│   ├── ...
│   └── 19_TemplateMethod/index.sol
├── test/
│   ├── 01_Factory.t.sol
│   ├── 02_AbstractFactory.t.sol
│   ├── 03_Prototype.t.sol
│   ├── ...
│   └── 19_TemplateMethod.t.sol
├── lib/
│   ├── forge-std/
│   └── openzeppelin-contracts/
├── foundry.toml
└── remappings.txt
```

Each pattern lives in `src/NN_PatternName/index.sol`. Its tests live in `test/NN_PatternName.t.sol`, so implementation and behaviour stay in sync.

## Getting started

### Requirements

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Git

### Clone and run

```shell
git clone --recurse-submodules git@github.com:romfol/GoF-Design-patterns.git
cd GoF-Design-patterns

forge build
forge test
```

If you already cloned without submodules:

```shell
git submodule update --init --recursive
```

### Useful commands

```shell
forge build                  # compile contracts
forge test                   # run all tests
forge test -vvv              # run tests with traces
forge test --match-path test/13_Strategy.t.sol
forge fmt                    # format Solidity
forge snapshot               # gas snapshot
```

## Testing

Every pattern has a dedicated Forge test suite. The suite currently covers **140 tests**, including:

- expected behaviour and state transitions,
- access control and ownership,
- invalid inputs and reverts,
- independent instances and isolation between users,
- clone and prototype semantics.

```shell
forge test
```

```text
Ran 19 test suites: 140 tests passed, 0 failed, 0 skipped (140 total tests)
```

Line coverage is currently **97%**. Generate the full report locally with:

```shell
forge coverage --report summary --report lcov
```

## Continuous integration

Every push and pull request to `main` runs the GitHub Actions workflow in [`.github/workflows/ci.yml`](.github/workflows/ci.yml):

- `forge fmt --check` to enforce formatting,
- `forge build --sizes` to catch build and contract-size issues,
- `forge test -vvv` to run the full suite,
- `forge coverage` to publish an `lcov.info` artifact.

Run the same checks locally before opening a PR:

```shell
forge fmt
forge build --sizes
forge test
```

## Example

The Builder keeps per-user configuration and returns the builder for chaining:

```solidity
Pizza pizza = Pizza(
    builder.addCheese().addBacon().addMushrooms().build()
);
```

The Strategy pattern swaps sorting algorithms behind one interface:

```solidity
Sorter sorter = new Sorter(new QuickSort());
sorter.sort(values);

sorter.setStrategy(new BubbleSort());
sorter.sort(values);
```

See the matching contracts and tests for the rest.

## Contributing

Contributions are welcome:

1. Add a new pattern in `src/NN_PatternName/index.sol`.
2. Add tests in `test/NN_PatternName.t.sol`.
3. Run `forge fmt` and `forge test`.
4. Open a pull request describing the pattern and its on-chain trade-offs.

Bug fixes, clearer examples, and better tests are just as valuable as new patterns.

## Acknowledgements

- [Foundry](https://github.com/foundry-rs/foundry) for the fast Solidity toolchain.
- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) for `Ownable` and `Clones`.
- The Gang of Four for the original catalogue.

## License

Each source file declares its own SPDX license (`MIT` or `GPL-3.0`) in its header. Check the file you intend to reuse.

---

If this repository helped you understand design patterns in Solidity, consider starring it so more developers can find it.
