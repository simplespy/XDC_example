# XDC_example
---
### Setup the Environment
1. Open [Remix XDC Network IDE](https://remix.xinfin.network).
2. Add wallet extension to your chrome. You can choose [XinPay](https://chrome.google.com/webstore/detail/xdcpay/bocpokimicclpaiekenaeelehdjllofo) or [MetaMask](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn). If you use MetaMask, manually add XDC testnet into your network.
3. In your wallet, create an account if you don't have one, and send yourself 1000 XDC via this [faucet](https://faucet.apothem.network/).
4. You're all set, let's start writing smart contracts!

### Simple DEX
1. In Remix IDE, create two new files named `token.sol` and `exchange` (or upload files in this repo).
2. Select the compiler version as per your contracts and compile both contracts.
3. In Deploy panel, select `Injected Web3` as environment and select your funded account. 
4. Deploy token contract and submit the required transaction. If the deployment is successful, you can check the transaction by hash like [this](https://explorer.apothem.network/txs/0x9e1f103f5b08e30041ca5a4cb15eb5c5c0dbe21eafed217697915b36dcf3148a).
5. Then deploy exchange contract with token address, the token address is the contract address of token contract you just deployed in step 4.
6. Now you can start to initialize the DEX pool by sending funds and tokens (remember to approve transfer before sending tokens to the DEX contract).

### NFT minter
1. In Remix IDE, create or upload file `nftoken.sol`.
2. Deploy NFT contract and submit the required transaction. 
3. Call `toggleIsMintEnabled` function to enable minting.
4. You can mint NFT now.
