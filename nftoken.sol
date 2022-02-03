//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFToken is ERC721, Ownable {
    uint256 public mintPrice = 0.05 * 10**18;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721("NFToken", "NFT") {
        maxSupply = 10;
        maxPerWallet = 2;

    }

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function setMaxPerWallet(uint256 maxPerWallet_) external onlyOwner {
        maxPerWallet = maxPerWallet_;
    }

    function mint() external payable {
        require (isMintEnabled, "minting not enabled");
        require(mintedWallets[msg.sender] < maxPerWallet, "exceeds max per wallet");
        require(msg.value == mintPrice, "wrong value");
        require(totalSupply < maxSupply, "sold out");

        mintedWallets[msg.sender] += 1;
        totalSupply += 1;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);

    }

}
