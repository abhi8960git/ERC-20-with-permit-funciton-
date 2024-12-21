// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Oscires} from "../src/OsciresToken.sol";

contract CounterScript is Script {
    Oscires public OsciresToken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        OsciresToken = new Oscires();

        vm.stopBroadcast();
    }
}
