// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24; // specify the Solidity version for the script and contract compatibility
 
import {Script} from "forge-std/Script.sol"; // import the Script contract from forge-std library
import {SimpleStorage} from "../src/SimpleStorage.sol"; // import the contract to be deployed
                                                   // expliciting the path from the script file to the contract file

contract DeploySimpleStorage is Script {
    function run() external returns (SimpleStorage) { // run() is a special function name recognized by Foundry
        vm.startBroadcast(); // "vm." is from "forge-std/Script.sol" and works only in script files, not in contract files
        // Everything after "vm.startBroadcast()" and before "vm.stopBroadcast()" is
        // considered as the deployment transaction and will be sent to the network
        SimpleStorage simpleStorage = new SimpleStorage(); // "SimpleStorage" is the contract imported above
                                                           // "simpleStorage" is the variable of the deployed contract 
                                                           // "new" creates a new contract instance
        vm.stopBroadcast(); // stop broadcasting the transaction
        return simpleStorage; // return the deployed contract instance
    }
}
