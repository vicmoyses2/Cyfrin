// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe; // A fundMe variable of type FundMe

    function setUp() public {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306); // Sepolia ETH / USD Price Feed address
        // A fundMe variable of type FundMe its being created a new FundMe() contract

        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        console.log("FundMe deployed at:", address(fundMe));
        console.log("Contract balance in setup is:", address(fundMe).balance);
        vm.deal(address(fundMe), 0); // force zero for this test
    }

    // Using receive and fallback make this contract able to receive ETH
    receive() external payable {}

    fallback() external payable {}

    function testMininumDollarIsFive() public view {
        console.log("Minimum USD is:", fundMe.MINIMUM_USD());
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log("Deployer is:", address(fundMe));
        console.log("Msg.sender is:", msg.sender);
        console.log("Owner is:", fundMe.i_owner());
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view returns (uint256) {
        console.log("Price Feed Version is:", fundMe.getVersion());
        assertEq(fundMe.getVersion(), 4);
        return fundMe.getVersion();
    }

    function testContractBalanceIsZero() public view {
        console.log("Contract balance is:", address(fundMe).balance);
        assertEq(address(fundMe).balance, 0);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        /* Expect the next line to revert use verbosity "-vvvv" to see more details about the failure */
        fundMe.fund(); // Call fund without sending any ETH
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.deal(address(this), 1 ether); // Give this contract 1 ether
        fundMe.fund{value: 1 ether}(); // Fund the FundMe contract with 1 ether
        uint256 amountFunded = fundMe.addressToAmountFunded(address(this)); // Get the amount funded
        console.log("Amount funded is:", amountFunded); // Log the amount funded
        assertEq(amountFunded, 1 ether); // Check that the amount funded is 1 ether
    }

    function testSendReceiveWorks() public {
        vm.deal(address(this), 1 ether); // Give this contract 1 ether
        (bool success, ) = address(fundMe).call{value: 1 ether}(""); // Send 1 ether to the FundMe contract
        assertTrue(success); // Check that the transaction was successful
    }

    function testSendFallbackWorks() public {
        vm.deal(address(this), 1 ether); // Give this contract 1 ether
        (bool success, ) = address(fundMe).call{value: 1 ether}("0x1234"); // Send 1 ether to the FundMe contract with data
        assertTrue(success); // Check that the transaction was successful
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.deal(address(this), 1 ether); // Give this contract 1 ether
        fundMe.fund{value: 1 ether}(); // Fund the FundMe contract with 1 ether

        vm.prank(address(0xBEEF)); // Change msg.sender to address(0xBEEF)
        vm.expectRevert(); // Expect the next line to revert
        fundMe.withdraw(); // Try to withdraw from the FundMe contract
    }

    function testOnlyOwnerCanWithdraw_SucceedsForOwner() public {
        vm.deal(address(this), 1 ether);
        fundMe.fund{value: 1 ether}();

        // Owner should be able to withdraw
        vm.prank(msg.sender); // optional, if needed to simulate correct sender
        fundMe.withdraw();
        console.log(
            "Contract balance after withdraw is:",
            address(fundMe).balance
        );
        // Optionally, assert that contract balance is now zero
        assertEq(address(fundMe).balance, 0);
    }
}
