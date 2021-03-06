pragma solidity >=0.4.17 <0.8.13;

// linter warnings (red underline) about pragma version can igonored!

// contract code will go here

contract Lottery {
    address public manager;
    address[] public players;
    address public lastWinner;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted{
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        lastWinner = players[index];
        players = new address[](0);
    }
    
    function winner() public view returns (address) {
        return lastWinner;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns ( address[]) {
        return players;
    }
} 