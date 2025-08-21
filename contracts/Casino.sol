// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Casino {
    function playGame() external payable {
        uint256 randomNumber = block.prevrandao;

        if (randomNumber % 2 == 0) {
            uint256 winningAmount = msg.value * 2;
            (bool success, ) = msg.sender.call{value: winningAmount}("");
            require(success, "Transfer failed");
        }
    }
}
