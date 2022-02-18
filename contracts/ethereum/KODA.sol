// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";



contract KODA is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 treePrice = 100000000000000000;
    enum LifeCycle {
        Seedling=0;
        Sprout=1;
        Sapling=2;
        Mature=3;
        Death=4; 

    }
    struct Tree {
        string species;
        string whenPlanted;
        string location;
        string environment;
        uint age;
        uint height;
        LifeCycle stageOfLife;
    }


    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("KODA", "TREE") {

    }

    function mintTree(address to, string memory uri,uint numOfTrees) public payable onlyOwner {
        require((treePrice*numOfTrees) == msg.value);
        for (uint i =0;i<numOfTrees;i++) {
            uint256 tokenId = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, uri);
        }
       
        
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //tree functions
    function addFertilizer() public payable onlyOwner {

    }

}
