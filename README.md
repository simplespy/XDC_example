# XDC_example
---
### Setup the Environment
1. Open [Remix XDC Network IDE](https://remix.xinfin.network).
2. Add wallet extension to your chrome. You can choose [XinPay](https://chrome.google.com/webstore/detail/xdcpay/bocpokimicclpaiekenaeelehdjllofo) or [MetaMask](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn). If you use MetaMask, manually add XDC testnet into your network with the following parameters:
	
	```
	Network Name: XinFin Apothem Testnet
	New RPC URL: https://rpc.apothem.network
	Chain ID: 51
	```

3. In your wallet, create an account if you don't have one, and send yourself 1000 XDC via this [faucet](https://faucet.apothem.network/).
4. You're all set, let's start writing smart contracts!

### Simple DEX
In this example, we will create an ERC20 token and a decentralized exchange smart contract to swap the token for XDC and see how smart contracts enable automatic market. 

1. In Remix IDE, create two new files named `token.sol` and `exchange.sol` (or upload files in this repo).
2. Select the compiler version as per your contracts and compile both contracts.
3. In Deploy panel, select `Injected Web3` as environment and select your funded account. 
4. Deploy token contract and submit the required transaction. If the deployment is successful, you can check the transaction by hash like [this](https://explorer.apothem.network/txs/0x9e1f103f5b08e30041ca5a4cb15eb5c5c0dbe21eafed217697915b36dcf3148a).
5. Then deploy exchange contract with token address, the token address is the contract address of token contract you just deployed in step 4.
6. Now you can start to initialize the DEX pool by sending funds and tokens (remember to approve transfer before sending tokens to the DEX contract).

### NFT minter
In this example, we will create an ERC721 token (also called non-fungible token) minter to mint NFTs at given price and see how NFTs differ from ERC20 tokens.

1. In Remix IDE, create or upload file `nftoken.sol`.
2. Deploy NFT contract and submit the required transaction (when the `deploy` button is red, it means you need to attach some XDC coins to your transaction). 
3. Call `toggleIsMintEnabled` function to enable minting.
4. You can mint NFT now by call `mint` function with payment attached.
5. Check the ownership of your token by calling `ownerOf` function with your `tokenId`.


### References
1. https://medium.com/xinfin/deploy-smart-contract-on-xinfin-testnet-through-xinfin-remix-and-xinpay-dfbbf9dcc3f7
2. https://medium.com/@austin_48503/%EF%B8%8F-minimum-viable-exchange-d84f30bd0c90