// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentralizedCasino {
    mapping(address => uint256) public gameWieValues;
    mapping(address => uint256) public blockNumbersToBeUsed;

    address public bank;

    function fundBank() external payable {}

    function playGame() external payable {
        uint256 blockNumberToBeUsed = blockNumbersToBeUsed[msg.sender];

        if (blockNumberToBeUsed == 0) {
            blockNumbersToBeUsed[msg.sender] = block.number + 2;
            gameWieValues[msg.sender] = msg.value;
            return;
        }

        require(block.number >= blockNumbersToBeUsed[msg.sender], "Too early");

        uint256 randomNumber = block.prevrandao;

        if (randomNumber % 2 == 0) {
            uint256 winningAmount = gameWieValues[msg.sender] * 2;
            (bool success, ) = msg.sender.call{value: winningAmount}("");
            require(success, "Transfer failed");
        }

        blockNumbersToBeUsed[msg.sender] = 0;
        gameWieValues[msg.sender] = 0;
    }
}
