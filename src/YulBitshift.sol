//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;


contract YulBitShift  {

    uint128 public C = 4;
    uint96 public D = 6;
    uint16 public E = 8;
    uint8 public F = 1;

    function readyBySlot(uint256 slot) external view returns(bytes32 value) {
        assembly {
            value:= sload(slot)
        }
    }
   
    // NOT FOR USE IN PRODUCTION
    function writeBySlot(uint256 slot, uint256 value) external {
        
    }


}

