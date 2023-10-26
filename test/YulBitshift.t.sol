// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {YulBitShift} from "../src/YulBitshift.sol";

contract SolutionTest is Test {
    
    YulBitShift public yulBitShift;

  
    function setUp() public {
        yulBitShift = new YulBitShift();
    }

    function test_Something() public {   

    }
    
}


