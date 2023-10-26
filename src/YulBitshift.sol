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
        assembly {
            sstore(slot, value)
        }
    }

    // masks can be hardcoded bc variable storage slot and 
    // offsets are fixed
    // V and 00 = 00
    // V and FF = V
    // V or 00 = V

    function writeToE(uint256 newE) external {
        assembly{
            // newE = 0x000000000000000000000000000000000000000000000000000000000000000a
            let c:= sload(E.slot) // slot 0
            // c = 0x000000
            let clearedE := and(c, 0xfff)
            // mask = 0xffff0000fffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // c = 0x0001000800000000000000000000000600000000000000000000000000000004
            // clearedE = 0x0001000800000000000000000000000600000000000000000000000000000004
            // 8 bits in a byte, 28 * 8 gives correct conversion
            let shiftedNewE := shl(mul(E.offset, 8), newE)
            // shiftedNewE = 0x0000000a00000000000000000000000000000000000000000000000000000000
            // clearedE = 0x0001000800000000000000000000000600000000000000000000000000000004
            // newVal = 0x0001000a00000000000000000000000600000000000000000000000000000004
            let newVal := or(shiftedNewE, clearedE)

            sstore(C.slot, newVal)
        }
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
            // E.offset = 28
            let shifted := shr(mul(E.offset, 8), value)
            // 0x0000000000000000000000000000000000000000000000000000000000010008
            // eq to:
            // 0x000000000000000000000000000000000000000000000000000000000000ffff
            e:= and(0xffffffff, shifted)

        }
    }

    function readEAlt() external view returns(uint256 e) {
        
        assembly{
            let slot := sload(E.slot)
            let offset := sload(E.offset)
            let value := sload(E.slot)

            // shift rt by 224 = divide by (2 ** 224). 
            // below is 2 ** 224 in hex
            let shifted := div(value, 0x1000000000000000000000000000000000000000000000000000000000)
            e := and(0xffffffff, shifted)
        }

    }


}

