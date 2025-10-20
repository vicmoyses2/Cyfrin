// Get funds from users
// Withdraw funds, owner only
// Set a minimum funding value is USD


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5e18; // == 5 * 1e18 == 5 * (10 ** 18) -- In Solidity "^" is represented with "**"
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        // Allow user to send $
        // Have a minum $ sent - USD $5        
        require(getConversionRate(msg.value) >= minimumUsd, "not engough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }


    function getPrice() public view returns(uint256){
        // Contract Adders - 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        // 1 ETH = 1,000000000000000000 (18 decimals)
        // ETH / USD = 2.000,000000000000000000 (18 decimals)

        uint256 ethPrice = getPrice();

        // 2.000,000000000000000000 * 1,000000000000000000 = 2.000,000000000000000000000000000000000000 (2k,1e36)
        // Dividing it by 1e18, it return to 18 zeros after the comma.
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;        
    }

}