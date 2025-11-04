## Commands to use in the terminal:
### Some personal guidance written among the course

```
curl -L https://foundry.paradigm.xyz | bash // Install foundry directly

curl -L https://raw.githubusercontent.com/matter-labs/foundry-zksync/main/install-foundry-zksync | bash // Install foundry-zksync directly

foundryup // Initiate foundry (NOT Zksync)

foundryup-zksync // Initiate foundry to Zksync Testnet

```
anvil // Initiate a local blockchain to deploy and test the contracts
      // When initiate the local blockchain, you must open a neu terminal to use/deploy
      // Always check if the pathname for the folder is correct, it often gets back to the root folder
anvil-zksync / Initiate for Zksync local blockchain
```
```
forge build <CONTRACT_NAME> // Compile the contract
```
```
forge create <CONTRACT_NAME> --broadcast --interactive // Deploy a contract in the local blockchain
--broadcast // Broadcast the transaction, if dosn't explicit it, will only simulate the broadcasting
--interactive // Open an interactive prompt to enter your private key
```
```
forge test --fork-url $SEPOLIA_RPC_URL // Test a contract using the Sepolia Testnet RPC_URL to simulate going to a real blockchain

forge test --macht-test testPriceFeedVersionIsAccurate -vvv // Test a specific function, can use "--mt" instead of "--match-test"
forge test --mt <FUNCTION_NAME> -vvv
```
```
forge coverage --fork-url $SEPOLIA_RPC_URL // Can see how much of the code was tested
/* Return example:
╭----------------------------------+---------------+---------------+---------------+---------------╮
| File                             | % Lines       | % Statements  | % Branches    | % Funcs       |
+==================================================================================================+
| script/DeployFundMe.s.sol        | 0.00% (0/4)   | 0.00% (0/3)   | 100.00% (0/0) | 0.00% (0/1)   |
|----------------------------------+---------------+---------------+---------------+---------------|
| script/DeploySimpleStorage.s.sol | 0.00% (0/5)   | 0.00% (0/5)   | 100.00% (0/0) | 0.00% (0/1)   |
|----------------------------------+---------------+---------------+---------------+---------------|
| src/FundMe.sol                   | 20.83% (5/24) | 23.81% (5/21) | 0.00% (0/5)   | 28.57% (2/7)  |
|----------------------------------+---------------+---------------+---------------+---------------|
| src/PriceConverter.sol           | 0.00% (0/8)   | 0.00% (0/10)  | 100.00% (0/0) | 0.00% (0/2)   |
|----------------------------------+---------------+---------------+---------------+---------------|
| src/SimpleStorage.sol            | 0.00% (0/7)   | 0.00% (0/4)   | 100.00% (0/0) | 0.00% (0/3)   |
|----------------------------------+---------------+---------------+---------------+---------------|
| Total                            | 10.42% (5/48) | 11.63% (5/43) | 0.00% (0/5)   | 14.29% (2/14) |
╰----------------------------------+---------------+---------------+---------------+---------------╯
*/
```
```
forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
forge script script/<SCRIPT_NAME> --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast
forge script // Run a smart contract as a script
--rpc-url // Address RPC_URL from the blockchain that you are deploying
--private-key // PRIVATE_KEY from the account that is deploying the contract (ONLY USE THIS FOR FAKE ACCOUNTS,)
              // WATCH LESSON "21. NEVER USE A .ENV FILE" FROM THE CYFRIN COURSE LINK: https://updraft.cyfrin.io/courses/foundry/foundry-simple-storage/never-use-a-env-file
// If there is a private key added in the wallet list (check: "cast wallet list" in the terminal):
forge script script/DeploySimpleStorage.s.sol --rpc-url $SEPOLIA_RPC_URL --account sepoliaKey --sender 0x6bab4333a8cabe29dbf9542aa99d92e639c28436 --broadcast
forge script script/<SCRIPT_NAME> --rpc-url <RPC_URL> --account <KEY_NAME> --sender <KEY_ADDRESS> --broadcast
<KEY_NAME> // The private key name from keystore
<KEY_ADDRESS> // The public address related to the private key
```
```
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "store(uint256)" 123 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
cast send <CONTRACT_ADDRESS> "<FUNCTION_NAME>(<INPUT_FORMAT>)" <INPUT_VALUE> --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
cast send // Sign and publish a transaction, the command contains: cast send [OPTIONS] [TO] [SIG] [ARGS]... [COMMAND]
[OPTIONS] // Are the commands "--rpc-url" and the --private-key, Check for more https://getfoundry.sh/cast/reference/send#cast-send
[TO] // Is the contract address
[SIG] // The signature of the function to call, the function name and the input value
[ARGS] // The argument of the funcion, the input value
```
```
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "retrieve()"
cast call <CONTRACT_ADDRESS> "<FUNCTION_NAME>()"
cast call // Perform a call on an account without publishing a transaction
"<FUNCTION_NAME>()" // The function that is calling dosn't have a argument, thats why the parentesis is empty
                    // If the call function returns a value, will be a HEX value
cast --to-base 0x000000000000000000000000000000000000000000000000000000000000007b dec
cast [OPTIONS] <HEX_NUMBER> <NEW_BASE_NUMBER>
```
```
cast wallet import sepoliaKey --interactive
cast wallet import <KEY_NAME> --interactive // using --interactive is the way that you can insert the
                                            // private key without revealing it on text
sepoliaKey // PRIVATE_KEY stored using keystore encryption
0x6bab4333a8cabe29dbf9542aa99d92e639c28436 // Keystore address from sepoliaKey
cast wallet list // View the keystore list
```
