// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import "forge-std/Test.sol";
import "../src/08_Bridge/index.sol";

contract BridgeTest is Test {
    JapaneseCuisine japaneseCuisine;
    AmericanCuisine americanCuisine;
    UkrainianCuisine ukrainianCuisine;

    FirstDish firstDish;
    SecondDish secondDish;
    ThirdDish thirdDish;
    Dessert dessert;

    Cafe cafe;

    function setUp() public {
        japaneseCuisine = new JapaneseCuisine();
        americanCuisine = new AmericanCuisine();
        ukrainianCuisine = new UkrainianCuisine();

        firstDish = new FirstDish(japaneseCuisine);
        secondDish = new SecondDish(japaneseCuisine);
        thirdDish = new ThirdDish(japaneseCuisine);
        dessert = new Dessert(japaneseCuisine);

        cafe = new Cafe();
    }

    // ─── Japanese Cuisine ────────────────────────────────────────

    function test_FirstDish_Japanese() public {
        assertEq(firstDish.prepare(), "Miso Soup");
    }

    function test_SecondDish_Japanese() public {
        assertEq(secondDish.prepare(), "Ramen");
    }

    function test_ThirdDish_Japanese() public {
        assertEq(thirdDish.prepare(), "Mochi");
    }

    function test_Dessert_Japanese() public {
        assertEq(dessert.prepare(), "Matcha Ice Cream");
    }

    // ─── American Cuisine ────────────────────────────────────────

    function test_FirstDish_American() public {
        firstDish.setImpl(americanCuisine);
        assertEq(firstDish.prepare(), "Clam Chowder");
    }

    function test_SecondDish_American() public {
        secondDish.setImpl(americanCuisine);
        assertEq(secondDish.prepare(), "Burger");
    }

    function test_ThirdDish_American() public {
        thirdDish.setImpl(americanCuisine);
        assertEq(thirdDish.prepare(), "Apple Pie");
    }

    function test_Dessert_American() public {
        dessert.setImpl(americanCuisine);
        assertEq(dessert.prepare(), "Cheesecake");
    }

    // ─── Ukrainian Cuisine ───────────────────────────────────────

    function test_FirstDish_Ukrainian() public {
        firstDish.setImpl(ukrainianCuisine);
        assertEq(firstDish.prepare(), "Borshch");
    }

    function test_SecondDish_Ukrainian() public {
        secondDish.setImpl(ukrainianCuisine);
        assertEq(secondDish.prepare(), "Varenyky");
    }

    function test_ThirdDish_Ukrainian() public {
        thirdDish.setImpl(ukrainianCuisine);
        assertEq(thirdDish.prepare(), "Medivnyk");
    }

    function test_Dessert_Ukrainian() public {
        dessert.setImpl(ukrainianCuisine);
        assertEq(dessert.prepare(), "Pampushky");
    }

    // ─── Cafe Full Dinner ────────────────────────────────────────

    function test_Cafe_JapaneseDinner() public {
        string[4] memory menu = cafe.prepareComplexDinner(
            firstDish,
            secondDish,
            thirdDish,
            dessert
        );

        assertEq(menu[0], "Miso Soup");
        assertEq(menu[1], "Ramen");
        assertEq(menu[2], "Mochi");
        assertEq(menu[3], "Matcha Ice Cream");
    }

    function test_Cafe_AmericanDinner() public {
        firstDish.setImpl(americanCuisine);
        secondDish.setImpl(americanCuisine);
        thirdDish.setImpl(americanCuisine);
        dessert.setImpl(americanCuisine);

        string[4] memory menu = cafe.prepareComplexDinner(
            firstDish,
            secondDish,
            thirdDish,
            dessert
        );

        assertEq(menu[0], "Clam Chowder");
        assertEq(menu[1], "Burger");
        assertEq(menu[2], "Apple Pie");
        assertEq(menu[3], "Cheesecake");
    }

    function test_Cafe_UkrainianDinner() public {
        firstDish.setImpl(ukrainianCuisine);
        secondDish.setImpl(ukrainianCuisine);
        thirdDish.setImpl(ukrainianCuisine);
        dessert.setImpl(ukrainianCuisine);

        string[4] memory menu = cafe.prepareComplexDinner(
            firstDish,
            secondDish,
            thirdDish,
            dessert
        );

        assertEq(menu[0], "Borshch");
        assertEq(menu[1], "Varenyky");
        assertEq(menu[2], "Medivnyk");
        assertEq(menu[3], "Pampushky");
    }

    // ─── Bridge: Switch Impl Without Redeploying ─────────────────

    function test_SwitchCuisine_SameDishContracts() public {
        // Japanese dinner first
        string[4] memory japanese = cafe.prepareComplexDinner(
            firstDish,
            secondDish,
            thirdDish,
            dessert
        );
        assertEq(japanese[0], "Miso Soup");

        // Switch all dishes to Ukrainian — same contract addresses
        firstDish.setImpl(ukrainianCuisine);
        secondDish.setImpl(ukrainianCuisine);
        thirdDish.setImpl(ukrainianCuisine);
        dessert.setImpl(ukrainianCuisine);

        string[4] memory ukrainian = cafe.prepareComplexDinner(
            firstDish,
            secondDish,
            thirdDish,
            dessert
        );
        assertEq(ukrainian[0], "Borshch");
    }

    // ─── Bridge: Mix Cuisines Across Dishes ──────────────────────

    function test_MixedCuisines() public {
        firstDish.setImpl(ukrainianCuisine); // Borshch
        secondDish.setImpl(japaneseCuisine); // Ramen
        thirdDish.setImpl(americanCuisine); // Apple Pie
        dessert.setImpl(ukrainianCuisine); // Pampushky

        string[4] memory menu = cafe.prepareComplexDinner(
            firstDish,
            secondDish,
            thirdDish,
            dessert
        );

        assertEq(menu[0], "Borshch");
        assertEq(menu[1], "Ramen");
        assertEq(menu[2], "Apple Pie");
        assertEq(menu[3], "Pampushky");
    }
}
