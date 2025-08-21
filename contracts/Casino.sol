// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentralizedCasino {
    mapping(address => uint256) public gameWieValues;
    mapping(address => uint256) public blockNumbersToBeUsed;

    address public bank;

    bytes32 public userCommitment;
    bytes32 public bankCommitment;

    uint256 public userNumber;
    uint256 public bankNumber;

    function fundBank() external payable {}

    function setUserCommitment(bytes32 commitment) external payable {
        require(userCommitment == 0x0);
        userCommitment = commitment;
    }

    function revealUserNumber(uint256 number) external {
        require(keccak256(abi.encodePacked(number)) == userCommitment);
        userNumber = number;
    }

    function setBankCommitment(bytes32 commitment) external {
        require(bankCommitment == 0x0);
        bankCommitment = commitment;
    }

    function revealBankNumber(uint256 number) external {
        require(keccak256(abi.encodePacked(number)) == bankCommitment);
        bankNumber = number;
    }

    function playGame() external payable {
        uint256 blockNumberToBeUsed = blockNumbersToBeUsed[msg.sender];

        if (blockNumberToBeUsed == 0) {
            blockNumbersToBeUsed[msg.sender] = block.number + 2;
            gameWieValues[msg.sender] = msg.value;
            return;
        }

        require(block.number >= blockNumbersToBeUsed[msg.sender], "Too early");

        uint256 randomNumber = bankNumber | userNumber; // XOR

        if (randomNumber % 2 == 0) {
            uint256 winningAmount = gameWieValues[msg.sender] * 2;
            (bool success, ) = msg.sender.call{value: winningAmount}("");
            require(success, "Transfer failed");
        }

        blockNumbersToBeUsed[msg.sender] = 0;
        gameWieValues[msg.sender] = 0;
    }
}
