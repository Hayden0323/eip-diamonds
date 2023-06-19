// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {TestBase} from "../utils/TestBase.sol";
import {TestFacet1} from "diamond/facets/TestFacet1.sol";
import {Diamond} from "diamond/Diamond.sol";
import {console} from "forge-std/Console.sol";

contract TestFacet1Test is TestBase {
    TestFacet1 internal testFacet1;
    Diamond internal diamond;

    function setUp() public {
        diamond = createDiamond();
        testFacet1 = new TestFacet1();

        bytes4[] memory functionSelectors = new bytes4[](4);
        
        functionSelectors[0] = testFacet1.setA.selector;
        functionSelectors[1] = testFacet1.setB.selector;
        functionSelectors[2] = testFacet1.setC.selector;
        functionSelectors[3] = testFacet1.slot0.selector;

        addFacet(diamond, address(testFacet1), functionSelectors);
    }

    function test_SetA(uint256 _fa, uint256 _sa) public {
        (uint256 oldA, , ) = testFacet1.slot0();
        assertEq(oldA, 0);
        testFacet1.setA(_fa);
        (uint256 newA, , ) = testFacet1.slot0();
        assertEq(newA, _fa);
        TestFacet1 diamondTest = TestFacet1(address(diamond));
        diamondTest.setA(_sa);
        (uint256 newA2, , ) = diamondTest.slot0();
        assertEq(newA2, _sa);
    }
}
