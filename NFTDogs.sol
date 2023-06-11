// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./VRFv2Consumer.sol";

contract NFTDogs is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    string constant METADATA_SHIBAINU = "ipfs://QmXw7TEAJWKjKifvLE25Z9yjvowWk2NWY3WgnZPUto9XoA";
    string constant METADATA_HUSKY = "ipfs://QmTFXZBmmnSANGRGhRVoahTTVPJyGaWum8D3YicJQmG97m";
    string constant METADATA_BULLDOG = "ipfs://QmSM5h4WseQWATNhFWeCbqCTAGJCZc11Sa1P5gaXk38ybT";
    VRFv2Consumer vrf;
    mapping(uint256 => uint256) requestIdToTokenId;
    
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("NFTDogs", "NDS") {}

    function setVrf(address vrfAddr) external {
        vrf = VRFv2Consumer(vrfAddr);
    }

    function safeMint() public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        uint256 requestId = vrf.requestRandomWords();
        requestIdToTokenId[requestId] = tokenId;
    }

    function mintRandomNft(uint256 requestId, uint256 randomNumber) external {
        uint256 tokenId = requestIdToTokenId[requestId];
        if(randomNumber % 3 == 0) {
            _setTokenURI(tokenId, METADATA_SHIBAINU);
        } else if(randomNumber % 3 == 1) {
            _setTokenURI(tokenId, METADATA_HUSKY);
        } else {
            _setTokenURI(tokenId, METADATA_BULLDOG);
        }
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
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
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
