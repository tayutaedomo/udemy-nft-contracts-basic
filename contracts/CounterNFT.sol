// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";

contract CounterNFT is ERC721URIStorage, Ownable {
    /**
     * @dev
     * - _tokenIds は Counters の全関数が利用可能
     */
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /**
     * @dev
     * - URI 設定時に誰がどの tokenID になんの URI を設定したか記録する
     */
    event TokenURIChanged(address indexed sender, uint256 indexed tokenId, string uri);

    constructor() ERC721("CounterNFT", "COUNT") {}

    /**
     * @dev
     * - このコントラクトをデプロイしたアドレスだけが mint 可能 onlyOwner
     * - tokenId をインクリメント _tokenIds.increment()
     * - nftMint 関数の実行アドレスに tokenId を紐付け
     * - mit の際に URI を設定 _setTokenURI()
     * - EVENT 発火 emit TokenURIChanged
     */
    function nftMint(string calldata uri) public onlyOwner {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(_msgSender(), newTokenId);
        _setTokenURI(newTokenId, uri);
        emit TokenURIChanged(_msgSender(), newTokenId, uri);
    }
}
