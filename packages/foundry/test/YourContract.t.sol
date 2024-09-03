// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contracts/YourContract.sol";

contract YourContractTest is Test {
    YourContract public yourContract;
    address public owner = address(0x123);
    address public addr1 = address(0x456);
    address public addr2 = address(0x789);

    function setUp() public {
        yourContract = new YourContract(owner);
    }

    function testInitialSetup() public {
        assertEq(yourContract.owner(), owner);
        assertEq(yourContract.totalSupply(), 0);
    }

    function testMintToken() public {
        // Initial state
        assertEq(yourContract.totalSupply(), 0);
        assertEq(yourContract.balanceOf(addr1), 0);
        assert(!yourContract.hasToken(addr1));

        // Mint a token to addr1
        yourContract.mint(addr1);

        // Check that the total supply increased
        assertEq(yourContract.totalSupply(), 1);
        assertEq(yourContract.balanceOf(addr1), 1);
        assert(yourContract.hasToken(addr1));

        // Attempt to mint another token to addr1 should fail
        vm.expectRevert("Sorry, you can only get 1 token");
        yourContract.mint(addr1);

        // Mint another token to addr2
        yourContract.mint(addr2);

        // Check that the total supply increased
        assertEq(yourContract.totalSupply(), 2);
        assertEq(yourContract.balanceOf(addr2), 1);
        assert(yourContract.hasToken(addr2));

        // Attempt to mint a new token after reaching max supply should fail
        for (uint256 i = 0; i < 98; i++) {
            address newAddr = address(uint160(i + 1));
            yourContract.mint(newAddr);
        }
        
        vm.expectRevert("Max supply reached");
        yourContract.mint(address(0xABC));
    }

    function testMaxSupply() public {
        // Mint tokens up to max supply
        for (uint256 i = 0; i < 100; i++) {
            address newAddr = address(uint160(i + 1));
            yourContract.mint(newAddr);
        }
        assertEq(yourContract.totalSupply(), 100);

        // Attempt to mint after reaching max supply should fail
        vm.expectRevert("Max supply reached");
        yourContract.mint(address(0xDEF));
    }

    function testCannotMintTwice() public {
        // Mint to addr1
        yourContract.mint(addr1);

        // Attempt to mint again to addr1 should fail
        vm.expectRevert("Sorry, you can only get 1 token");
        yourContract.mint(addr1);
    }
}

// pragma solidity ^0.8.13;

// import "forge-std/Test.sol";
// import "../contracts/YourContract.sol";

// contract YourContractTest is Test {
//   YourContract public yourContract;

//   // function setUp() public {
//   //   yourContract = new YourContract(vm.addr(1));
//   // }

//   // function testMessageOnDeployment() public view {
//   //   require(
//   //     keccak256(bytes(yourContract.greeting()))
//   //       == keccak256("Building Unstoppable Apps!!!")
//   //   );
//   // }

//   // function testSetNewMessage() public {
//   //   yourContract.setGreeting("Learn Scaffold-ETH 2! :)");
//   //   require(
//   //     keccak256(bytes(yourContract.greeting()))
//   //       == keccak256("Learn Scaffold-ETH 2! :)")
//   //   );
//   // }
// }
