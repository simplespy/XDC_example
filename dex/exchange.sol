pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT
//modified from https://medium.com/@austin_48503/%EF%B8%8F-minimum-viable-exchange-d84f30bd0c90

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {

    // We use SafeMath library to help us prevent overflows and underflows 
    using SafeMath for uint256;
    IERC20 token;

    // @param token_addr: specify the token address you just created
    constructor(address token_addr) {
        token = IERC20(token_addr);
    }
    
    // @variable totalLiquidity: total reserves held by smart contracts to support automatic exchange
    // @variable liquidity: manage the amount of tokens deposited by each liquidity provider
    uint256 public totalLiquidity;
    mapping (address => uint256) public liquidity;

    // @func init: initialize the market by transfering your tokens and XDC, the function is payable
    // @param token: the amount of tokens used to initialize market
    function init(uint256 tokens) public payable returns (uint256) {
        require(totalLiquidity == 0, "DEX:init - already has liquidity");
        totalLiquidity = address(this).balance;
        liquidity[msg.sender] = totalLiquidity;
        require(token.transferFrom(msg.sender, address(this), tokens));
        return totalLiquidity;
    }

    // @func price: a simple formula to determine the exchange rate, with exchange fee rate 0.3%
    //              formula: ( amount of XDC in DEX ) * ( amount of tokens in DEX ) = k
    // @param input_amount: the amount of tokens you want to pay
    // @param input_reserve: the amount of reserved input tokens
    // @param output_reserve: the amount of reserved output tokens

    // example: exchange 1000 XDC for tokens, with (1000000 XDC, 1000000 Token) in the pool
    //          1000000 * 1000000 = (1000000 + 997) * (1000000 - result)
    //          result = 1000000 - 1000000 * 1000000 / (1000000 + 997) = 996
    function price(uint256 input_amount, uint256 input_reserve, uint256 output_reserve) public view returns (uint256) {
        uint256 input_amount_with_fee = input_amount.mul(997);
        uint256 numerator = input_amount_with_fee.mul(output_reserve);
        uint256 denominator = input_reserve.mul(1000).add( input_amount_with_fee);
        return numerator / denominator;
    }

    // @func XDCToToken: exchange XDC for tokens, the function is payable
    function XDCToToken() public payable returns (uint256) {
        uint256 token_reserve = token.balanceOf(address(this));
        uint256 tokens_bought = price(msg.value, address(this).balance.sub(msg.value), token_reserve);
        require(token.transfer(msg.sender, tokens_bought));
        return tokens_bought;
    }


    // @func tokenToXDC: exchange tokens for XDC
    // @param tokens: the amount of input tokens
    function tokenToXDC(uint256 tokens) public returns (uint256) {
        uint256 token_reserve = token.balanceOf(address(this));
        uint256 xdc_bought = price(tokens, token_reserve, address(this). balance);
        payable(msg.sender).transfer(xdc_bought);
        require(token. transferFrom(msg.sender, address(this), tokens));
        return xdc_bought;
    }

    // @func deposit: add XDC and token to liquidity pool at the right ratio, also update the 
    //                amount of liquidity the depositing address owns vs the totalLiquidity.
    function deposit() public payable returns (uint256) {
        uint256 xdc_reserve = address(this). balance.sub(msg.value);
        uint256 token_reserve = token.balanceOf(address(this));
        uint256 token_amount = (msg.value.mul(token_reserve) / xdc_reserve).add(1);
        uint256 liquidity_minted = msg.value.mul(totalLiquidity) / xdc_reserve;
        liquidity[msg.sender] = liquidity [msg.sender].add(liquidity_minted);
        totalLiquidity = totalLiquidity.add(liquidity_minted);
        require(token.transferFrom(msg.sender, address(this), token_amount));
        return liquidity_minted;
    }

    // @func withdraw: take XDC and tokens out at the right ratio. The actual amount of XDC and tokens 
    //            a liquidity provider withdraws will be higher than what they deposited because 
    //            of the 0.3% fees collected from each trade. This incentivizes third parties to 
    //            provide liquidity.
    // @param amount: the amount of XDC to withdraw
    function withdraw(uint256 amount) public returns (uint256, uint256) {
        uint256 token_reserve = token.balanceOf(address(this));
        uint256 xdc_amount = amount.mul(address(this).balance) / totalLiquidity;
        uint256 token_amount = amount.mul(token_reserve) / totalLiquidity;
        liquidity [msg.sender] = liquidity[msg.sender]. sub(xdc_amount);
        totalLiquidity = totalLiquidity.sub (xdc_amount);
        payable(msg.sender).transfer(xdc_amount);
        require(token.transfer(msg.sender, token_amount));
        return (xdc_amount, token_amount);
    }


}