// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IDiamondCut} from "diamond/interfaces/IDiamondCut.sol";
import {Diamond} from "diamond/Diamond.sol";
import {DiamondCutFacet} from "diamond/facets/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "diamond/facets/DiamondLoupeFacet.sol";

contract DiamondTest {
    IDiamondCut.FacetCut[] internal cut;

    function createDiamond() internal returns (Diamond) {
        DiamondCutFacet diamondCut = new DiamondCutFacet();
        DiamondLoupeFacet diamondLoupe = new DiamondLoupeFacet();
        Diamond diamond = new Diamond(
            address(this),
            address(diamondCut)
        );

        bytes4[] memory functionSelectors;

        // Diamond Loupe
        functionSelectors = new bytes4[](5);
        functionSelectors[0] = DiamondLoupeFacet
            .facetFunctionSelectors
            .selector;
        functionSelectors[1] = DiamondLoupeFacet.facets.selector;
        functionSelectors[2] = DiamondLoupeFacet.facetAddress.selector;
        functionSelectors[3] = DiamondLoupeFacet.facetAddresses.selector;
        functionSelectors[4] = DiamondLoupeFacet.supportsInterface.selector;
        cut.push(
            IDiamondCut.FacetCut({
                facetAddress: address(diamondLoupe),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: functionSelectors
            })
        );

        DiamondCutFacet(address(diamond)).diamondCut(cut, address(0), "");
        delete cut;

        return diamond;
    }

    function addFacet(Diamond _diamond, address _facet, bytes4[] memory _selectors) internal {
        cut.push(
            IDiamondCut.FacetCut({
                facetAddress: _facet,
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: _selectors
            })
        );

        DiamondCutFacet(address(_diamond)).diamondCut(cut, address(0), "");

        delete cut;
    }
}
