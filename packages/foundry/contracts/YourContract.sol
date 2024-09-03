//SPDX-License-Identifier: MIT

// Specs:
// [x] ERC20 Token
// [x] No need for access control, all methods is accessible by anyone.
// [x] Public mint, anyone can mint for free, have a capped at 100 tokens
// [x] One address can only have 1 token. If the address already has a token, minting will fail.

pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YourContract is ERC20 {
    address public immutable owner;
    uint256 public constant MAX_SUPPLY = 100;
    mapping(address => bool) public hasToken;

    constructor(address _owner) ERC20("Rabbitrepo", "RBRP") {
        owner = _owner;
    }

     // Minting is open to anyone and for free, with restrictions
    function mint(address to) public {
        require(totalSupply() < MAX_SUPPLY, "Max supply reached");
        require(!hasToken[to], "Sorry, you can only get 1 token");
        _mint(to, 1); // Each minting only allows 1 token
        hasToken[to] = true; // Mark address as having a token
    }
}

// pragma solidity >=0.8.0 <0.9.0;

// // Useful for debugging. Remove when deploying to a live network.
// import "forge-std/console.sol";

// // Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
// // import "@openzeppelin/contracts/access/Ownable.sol";

// /**
//  * A smart contract that allows changing a state variable of the contract and tracking the changes
//  * It also allows the owner to withdraw the Ether in the contract
//  * @author BuidlGuidl
//  */
// contract YourContract {
//   // State Variables
//   address public immutable owner;
//   string public greeting = "Building Unstoppable Apps!!!";
//   bool public premium = false;
//   uint256 public totalCounter = 0;
//   mapping(address => uint256) public userGreetingCounter;

//   // Events: a way to emit log statements from smart contract that can be listened to by external parties
//   event GreetingChange(
//     address indexed greetingSetter,
//     string newGreeting,
//     bool premium,
//     uint256 value
//   );

//   // Constructor: Called once on contract deployment
//   // Check packages/foundry/deploy/Deploy.s.sol
//   constructor(address _owner) {
//     owner = _owner;
//   }

//   // Modifier: used to define a set of rules that must be met before or after a function is executed
//   // Check the withdraw() function
//   modifier isOwner() {
//     // msg.sender: predefined variable that represents address of the account that called the current function
//     require(msg.sender == owner, "Not the Owner");
//     _;
//   }

//   /**
//    * Function that allows anyone to change the state variable "greeting" of the contract and increase the counters
//    *
//    * @param _newGreeting (string memory) - new greeting to save on the contract
//    */
//   function setGreeting(string memory _newGreeting) public payable {
//     // Print data to the anvil chain console. Remove when deploying to a live network.

//     console.logString("Setting new greeting");
//     console.logString(_newGreeting);

//     greeting = _newGreeting;
//     totalCounter += 1;
//     userGreetingCounter[msg.sender] += 1;

//     // msg.value: built-in global variable that represents the amount of ether sent with the transaction
//     if (msg.value > 0) {
//       premium = true;
//     } else {
//       premium = false;
//     }

//     // emit: keyword used to trigger an event
//     emit GreetingChange(msg.sender, _newGreeting, msg.value > 0, msg.value);
//   }

//   /**
//    * Function that allows the owner to withdraw all the Ether in the contract
//    * The function can only be called by the owner of the contract as defined by the isOwner modifier
//    */
//   function withdraw() public isOwner {
//     (bool success,) = owner.call{ value: address(this).balance }("");
//     require(success, "Failed to send Ether");
//   }

//   /**
//    * Function that allows the contract to receive ETH
//    */
//   receive() external payable { }
// }
