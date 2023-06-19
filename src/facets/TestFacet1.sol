// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract TestFacet1 {
    struct Slot0 {
        uint256 a;
        uint256 b;
        uint256 c;
    }

    Slot0 public slot0;

    function setA(uint256 a) external {
        slot0.a = a;
    }

     function setB(uint256 b) external {
        slot0.b = b;
    }

     function setC(uint256 c) external {
        slot0.c = c;
    }
}
