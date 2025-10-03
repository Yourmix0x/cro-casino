// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentralizedCasino {
    mapping(address => uint256) public gameWieValues;
    mapping(address => uint256) public blockNumbersToBeUsed;

    address[] public lastThreeWinners;

    function playGame() public payable {
        uint256 blockNumberToBeUsed = blockNumbersToBeUsed[msg.sender];

        if (blockNumberToBeUsed == 0) {
            blockNumbersToBeUsed[msg.sender] = block.number + 128;
            gameWieValues[msg.sender] = msg.value;
            return;
        }

        require(block.number >= blockNumbersToBeUsed[msg.sender], "Too early");

        uint256 randomNumber = block.prevrandao;

        if (randomNumber % 2 == 0) {
            uint256 winningAmount = gameWieValues[msg.sender] * 2;
            (bool success, ) = msg.sender.call{value: winningAmount}("");
            require(success, "Transfer failed");

            lastThreeWinners.push(msg.sender);

            if(lastThreeWinners.length > 3) {
                for (uint256 i = 0; i < lastThreeWinners.length - 1; i++) {
                    lastThreeWinners[i] = lastThreeWinners[i + 1];
                }
                lastThreeWinners.pop();
            }
        }

        blockNumbersToBeUsed[msg.sender] = 0;
        gameWieValues[msg.sender] = 0;
    }

    receive() external payable {
        playGame();
    }
}
;