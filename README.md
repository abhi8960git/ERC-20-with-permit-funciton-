# 🚀 Oscires Token (OSC)

## 📝 Overview
**Oscires** is an advanced ERC-20 token that leverages OpenZeppelin's secure and battle-tested contracts to deliver a feature-rich token with:

- 🔥 **Burnable** tokens - Users can burn their tokens to reduce the total supply.
- ✍️ **Permit (EIP-2612)** - Gasless approvals using off-chain signatures.
- 🗳️ **Governance Voting** - Enables delegation and on-chain governance.
- ⛽ **Efficient** - Built on OpenZeppelin's latest contracts, ensuring up-to-date security and efficiency.

---

## 🛠️ Key Features

### 1. ERC-20 Standard 🏛️
- Implements the ERC-20 standard with all standard functions like `transfer()`, `approve()`, and `allowance()`.

### 2. Burnable 🔥
- Users can burn tokens by calling the `burn()` function.
```solidity
oscires.burn(amount);
```

### 3. Permit (Gasless Approval) ✍️
- Allows users to approve token transfers **without spending gas** by signing an off-chain message.
```solidity
oscires.permit(owner, spender, value, deadline, v, r, s);
```

### 4. Voting 🗳️
- Supports governance by allowing users to delegate their voting power.
```solidity
oscires.delegate(voterAddress);
```

### 5. Compatibility 🧩
- Fully compatible with OpenZeppelin’s `ERC20Votes` and `ERC20Permit` extensions, ensuring robust governance and seamless DeFi integration.

---

## 🔧 How It Works

1. **Deployment**
```solidity
Oscires oscires = new Oscires();
```
- On deployment, **1 billion OSC tokens** are minted and transferred to the deployer.

2. **Transfer Tokens**
```solidity
oscires.transfer(receiver, 1000 ether);
```

3. **Burn Tokens**
```solidity
oscires.burn(500 ether);
```

4. **Delegate Votes**
```solidity
oscires.delegate(msg.sender);
```

---

## 🧪 Testing
- The contract includes extensive test coverage:
  - ✅ Initial supply verification.
  - ✅ Transfers and burns.
  - ✅ Permit and gasless approval.
  - ✅ Vote delegation and weight transfer.

To run tests:
```bash
forge test
```

---

## 📂 Project Structure
```
/                       # Root folder
│
├── src/                # Smart contracts
│   └── OsciresToken.sol     # Oscires Token contract
│
├── test/               # Foundry tests
│   └── OsciresToken.t.sol   # Tests for Oscires
│
└── foundry.toml        # Foundry configuration
```

---

## 🛡️ Security
- Built using OpenZeppelin’s **audited libraries**.
- Inherits from:
  - `ERC20` for standard token logic.
  - `ERC20Burnable` for burning.
  - `ERC20Permit` for gasless approvals.
  - `ERC20Votes` for governance.

---

## 📜 License
**MIT License** - Free to use, modify, and distribute.

---

## 📧 Contact
For any inquiries, feel free to reach out!


