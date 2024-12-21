// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import  "../src/OsciresToken.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract OsciresTest is Test {
    Oscires oscires;
    address alice = address(0x1);
    address bob = address(0x2);
    address carol = address(0x3);
    
    uint256 initialSupply = 1_000_000_000 * 10 ** 18;

    function setUp() public {
        oscires = new Oscires();
    }

    function testInitialSupply() public {
        assertEq(oscires.totalSupply(), initialSupply);
        assertEq(oscires.balanceOf(address(this)), initialSupply);
    }

    function testTransfer() public {
        oscires.transfer(alice, 1000 ether);
        assertEq(oscires.balanceOf(alice), 1000 ether);
        assertEq(oscires.balanceOf(address(this)), initialSupply - 1000 ether);
    }

    function testFailTransferInsufficientBalance() public {
        vm.prank(alice);
        oscires.transfer(bob, 1000 ether);
    }

    function testBurn() public {
        oscires.burn(500 ether);
        assertEq(oscires.totalSupply(), initialSupply - 500 ether);
    }

    function testFailBurnInsufficientBalance() public {
        vm.prank(alice);
        oscires.burn(1000 ether);
    }

    function testPermit() public {
        uint256 privateKey = 1234;
        address signer = vm.addr(privateKey);
        oscires.transfer(signer, 1000 ether);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            privateKey,
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    keccak256(
                        abi.encode(
                            oscires.nonces(signer),
                            signer,
                            bob,
                            500 ether,
                            block.timestamp + 1 days
                        )
                    )
                )
            )
        );
        oscires.permit(signer, bob, 500 ether, block.timestamp + 1 days, v, r, s);
        vm.prank(bob);
        oscires.transferFrom(signer, bob, 500 ether);
        assertEq(oscires.balanceOf(bob), 500 ether);
    }

    function testFailExpiredPermit() public {
        uint256 privateKey = 1234;
        address signer = vm.addr(privateKey);
        oscires.transfer(signer, 1000 ether);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            privateKey,
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    keccak256(
                        abi.encode(
                            oscires.nonces(signer),
                            signer,
                            bob,
                            500 ether,
                            block.timestamp - 1 days
                        )
                    )
                )
            )
        );
        oscires.permit(signer, bob, 500 ether, block.timestamp - 1 days, v, r, s);
    }

    function testDelegateVotes() public {
        oscires.transfer(alice, 1000 ether);
        vm.prank(alice);
        oscires.delegate(alice);
        assertEq(oscires.getVotes(alice), 1000 ether);
    }

    function testTransferVoteWeight() public {
        oscires.transfer(alice, 1000 ether);
        vm.prank(alice);
        oscires.delegate(alice);
        assertEq(oscires.getVotes(alice), 1000 ether);

        vm.prank(alice);
        oscires.transfer(bob, 500 ether);
        assertEq(oscires.getVotes(alice), 500 ether);
    }
}
