// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    uint256 number = 1;

    FundMe fundMe;

    function setUp() public {
        fundMe = new FundMe();
        // A fundMe variable of type FundMe its being created a new FundMe() contract
    }

    function testMininumDollarIsFive() public {
        console.log("Minimum USD is:", fundMe.MINIMUM_USD());
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
}
