// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";

contract OnlyOwnerMintWithModifier is ERC721 {

    /**
     * @dev 
     * - このコントラクトをデプロイしたアドレス用変数 owner
     */
    address public owner;

    constructor() ERC721("OnlyOwnerMintWithModifier", "OWNERMOD") {
        owner = _msgSender();
    }

    /**
     * @dev
     * - このコントラクトをデプロイしたアドレスだけに制御する modifier
     */
    modifier onlyOwner {
        require(owner == _msgSender(), "Caller is not the owner.");
        _;
    }

    /**
     * @dev
     * - このコントラクトをデプロイしたアドレスだけが mint 可能 onlyOwner
     * - nftMint 関数の実行アドレスに tokenId を紐付け
     */
    function nftMint(uint256 tokenId) public onlyOwner {
        _mint(_msgSender(), tokenId);
    }
}
