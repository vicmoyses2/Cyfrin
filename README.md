# 🧠 Cyfrin Smart Contract Development

> A collection of Solidity projects, scripts, and notes developed during the **[Cyfrin Updraft](https://updraft.cyfrin.io/)** courses on blockchain and smart contract engineering.

---

## 📚 Overview

This repository serves as a learning archive for my progress through Cyfrin’s Web3 and smart contract development curriculum.
It contains **Solidity smart contracts**, **Foundry configurations**, and **hands-on practice files** for topics ranging from basic storage contracts to Chainlink price feeds and decentralized funding logic.

---

## 🧩 Project Structure

```
Cyfrin/
│
├── FoundryFundamentals/
│   ├── src/
│   │   ├── FundMe.sol
│   │   ├── PriceConverter.sol
│   │   └── SimpleStorage.sol
│   ├── script/
│   ├── lib/
│   ├── foundry.toml
│   └── ...
│
├── SoliditySmartContractDevelopment/
│   ├── AddFiveStorage.sol
│   ├── FallbackExample.sol
│   ├── Fundme.sol
│   ├── PriceConverter.sol
│   ├── SimpleStorage.sol
│   └── StorageFactory.sol
│
├── out/
├── cache/
├── .vscode/
└── keystore.md
```

---

## ⚙️ Tech Stack

- **Language:** Solidity `^0.8.24`
- **Framework:** [Foundry](https://book.getfoundry.sh/)
- **Dependencies:**
  - [Chainlink Contracts](https://github.com/smartcontractkit/chainlink)
  - [OpenZeppelin Libraries](https://www.openzeppelin.com/contracts) *(if applicable)*
- **Tools:**
  - Anvil (local blockchain)
  - Forge (testing & compilation)
  - Cast (interaction)
  - VSCode (development environment)

---

## 💡 Example Contracts

### `FundMe.sol`
A decentralized crowdfunding smart contract that:
- Accepts ETH contributions only above a USD threshold (via Chainlink Price Feed).
- Stores funders’ addresses and amounts.
- Allows only the owner to withdraw funds.

#### 🌐 Deployment Information

The `FundMe.sol` contract has been **successfully deployed and verified** on the **ZKSync Era Sepolia Testnet**.

🔗 **Explorer Link:** [View on ZKSync Sepolia Explorer](https://sepolia.explorer.zksync.io/address/0x547852bacab949868D77a1b4F0f0f1Cfcf447399)

- **Network:** ZKSync Era Sepolia Testnet
- **Contract Address:** `0x547852bacab949868D77a1b4F0f0f1Cfcf447399`
- **Verification:** Verified on-chain via ZKSync block explorer

---

### `SimpleStorage.sol`
A foundational contract demonstrating:
- Variables, mappings, arrays, and structs.
- Basic CRUD (Create, Read, Update) logic on-chain.
- Gas-efficient state updates and retrieval functions.

---

## 🧠 Learning Topics Covered

- Solidity basics (state variables, mappings, arrays)
- Structs and storage patterns
- Chainlink Oracle integration
- Access control (`onlyOwner`)
- Error handling (`require`, `revert`, custom errors`)
- Fallback and receive functions
- Gas optimization and `immutable`/`constant` usage
- Deployment and testing with Foundry

---

## 🏅 Achievements

Here are my verified Cyfrin Updraft course completions:

<p align="center">
  <a href="https://profiles.cyfrin.io/u/vicmoyses/achievements/blockchain-basics" target="_blank">
    <img src="https://res.cloudinary.com/droqoz7lg/image/upload/f_auto/q_auto/v1748556702/assets/blockchain-basics-badge.png" alt="Blockchain Basics Badge" width="300" style="margin-right:20px;"/>
  </a>
  <a href="https://profiles.cyfrin.io/u/vicmoyses/achievements/solidity" target="_blank">
    <img src="https://res.cloudinary.com/droqoz7lg/image/upload/f_auto/q_auto/v1748556702/assets/solidity-101.png" alt="Solidity Smart Contract Development Badge" width="300"/>
  </a>
</p>

| Course                                  | Achievement Link                                                                          |
| :-------------------------------------- | :---------------------------------------------------------------------------------------- |
| **Blockchain Basics**                   | [View Achievement](https://profiles.cyfrin.io/u/vicmoyses/achievements/blockchain-basics) |
| **Solidity Smart Contract Development** | [View Achievement](https://profiles.cyfrin.io/u/vicmoyses/achievements/solidity)          |

*(Badges issued by [Cyfrin Updraft](https://updraft.cyfrin.io/))*

---

## 🧭 Course Reference

This repository follows the hands-on modules from:

🎓 **[Cyfrin Updraft Courses](https://updraft.cyfrin.io/courses)**
A platform created by [Patrick Collins](https://github.com/PatrickAlphaC) offering in-depth blockchain engineering education for developers transitioning into Web3.

---

## 🧑‍💻 Author

**Victor Moyses Nascimento**
🎓 Electrical Engineer | 🧱 Blockchain & Web3 Developer | ⚙️ Smart Contract Enthusiast
📍 [GitHub](https://github.com/vicmoyses2)

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

### ⭐ If you found this repository helpful, consider giving it a star!
