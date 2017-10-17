pragma solidity ^0.4.0;
contract Product_Cost {
   address public store; //商品位置
   uint    public price; //商品價格
   uint    public amountRaised; //商店累計金額

   /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    
    event BuyThing(address buyer,  bool isContribution);
    event FundTransfer(address backer, uint amount, bool isContribution); 
    
    function Product_Cost ( address _store, uint8 _price) { 
        store = _store;
        price = _price * 1 ether;
    }
    
    function payalbe () {
        uint buypay_value = msg.value;
        uint change;
        if (buypay_value < price) throw; //購買方出價小於商品價格,不理他
        if (buypay_value >= price) { //大於商品價格,
            change = buypay_value - price; //找零
            msg.sender.send(change); //找零
        }

        balanceOf[msg.sender] += price; //商家帳戶累進金額
        amountRaised += price;

        BuyThing(msg.sender, true); //買家買到商品
    }
    
    function Withdrawal() { 
      if(msg.sender != store) throw;  //店家領錢
      store.send(amountRaised);
      FundTransfer(store, amountRaised, true);  
    }

}