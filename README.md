# CRO Casino           

A decentralized casino smart contract built on Solidity that offers simple 50/50 betting games. Players stake ETH and have a chance to double their money based on blockchain randomness.

## How It Works

1. **Place Bet**: Send ETH to the contract to place your bet
2. **Wait**: The contract schedules your bet resolution 128 blocks in the future
3. **Resolve**: Call the contract again after the waiting period to resolve your bet
4. **Win/Lose**: 50% chance to win double your stake based on `block.prevrandao`

## Game Mechanics

- **Bet Placement**: Send any amount of ETH to place a bet
- **Waiting Period**: 128 blocks (~25-30 minutes on most networks)
- **Win Condition**: Even `block.prevrandao` = Win, Odd = Lose
- **Payout**: Winners receive 2x their original stake
- **History**: Contract tracks the last 3 winners

## Contract Features

- **Automatic Betting**: Send ETH directly to the contract via the `receive()` function
- **Manual Betting**: Call `playGame()` directly with ETH
- **Winner Tracking**: View recent winners with `lastThreeWinners`
- **Transparent**: All game logic is on-chain and verifiable

## Quick Start

### Prerequisites

- Node.js 18+
- Hardhat
- MetaMask or compatible wallet

### Installation

```bash
npm install
```

### Testing

```bash
npx hardhat test
```

### Deployment

Deploy to local network:

```bash
npx hardhat ignition deploy ignition/modules/Casino.ts
```

Deploy to testnet (e.g., Sepolia):

```bash
npx hardhat ignition deploy --network sepolia ignition/modules/Casino.ts
```

## Contract Interface

### Main Functions

- `playGame()` - Place a bet or resolve an existing bet
- `gameWieValues(address)` - View player's current stake
- `blockNumbersToBeUsed(address)` - View when a bet can be resolved
- `lastThreeWinners()` - View recent winners

### Events

The contract automatically handles bet placement and resolution through the same function.

## Important Notes

**This is an educational/experimental contract. Please be aware:**

- Uses `block.prevrandao` for randomness (not cryptographically secure)
- No access controls or admin functions
- Contract must have sufficient ETH balance to pay winners
- Always test on testnets before mainnet deployment

## Built With

- **Solidity ^0.8.19**
- **Hardhat 3 Beta**
- **TypeScript**
- **Viem** for Ethereum interactions
- **Node.js** native test runner

## License

MIT License - see LICENSE file for details

## Contributing

Contributions welcome! Please feel free to submit issues and pull requests.

## Links

- [Hardhat Documentation](https://hardhat.org/docs)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Viem Documentation](https://viem.sh/)
