// Get funds from users
// Withdraw funds, owner only
// Set a minimum funding value is USD


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() internal view returns(uint256){
        // Contract Adders - 0x6D41d1dc818112880b40e26BD6FD347E41008eDA
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x6D41d1dc818112880b40e26BD6FD347E41008eDA);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        // 1 ETH = 1,000000000000000000 (18 decimals)
        // ETH / USD = 2.000,000000000000000000 (18 decimals)

        uint256 ethPrice = getPrice();

        // 2.000,000000000000000000 * 1,000000000000000000 = 2.000,000000000000000000000000000000000000 (2k,1e36)
        // Dividing it by 1e18, it return to 18 zeros after the comma.
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;        
    }

    function getVerson() internal view returns (uint256) {
        return AggregatorV3Interface(0x6D41d1dc818112880b40e26BD6FD347E41008eDA).version();
    }
}

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18; // == 5 * 1e18 == 5 * (10 ** 18) -- In Solidity "^" is represented with "**"

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    error NotOwner();
    error CallFailed();

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Allow user to send $
        // Have a minum $ sent - USD $5        
        //require(getConversionRate(msg.value) >= MINIMUM_USD, "not engough ETH");
        require(msg.value.getConversionRate() >= MINIMUM_USD, "not engough ETH");
        funders.push(msg.sender);

        // The address that donate previously will receive the value of the new donation added to the amount donated
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //  addressToAmountFunded[msg.sender] =+ msg.value <- Same thing as above
    }


    /*function getPrice() public view returns(uint256){
        // Contract Adders - 0x6D41d1dc818112880b40e26BD6FD347E41008eDA
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x6D41d1dc818112880b40e26BD6FD347E41008eDA);
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
    */
    function getVerson() public view returns (uint256) {
        return AggregatorV3Interface(0x6D41d1dc818112880b40e26BD6FD347E41008eDA).version(); // ZKSync Testnet
    }

    function withdraw() onlyOwner public {
        // require(msg.sender == owner, "Must be the owner!");
        // If we need to specify the owner in a numbers of functions, we can use a "modifier"

        // for loop structer
        // for(starting index, ending index, step amount){code here}
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Reseting the array variable
        funders = new address[](0);

        // 3 ways to withdraw the money
        /*
        // 1 - transfer - Automatically revert if fails - Too much gas
        payable(msg.sender).transfer(address(this).balance); // "address(this)" is refering to this contract address
            // "msg.sender" is an address
            // "payable(msg.sender)" is a payable address


        // 2 - send - Don't automatically revert if fails - Too much gas
        payable(msg.sender).send(address(this).balance);
        // Code to revert using "require"
        bool sendSucces = payable(msg.sender).send(address(this).balance);
        require(sendSucces, "Send failed"); // If it fail, will revert

        // 3 - call - Low level code - Low gas cost
        // "call" uses 2 variable but we only need one for now - leave the comma
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        */
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        //require(callSuccess, "Call failed");
        if (!callSuccess) {revert CallFailed();}
    }

    modifier onlyOwner() { // There is no need to put visibility (Ex: public, private) in a modifier
        //require(msg.sender == i_owner, "Send is not the owner");
        if(msg.sender != i_owner) {revert NotOwner();}

        _; // This means that the modifier will execute the code befor the "_;" and then run the code from the function

        /* If put like this:
        _;
        require(msg.sender = owner, "Send is not the owner");
        Will execeute the conde from the function and then the code from the modifier*/

    }

    // Sending money without calling the fund function
    receive() external payable { fund(); }

    fallback() external payable { fund(); }
}