//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFToken is ERC721, Ownable {
    
    // @variable mintPrice: the fixed price to mint one token
    // @variable totalSupply: current supply of the token
    // @variable maxSupply: maximum amount of tokens allowed to mint
    // @variable maxPerWallet: maximum amount of tokens each wallet is allowed to mint
    // @variable isMintEnabled: a switch to enable mint
    // @variable mintedWallets: manage the amount of tokens each wallet has minted
    uint256 public mintPrice = 0.05 * 10**18;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    // This is an example ERC721 contract 
    // You can personalize your own token name and symbol by changing "NFToken", "NFT"
    constructor() ERC721("NFToken", "NFT") {
        maxSupply = 1000;
        maxPerWallet = 5;
    }

    // @func toggleIsMintEnabled: change the mintable state, only the owner of the contract can call it
    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    // @func setMaxSupply: set the value of maySupply, only the owner of the contract can call it
    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    // @func setMaxPerWallet: set the value of maxPerWallet, only the owner of the contract can call it
    function setMaxPerWallet(uint256 maxPerWallet_) external onlyOwner {
        maxPerWallet = maxPerWallet_;
    }

    // @func mint: mint a token, the function is payable
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
