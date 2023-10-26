//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

// getting variable E in slot 0 as it is packed with others

contract YulBitShift  {

    uint128 public C = 4;
    uint96 public D = 6;
    uint16 public E = 8;
    uint8 public F = 1;

    // e.g. 0
    function readyBySlot(uint256 slot) external view returns(bytes32 value) {
        assembly {
            value:= sload(slot)
        }
    }
   
    // NOT FOR USE IN PRODUCTION
    function writeBySlot(uint256 slot, uint256 value) external {

    }

    function getOffsetE() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := E.slot
            offset := E.offset
        }
    }

    function readE() external view returns(uint e) {
        assembly {
            let value := sload(E.slot) // loads 32 byte increaments
            // 0x0000000000000000000000000000000000000000000000000000000000010008
            // E.offset = 28
            let shifted := shr(mul(E.offset, 8), value)

            // eq to:
            // 0x00000000000000000000000000000000000000000000000000000000ffffffff
            e:= and(0xffffffff, shifted)

        }
    }

    function readEAlt() external view returns(uint256 e) {
        
        assembly{
            let slot := sload(E.slot)
            let offset := sload(E.offset)
            let value := sload(E.slot)

            let shifted := div(value, 0x1000000000000000000000000000000000000000000000000000000000)
            e := and(0xffffffff, shifted)
        }

    }


}

