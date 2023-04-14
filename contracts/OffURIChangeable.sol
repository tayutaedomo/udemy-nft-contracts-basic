// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";

contract OffURIChangeable is ERC721URIStorage, Ownable {
    constructor() ERC721("OffURIChangeable", "OFFC") {}

    /**
     * @dev
     * - このコントラクトをデプロイしたアドレスだけが mint 可能 onlyOwner
     * - nftMint 関数の実行アドレスに tokenId を紐付け
     */
    function nftMint(uint256 tokenId) public onlyOwner {
        _mint(_msgSender(), tokenId);
    }

    /**
     * @dev
     * - 既存の tokenId に URI を紐付け
     */
    function setTokenURI(uint256 tokenId, string calldata uri) public onlyOwner {
        _setTokenURI(tokenId, uri);
    }
}